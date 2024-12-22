#!/bin/bash

# Simple Port Scanner

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <target_ip> <port_range>"
    echo "Example: $0 192.168.1.1 1-1000"
    exit 1
fi

TARGET=$1
PORT_RANGE=$2

echo "Scanning ports on $TARGET in range $PORT_RANGE..."

IFS="-" read START_PORT END_PORT <<< "$PORT_RANGE"

for ((port=$START_PORT; port<=$END_PORT; port++))
do
    timeout 1 bash -c "echo >/dev/tcp/$TARGET/$port" 2>/dev/null &&
    echo "Port $port is open" ||
    echo "Port $port is closed"
done

echo "Scan complete."

