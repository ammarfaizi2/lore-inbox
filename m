Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293746AbSCPHN0>; Sat, 16 Mar 2002 02:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293749AbSCPHNQ>; Sat, 16 Mar 2002 02:13:16 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:26119 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S293746AbSCPHNE>; Sat, 16 Mar 2002 02:13:04 -0500
Subject: 2.5.7-pre2 -- ip_conntrack_standalone.c:41: In function
	`kill_proto': structure has no member named `dst'
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 15 Mar 2002 23:12:09 -0800
Message-Id: <1016262729.6501.305.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ip_conntrack_standalone.c: In function `kill_proto':
ip_conntrack_standalone.c:41: structure has no member named `dst'
ip_conntrack_standalone.c:43: warning: control reaches end of non-void
function
make[3]: *** [ip_conntrack_standalone.o] Error 1
make[3]: Leaving directory `/usr/src/linux/net/ipv4/netfilter'

CONFIG_PACKET=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IRC=y
CONFIG_IP_NF_QUEUE=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_MIRROR=y
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y

