Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265713AbTABGDn>; Thu, 2 Jan 2003 01:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265754AbTABGDn>; Thu, 2 Jan 2003 01:03:43 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:62162 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S265713AbTABGDm>; Thu, 2 Jan 2003 01:03:42 -0500
Subject: 2.5.54 -- ohci-dbg.c: 358: In function `show_list': `data1'
	undeclared (first use in this function)
From: Miles Lane <miles.lane@attbi.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: David Brownell <david-b@pacbell.net>
Content-Type: text/plain
Organization: 
Message-Id: <1041487926.11532.83.camel@bellybutton.attbi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 01 Jan 2003 22:12:06 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  gcc -Wp,-MD,drivers/usb/host/.ohci-hcd.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ohci_hcd
-DKBUILD_MODNAME=ohci_hcd   -c -o drivers/usb/host/ohci-hcd.o drivers/usb/host/ohci-hcd.c
In file included from drivers/usb/host/ohci-hcd.c:137:
drivers/usb/host/ohci-dbg.c: In function `show_list':
drivers/usb/host/ohci-dbg.c:358: `data1' undeclared (first use in this function)
drivers/usb/host/ohci-dbg.c:358: (Each undeclared identifier is reported only once
drivers/usb/host/ohci-dbg.c:358: for each function it appears in.)
drivers/usb/host/ohci-dbg.c:358: `data0' undeclared (first use in this function)
make[3]: *** [drivers/usb/host/ohci-hcd.o] Error 1

# USB Options
#
CONFIG_USB=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_OHCI_HCD=y

