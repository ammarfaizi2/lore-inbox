Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292269AbSBOXYp>; Fri, 15 Feb 2002 18:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292270AbSBOXY0>; Fri, 15 Feb 2002 18:24:26 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:3603 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S292269AbSBOXYX>; Fri, 15 Feb 2002 18:24:23 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A76A0@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        "'Jeff Garzik'" <jgarzik@mandrakesoft.com>
Cc: "'Russell King'" <rmk@arm.linux.org.uk>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI device ID Oxford 952 UART
Date: Fri, 15 Feb 2002 15:25:21 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects PCI device id in pci_ids.h for Oxford Semi OX16PCI952
PCI/dual 16950 UART chip, and adds this entry to pci.ids.  I downloaded the
datasheet today and verified that 9521 is the correct device id.

Generated for 2.4.18-rc1, should also be applied to 2.5.

Thanks in
Ed Vance

diff -urN -X dontdiff.txt linux-2.4.18-rc1/drivers/pci/pci.ids
rc1-ml/drivers/pci/pci.ids
--- linux-2.4.18-rc1/drivers/pci/pci.ids	Fri Feb 15 14:24:19 2002
+++ rc1-ml/drivers/pci/pci.ids	Fri Feb 15 14:49:07 2002
@@ -3952,6 +3952,7 @@
 1413  Addonics
 1414  Microsoft Corporation
 1415  Oxford Semiconductor Ltd
+	9521  Oxford Semi OX16PCI952 PCI/dual 16950 UART
 1416  Multiwave Innovation pte Ltd
 1417  Convergenet Technologies Inc
 1418  Kyushu electronics systems Inc
diff -urN -X dontdiff.txt linux-2.4.18-rc1/include/linux/pci_ids.h
rc1-ml/include/linux/pci_ids.h
--- linux-2.4.18-rc1/include/linux/pci_ids.h	Fri Feb 15 14:24:27 2002
+++ rc1-ml/include/linux/pci_ids.h	Fri Feb 15 14:51:35 2002
@@ -1474,9 +1474,9 @@
 #define PCI_VENDOR_ID_OXSEMI		0x1415
 #define PCI_DEVICE_ID_OXSEMI_12PCI840	0x8403
 #define PCI_DEVICE_ID_OXSEMI_16PCI954	0x9501
-#define PCI_DEVICE_ID_OXSEMI_16PCI952	0x950A
 #define PCI_DEVICE_ID_OXSEMI_16PCI95N	0x9511
 #define PCI_DEVICE_ID_OXSEMI_16PCI954PP	0x9513
+#define PCI_DEVICE_ID_OXSEMI_16PCI952	0x9521
 
 #define PCI_VENDOR_ID_AIRONET		0x14b9
 #define PCI_DEVICE_ID_AIRONET_4800_1	0x0001


---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
PH 714.777.8800 x335  Fax 714.777.8807  http://www.macrolink.com 
----------------------------------------------------------------


