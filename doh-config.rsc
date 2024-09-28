# Download CA certs
/tool fetch url=https://curl.se/ca/cacert.pem

# Install CA certs
/certificate import file-name=cacert.pem passphrase=""

# Set DoH
/ip dns
set allow-remote-requests=yes use-doh-server=https://dns.google/dns-query verify-doh-cert=yes

# Script to check if DoH server is running (optional, verification is performed every 15 minutes)
/system scheduler
add interval=15m name=check-doh-server on-event="# Flag with status of the serv\
    er\r\
    \n:local running yes;\r\
    \n# Domain to test\r\
    \n:local domain \"mikrotiktraining.cauuu\";\r\
    \n# DoH Server URL\r\
    \n:local url \"https://dns.google.com/resolve\\\?name=\$domain%26type=A\";\
    \r\
    \n\r\
    \n# Send a DNS  query\r\
    \n:do {\r\
    \n    tool fetch url=\$url output=none dst-path=result http-header-field=ac\
    cept:application/dns-json\r\
    \n} on-error={:set running no}\r\
    \n:if \$running do={\r\
    \n  /ip dns set servers=\"\" use-doh-server=\"https://dns.google/dns-query\
    \" verify-doh-cert=yes;:log warning \"DNS over HTTPS server is running\"\r\
    \n} else={\r\
    \n# Disable DoH.\r\
    \n     /ip dns set use-doh-server=\"\";:log warning \"DNS over HTTPS switch\
    ed off!\"\r\
    \n    }" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=2024-09-28 start-time=20:31:01


