Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131804AbRBKDBW>; Sat, 10 Feb 2001 22:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131871AbRBKDBM>; Sat, 10 Feb 2001 22:01:12 -0500
Received: from gadolinium.btinternet.com ([194.73.73.111]:5338 "EHLO
	gadolinium.btinternet.com") by vger.kernel.org with ESMTP
	id <S131851AbRBKDAz>; Sat, 10 Feb 2001 22:00:55 -0500
Date: Sun, 11 Feb 2001 03:00:35 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon.local>
To: Alan Cox <alan@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Obsolete info in configure.help
Message-ID: <Pine.LNX.4.31.0102110258540.4383-100000@athlon.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alan,
 If the 8129 is to be removed, may as well remove its appropriate
entry in configure.help

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

diff -urN --exclude-from=/home/davej/.exclude linux/Documentation/Configure.help linux-dj/Documentation/Configure.help
--- linux/Documentation/Configure.help	Sat Feb 10 02:49:29 2001
+++ linux-dj/Documentation/Configure.help	Sat Feb 10 03:06:08 2001
@@ -8678,22 +8678,6 @@
   The module will be called ni65.o. If you want to compile it as a
   module, say M here and read Documentation/modules.txt as well as
   Documentation/networking/net-modules.txt.
-
-RealTek 8129 (not 8019/8029/8139!) support (EXPERIMENTAL)
-CONFIG_RTL8129
-  This is NOT for RTL-8139 cards.  Instead, select the 8139too driver
-  (CONFIG_8139TOO).
-  This is a driver for the Fast Ethernet PCI network cards based on
-  the RTL8129 chip. If you have one of those, say Y and
-  read the Ethernet-HOWTO, available from
-  http://www.linuxdoc.org/docs.html#howto .
-
-  Note: the 8029 is a NE2000 PCI clone, you can use the NE2K-PCI driver.
-
-  If you want to compile this driver as a module ( = code which can be
-  inserted in and removed from the running kernel whenever you want),
-  say M here and read Documentation/modules.txt. This is recommended.
-  The module will be called rtl8129.o.

 RealTek RTL-8139 PCI Fast Ethernet Adapter support
 CONFIG_8139TOO

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
