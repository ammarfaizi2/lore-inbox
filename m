Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267125AbTBLOEF>; Wed, 12 Feb 2003 09:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267130AbTBLOCr>; Wed, 12 Feb 2003 09:02:47 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:43904 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267125AbTBLOCj>; Wed, 12 Feb 2003 09:02:39 -0500
Date: Wed, 12 Feb 2003 23:11:21 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.60 (26/34) pci-update
Message-ID: <20030212141121.GA1551@yuzuki.cinet.co.jp>
References: <20030212131737.GA1551@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212131737.GA1551@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.60 (26/34).

Updates drivers/pci/quirks.c in 2.5.50-ac1.

- Osamu Tomita

diff -Nru linux-2.5.53/drivers/pci/quirks.c linux98-2.5.53/drivers/pci/quirks.c
--- linux-2.5.53/drivers/pci/quirks.c	2002-12-24 14:19:26.000000000 +0900
+++ linux98-2.5.53/drivers/pci/quirks.c	2002-12-26 14:24:57.000000000 +0900
@@ -551,6 +551,8 @@
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C596,	quirk_isa_dma_hangs },
 	{ PCI_FIXUP_FINAL,      PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82371SB_0,  quirk_isa_dma_hangs },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_1,	quirk_isa_dma_hangs },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_2,	quirk_isa_dma_hangs },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_3,	quirk_isa_dma_hangs },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_868,		quirk_s3_64M },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_968,		quirk_s3_64M },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82437, 	quirk_triton }, 
