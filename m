Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278387AbRJMUFW>; Sat, 13 Oct 2001 16:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278388AbRJMUFM>; Sat, 13 Oct 2001 16:05:12 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:27142 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S278387AbRJMUFH>; Sat, 13 Oct 2001 16:05:07 -0400
Message-ID: <3BC89C7E.6040003@megapathdsl.net>
Date: Sat, 13 Oct 2001 12:56:46 -0700
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4+) Gecko/20010925
X-Accept-Language: en-us
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.13-pre2 -- Build error -- appletalk.o: In function `ipddp_xmit' undefined reference to `atalk_find_dev_addr' and `aarp_send_ddp' 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/appletalk/appletalk.o: In function `ipddp_xmit':
drivers/net/appletalk/appletalk.o(.text+0x47): undefined reference to 
`atalk_find_dev_addr'
drivers/net/appletalk/appletalk.o(.text+0x120): undefined reference to 
`aarp_send_ddp'
drivers/net/appletalk/appletalk.o: In function `ipddp_create':
drivers/net/appletalk/appletalk.o(.text+0x187): undefined reference to 
`atrtr_get_dev'
make: *** [vmlinux] Error 1

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_SYN_COOKIES=y
CONFIG_ATALK=m

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# Appletalk devices
#
CONFIG_APPLETALK=y
# CONFIG_LTPC is not set
# CONFIG_COPS is not set
CONFIG_IPDDP=y
CONFIG_IPDDP_ENCAP=y
CONFIG_IPDDP_DECAP=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL3=y
CONFIG_VORTEX=y

