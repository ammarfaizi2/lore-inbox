Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287193AbSBKFIb>; Mon, 11 Feb 2002 00:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287208AbSBKFIV>; Mon, 11 Feb 2002 00:08:21 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:59148 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S287193AbSBKFIH>; Mon, 11 Feb 2002 00:08:07 -0500
Subject: 2.5.4-pre6 -- debug.c:190: In function `usb_stor_print_Scsi_Cmnd':
	structure has no member named `address'
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 10 Feb 2002 21:05:07 -0800
Message-Id: <1013403908.30864.41.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_USB=m
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_LONG_TIMEOUT=y
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_ALT=m
CONFIG_USB_OHCI=m
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE -I../../scsi/
-DKBUILD_BASENAME=debug  -c -o debug.o debug.c
debug.c: In function `usb_stor_print_Scsi_Cmnd':
debug.c:190: structure has no member named `address'
...
make[3]: *** [debug.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/usb/storage'

