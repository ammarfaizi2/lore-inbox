Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267038AbSK2NYW>; Fri, 29 Nov 2002 08:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267039AbSK2NYW>; Fri, 29 Nov 2002 08:24:22 -0500
Received: from lucidpixels.com ([66.45.37.187]:386 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id <S267038AbSK2NYV>;
	Fri, 29 Nov 2002 08:24:21 -0500
Message-ID: <3DE76C3F.5010601@lucidpixels.com>
Date: Fri, 29 Nov 2002 08:31:43 -0500
From: jpiszcz <jpiszcz@lucidpixels.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Question with printk warnings in ip_conntrack with 2.4.20.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nov 29 03:29:26 lucidpixels kernel: ip_conntrack: max number of expected 
connections 1 of ftp reached for 192.168.xxx.xxx->129.128.5.191, reusing
Nov 29 03:29:30 lucidpixels kernel: ip_conntrack: max number of expected 
connections 1 of ftp reached for 192.168.xxx.xxx->129.132.7.170, reusing
Nov 29 03:29:36 lucidpixels kernel: ip_conntrack: max number of expected 
connections 1 of ftp reached for 192.168.xxx.xxx->195.113.31.123, reusing

These fill up my logs (kern.info) which I use for logging iptables 
blocked packets.
Is there anyway to turn this feature off dynamically or should one just 
comment out line #970 in 
/usr/src/linux/net/ipv4/netfilter/ip_conntrack_core.c ?

Please cc me as I am not subscribed to the list, thanks.



