Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266359AbSLOLJf>; Sun, 15 Dec 2002 06:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266363AbSLOLJf>; Sun, 15 Dec 2002 06:09:35 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:36414 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S266359AbSLOLJe>; Sun, 15 Dec 2002 06:09:34 -0500
Message-ID: <3DFC6455.89B014CC@cinet.co.jp>
Date: Sun, 15 Dec 2002 20:15:33 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.50-ac1-pc98smp i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 addtional for 2.5.50-ac1 (5/21)
References: <3DFC50E9.656B96D0@cinet.co.jp>
Content-Type: multipart/mixed;
 boundary="------------BEA2C77D543A6F1511AC30B2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BEA2C77D543A6F1511AC30B2
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

NEC PC-9800 subarchitecture support patch for 2.5.50-ac1(5/21)
This is updates for drivers/pci/quirks.c.
Add entry for PCI to C-Bus bridge Rev.2 and Rev.3.

diffstat:
 drivers/pci/quirks.c |    2 ++
 1 files changed, 2 insertions(+)


Regards,
Osamu Tomita
--------------BEA2C77D543A6F1511AC30B2
Content-Type: text/plain; charset=iso-2022-jp;
 name="pci-quirks-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci-quirks-update.patch"

diff -Nru linux-2.5.50-ac1/drivers/pci/quirks.c.orig linux-2.5.50-ac1/drivers/pci/quirks.c
--- linux-2.5.50-ac1/drivers/pci/quirks.c.orig	2002-12-12 22:47:27.000000000 +0900
+++ linux-2.5.50-ac1/drivers/pci/quirks.c	2002-12-14 12:41:28.000000000 +0900
@@ -530,6 +530,8 @@
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C596,	quirk_isa_dma_hangs },
 	{ PCI_FIXUP_FINAL,      PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82371SB_0,  quirk_isa_dma_hangs },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_1,	quirk_isa_dma_hangs },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_2,	quirk_isa_dma_hangs },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_3,	quirk_isa_dma_hangs },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_868,		quirk_s3_64M },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_968,		quirk_s3_64M },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82437, 	quirk_triton }, 

--------------BEA2C77D543A6F1511AC30B2--

