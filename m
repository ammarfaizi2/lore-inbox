Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293119AbSCRWQ4>; Mon, 18 Mar 2002 17:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293129AbSCRWQq>; Mon, 18 Mar 2002 17:16:46 -0500
Received: from ep09.kernel.pl ([212.87.11.162]:43326 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S293119AbSCRWQg>;
	Mon, 18 Mar 2002 17:16:36 -0500
Message-ID: <006301c1ceca$87937c70$0201a8c0@WITEK>
From: =?iso-8859-2?Q?Witek_Kr=EAcicki?= <adasi@kernel.pl>
To: <linux-kernel@vger.kernel.org>
Subject: [2.5.7] compilation problem
Date: Mon, 18 Mar 2002 23:16:16 +0100
Organization: PLD Team
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[3]: Entering `/home/users/adasi/rpm/BUILD/linux-2.5.7/net/core'
egcs -D__KERNEL__ -I/home/users/adasi/rpm/BUILD/linux-2.5.7/include -Wall -W
strict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasi
ng -fno-common -pipe  -march=i686   -DKBUILD_BASENAME=dev  -c -o dev.o dev.c
dev.c: In function `netif_receive_skb':
dev.c:1465: void value not ignored as it ought to be

Part of .config:
<cite>
#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_LARGE_TABLES=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y
</cite>

How to fix it?
--
Witek Krecicki
adasi@pld.org.pl

