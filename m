Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266197AbUFULpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266197AbUFULpK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 07:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266199AbUFULpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 07:45:10 -0400
Received: from tao.natur.cuni.cz ([195.113.56.1]:4101 "EHLO tao.natur.cuni.cz")
	by vger.kernel.org with ESMTP id S266197AbUFULow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 07:44:52 -0400
X-Obalka-From: mmokrejs@natur.cuni.cz
X-Obalka-To: <linux-kernel@vger.kernel.org>
Date: Mon, 21 Jun 2004 13:44:46 +0200 (CEST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: Linux Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Cannot compile linux-2.4.27-rc1 ... ipt_REJECT.c
Message-ID: <Pine.OSF.4.51.0406211343160.157782@tao.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  has someone seen the following error? I can provide .config if required.
I think I've seen this in 2.4.27-pre6, not in -pre3.
Please Cc: me in replies. Thanks.
Martin

gcc -D__KERNEL__ -I/usr/src/linux-2.4.27-rc1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.27-rc1/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=ipt_REJECT  -c -o ipt_REJECT.o ipt_REJECT.c
In file included from ipt_REJECT.c:8:
/usr/src/linux-2.4.27-rc1/include/linux/skbuff.h: In function `kmap_skb_frag':
/usr/src/linux-2.4.27-rc1/include/linux/skbuff.h:1121: warning: use of compound expressions as lvalues is deprecated
/usr/src/linux-2.4.27-rc1/include/linux/skbuff.h: In function `kunmap_skb_frag':
/usr/src/linux-2.4.27-rc1/include/linux/skbuff.h:1130: warning: use of compound expressions as lvalues is deprecated
In file included from /usr/src/linux-2.4.27-rc1/include/linux/icmpv6.h:144,
                 from /usr/src/linux-2.4.27-rc1/include/net/sock.h:44,
                 from /usr/src/linux-2.4.27-rc1/include/net/icmp.h:24,
                 from ipt_REJECT.c:12:
/usr/src/linux-2.4.27-rc1/include/linux/netdevice.h: In function `__netif_rx_schedule':
/usr/src/linux-2.4.27-rc1/include/linux/netdevice.h:775: warning: use of compound expressions as lvalues is deprecated
/usr/src/linux-2.4.27-rc1/include/linux/netdevice.h: In function `netif_rx_reschedule':
/usr/src/linux-2.4.27-rc1/include/linux/netdevice.h:800: warning: use of compound expressions as lvalues is deprecated
/usr/src/linux-2.4.27-rc1/include/linux/netdevice.h: In function `netif_tx_disable':
/usr/src/linux-2.4.27-rc1/include/linux/netdevice.h:851: warning: use of compound expressions as lvalues is deprecated
/usr/src/linux-2.4.27-rc1/include/linux/netdevice.h:853: warning: use of compound expressions as lvalues is deprecated
In file included from /usr/src/linux-2.4.27-rc1/include/net/icmp.h:24,
                 from ipt_REJECT.c:12:
/usr/src/linux-2.4.27-rc1/include/net/sock.h: In function `sock_orphan':
/usr/src/linux-2.4.27-rc1/include/net/sock.h:1088: warning: use of compound expressions as lvalues is deprecated
/usr/src/linux-2.4.27-rc1/include/net/sock.h:1092: warning: use of compound expressions as lvalues is deprecated
/usr/src/linux-2.4.27-rc1/include/net/sock.h: In function `sock_graft':
/usr/src/linux-2.4.27-rc1/include/net/sock.h:1097: warning: use of compound expressions as lvalues is deprecated
/usr/src/linux-2.4.27-rc1/include/net/sock.h:1101: warning: use of compound expressions as lvalues is deprecated
In file included from /usr/src/linux-2.4.27-rc1/include/net/route.h:29,
                 from /usr/src/linux-2.4.27-rc1/include/net/ip.h:32,
                 from ipt_REJECT.c:13:
/usr/src/linux-2.4.27-rc1/include/net/inetpeer.h: In function `inet_putpeer':
/usr/src/linux-2.4.27-rc1/include/net/inetpeer.h:43: warning: use of compound expressions as lvalues is deprecated
/usr/src/linux-2.4.27-rc1/include/net/inetpeer.h:51: warning: use of compound expressions as lvalues is deprecated
/usr/src/linux-2.4.27-rc1/include/net/inetpeer.h: In function `inet_getid':
/usr/src/linux-2.4.27-rc1/include/net/inetpeer.h:60: warning: use of compound expressions as lvalues is deprecated
/usr/src/linux-2.4.27-rc1/include/net/inetpeer.h:62: warning: use of compound expressions as lvalues is deprecated
ipt_REJECT.c: In function `send_unreach':
/usr/src/linux-2.4.27-rc1/include/net/ip.h:140: sorry, unimplemented: inlining failed in call to 'ip_finish_output_Rfeff06db': function body not available
ipt_REJECT.c:138: sorry, unimplemented: called from here
make[2]: *** [ipt_REJECT.o] Error 1


$ gcc --version
gcc (GCC) 3.4.0 20040601 (Gentoo Linux 3.4.0-r6, ssp-3.4-2, pie-8.7.6.3)
Copyright (C) 2004 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
$
