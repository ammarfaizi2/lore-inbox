Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277894AbRJNWKI>; Sun, 14 Oct 2001 18:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277895AbRJNWJ6>; Sun, 14 Oct 2001 18:09:58 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:29199 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S277894AbRJNWJu>; Sun, 14 Oct 2001 18:09:50 -0400
Subject: 2.4.12-ac2 -- appletalk.o: In function `ipddp_xmit': undefined
	reference to `atalk_find_dev_addr' and `aarp_send_ddp'
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99 (Preview Release)
Date: 14 Oct 2001 15:01:24 -0700
Message-Id: <1003096885.11949.21.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


drivers/net/appletalk/appletalk.o: In function `ipddp_xmit':
drivers/net/appletalk/appletalk.o(.text+0x47): undefined reference to `atalk_find_dev_addr'
drivers/net/appletalk/appletalk.o(.text+0x120): undefined reference to `aarp_send_ddp'
drivers/net/appletalk/appletalk.o: In function `ipddp_create':
drivers/net/appletalk/appletalk.o(.text+0x187): undefined reference to `atrtr_get_dev'
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


