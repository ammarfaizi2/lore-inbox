Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271165AbVBERAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271165AbVBERAX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 12:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271245AbVBERAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 12:00:23 -0500
Received: from 34.67-18-129.reverse.theplanet.com ([67.18.129.34]:60994 "EHLO
	krish.dnshostnetwork.net") by vger.kernel.org with ESMTP
	id S271165AbVBERAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 12:00:00 -0500
Message-ID: <008501c50ba4$1ed1b890$8d00150a@dreammac>
From: "Pankaj Agarwal" <pankaj@toughguy.net>
To: <linux-kernel@vger.kernel.org>, "Linux Net" <linux-net@vger.kernel.org>
Subject: Help - Getting an error when trying to add prio to tables....
Date: Sat, 5 Feb 2005 22:29:48 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - krish.dnshostnetwork.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - toughguy.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am getting the errors given below, when I am trying to add the prio to any 
table. What can be the problem and how can i resolve it.... I have also 
tried adding the following parameters in /usr/src/.config but to no benefit

CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_LARGE_TABLES=y

Kindly help

[root /root]# ip rule
RTNETLINK answers: Invalid argument
Dump terminated

[root /root]# ip rule list
RTNETLINK answers: Invalid argument
Dump terminated

[root /root]# ip rule list table main
"ip rule show" need not eny arguments.

[root /root]# ip rule show
RTNETLINK answers: Invalid argument
Dump terminated

[root /root]# ip rule add prio 50 table main
RTNETLINK answers: Invalid argument

[root /root]# ip route
192.168.2.5 dev eth1  scope link
61.11.104.63 dev eth0  scope link
220.227.153.48/28 dev eth2  proto kernel  scope link  src 220.227.153.61
192.168.2.0/24 dev eth1  proto kernel  scope link  src 192.168.2.5
61.11.104.0/24 dev eth0  proto kernel  scope link  src 61.11.104.63
127.0.0.0/8 dev lo  scope link
default via 61.11.104.1 dev eth0

[root /root]# ip
Usage: ip [ OPTIONS ] OBJECT { COMMAND | help }
where  OBJECT := { link | addr | route | rule | neigh | tunnel |
                   maddr | mroute | monitor }
       OPTIONS := { -V[ersion] | -s[tatistics] | -r[esolve] |
                    -f[amily] { inet | inet6 | ipx | dnet | link }
| -o[neline] }

Thanks and Regards,

Pankaj Agarwal

