Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267303AbSLEXVp>; Thu, 5 Dec 2002 18:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267322AbSLEXVp>; Thu, 5 Dec 2002 18:21:45 -0500
Received: from lucidpixels.com ([66.45.37.187]:3500 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id <S267303AbSLEXVo>;
	Thu, 5 Dec 2002 18:21:44 -0500
Message-ID: <3DEFE14F.8040403@lucidpixels.com>
Date: Thu, 05 Dec 2002 18:29:19 -0500
From: jpiszcz <jpiszcz@lucidpixels.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: Question with printk warnings in ip_conntrack with 2.4.20.]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Stange?  I am just using vcheck (perl script) that goes out and checks 
out software for the latest versions.

Here is an example of what happens when I run it:
http://www.tu-ilmenau.de/~gomar/stuff/vcheck/

All it does is goes out to http/ftps site, matches a regex to check for 
the latest version of whatever you have, ie: sample entry:

prog util-linux = {
  version   = 2.11y
  urgency   = high
  dl        = no
  lastcheck = "2002-12-05 06:07"
  url       = 
ftp://ftp.win.tue.nl/pub/home/aeb/linux-local/utils/util-linux/
  regex     = util-linux-(__VER__)\.tar
}

This program is very useful and those warnings highly annoying. :)
Will there possibly be a /proc or kernel config option for warnings such 
as these?


Dec  5 18:20:23 lucidpixels kernel: ip_conntrack: max number of expected 
connections 1 of ftp reached for 192.168.168.12->199.232.41.7, reusing
Dec  5 18:20:25 lucidpixels kernel: ip_conntrack: max number of expected 
connections 1 of ftp reached for 192.168.168.12->204.214.92.161, reusing
Dec  5 18:20:27 lucidpixels kernel: ip_conntrack: max number of expected 
connections 1 of ftp reached for 192.168.168.12->209.249.29.67, reusing
Dec  5 18:20:30 lucidpixels kernel: ip_conntrack: max number of expected 
connections 1 of ftp reached for 192.168.168.12->209.249.29.67, reusing
Dec  5 18:20:35 lucidpixels kernel: ip_conntrack: max number of expected 
connections 1 of ftp reached for 192.168.168.12->195.37.77.171, reusing
Dec  5 18:21:00 lucidpixels kernel: ip_conntrack: max number of expected 
connections 1 of ftp reached for 192.168.168.12->216.180.224.6, reusing
Dec  5 18:21:06 lucidpixels kernel: BLOCK: IN=eth1 OUT= 
MAC=00:a0:24:05:eb:87:00:c0:7b:b1:8d:3b:08:00 SRC=130.239.18.137 
DST=66.45.37.187 LEN=1500 TOS=0x00 PREC=0x00 TTL=232 ID=47301 DF 
PROTO=ICMP TYPE=8 CODE=0 ID=0 SEQ=0
Dec  5 18:21:18 lucidpixels kernel: ip_conntrack: max number of expected 
connections 1 of ftp reached for 192.168.168.12->130.239.18.137, reusing
Dec  5 18:21:29 lucidpixels kernel: ip_conntrack: max number of expected 
connections 1 of ftp reached for 192.168.168.12->130.239.18.137, reusing
Dec  5 18:21:38 lucidpixels kernel: ip_conntrack: max number of expected 
connections 1 of ftp reached for 192.168.168.12->195.40.6.41, reusing
Dec  5 18:21:42 lucidpixels kernel: ip_conntrack: max number of expected 
connections 1 of ftp reached for 192.168.168.12->204.80.150.47, reusing
Dec  5 18:21:44 lucidpixels kernel: ip_conntrack: max number of expected 
connections 1 of ftp reached for 192.168.168.12->199.232.41.7, reusing
Dec  5 18:21:47 lucidpixels kernel: BLOCK: IN=eth1 OUT= 
MAC=00:a0:24:05:eb:87:00:c0:7b:b1:8d:3b:08:00 SRC=130.239.18.137 
DST=66.45.37.187 LEN=1500 TOS=0x00 PREC=0x00 TTL=232 ID=28140 DF 
PROTO=ICMP TYPE=8 CODE=0 ID=0 SEQ=2
Dec  5 18:21:57 lucidpixels kernel: ip_conntrack: max number of expected 
connections 1 of ftp reached for 192.168.168.12->199.232.41.7, reusing
Dec  5 18:22:20 lucidpixels last message repeated 3 times
Dec  5 18:22:21 lucidpixels kernel: BLOCK: IN=eth1 OUT= 
MAC=00:a0:24:05:eb:87:00:c0:7b:b1:8d:3b:08:00 SRC=130.239.18.173 
DST=66.45.37.187 LEN=1500 TOS=0x00 PREC=0x00 TTL=232 ID=48463 DF 
PROTO=ICMP TYPE=8 CODE=0 ID=0 SEQ=0
Dec  5 18:22:25 lucidpixels kernel: ip_conntrack: max number of expected 
connections 1 of ftp reached for 192.168.168.12->130.239.18.173, reusing
Dec  5 18:22:34 lucidpixels kernel: ip_conntrack: max number of expected 
connections 1 of ftp reached for 192.168.168.12->130.239.18.137, reusing
Dec  5 18:22:36 lucidpixels kernel: ip_conntrack: max number of expected 
connections 1 of ftp reached for 192.168.168.12->199.232.41.7, reusing
Dec  5 18:22:42 lucidpixels kernel: ip_conntrack: max number of expected 
connections 1 of ftp reached for 192.168.168.12->143.239.1.60, reusing
Dec  5 18:22:43 lucidpixels kernel: BLOCK: IN=eth1 OUT= 
MAC=00:a0:24:05:eb:87:00:c0:7b:b1:8d:3b:08:00 SRC=130.239.18.173 
DST=66.45.37.187 LEN=1500 TOS=0x00 PREC=0x00 TTL=232 ID=63220 DF 
PROTO=ICMP TYPE=8 CODE=0 ID=0 SEQ=2

Harald Welte wrote:

>>Nov 29 03:29:26 lucidpixels kernel: ip_conntrack: max number of expected 
>>connections 1 of ftp reached for 192.168.xxx.xxx->129.128.5.191, reusing
>>Nov 29 03:29:30 lucidpixels kernel: ip_conntrack: max number of expected 
>>connections 1 of ftp reached for 192.168.xxx.xxx->129.132.7.170, reusing
>>Nov 29 03:29:36 lucidpixels kernel: ip_conntrack: max number of expected 
>>connections 1 of ftp reached for 192.168.xxx.xxx->195.113.31.123, reusing
>>
>>These fill up my logs (kern.info) which I use for logging iptables 
>>blocked packets.
>>    
>>
>
>the issue is that somebody is doing something very strange to your ftp
>server.  Inside an FTP session, there's always only one expectation,
>since there is only one unestablished data session per control session
>at any given point in time.
>
>  
>
>>Is there anyway to turn this feature off dynamically or should one just 
>>comment out line #970 in 
>>/usr/src/linux/net/ipv4/netfilter/ip_conntrack_core.c ?
>>    
>>
>
>feel free to remove the comment.  but in normal ftp protocol behaviour,
>the lines above should never be printed.
>
>  
>

