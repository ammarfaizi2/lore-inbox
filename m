Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbVAKDJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbVAKDJd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 22:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbVAKC6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 21:58:42 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:44441 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262538AbVAKCmo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 21:42:44 -0500
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC (xSeries Solutions)
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.10] Updated pci.ids for new IBM bridge
Date: Mon, 10 Jan 2005 18:42:42 -0800
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501101842.42267.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update patch for a forthcoming bridge.

X-Signed-Off-By: James Cleverdon <jamesclv@us.ibm.com>


diff -pru 2.6.10/drivers/pci/pci.ids t10/drivers/pci/pci.ids
--- 2.6.10/drivers/pci/pci.ids	2004-12-24 13:34:57.000000000 -0800
+++ t10/drivers/pci/pci.ids	2005-01-04 16:36:28.284492825 -0800
@@ -998,6 +998,7 @@
 	0269  10/100/1000 Base-TX Ethernet Adapter (PCI-X)
 	028C  Citrine chipset SCSI controller
 		1014 02BE  Dual Channel PCI-X U320 DDR SCSI RAID Adapter (571B)
+	02a1  X-Architecture Bridge rev 3 [Summit2/EXA-32e]
 	0302  X-Architecture Bridge [Summit]
 	ffff  MPIC-2 interrupt controller
 1015  LSI Logic Corp of Canada
diff -pru 2.6.10/include/linux/pci_ids.h t10/include/linux/pci_ids.h
--- 2.6.10/include/linux/pci_ids.h	2004-12-24 13:35:50.000000000 -0800
+++ t10/include/linux/pci_ids.h	2005-01-04 18:48:11.514567375 -0800
@@ -446,7 +446,8 @@
 #define PCI_DEVICE_ID_IBM_ICOM_DEV_ID_2	0x0219
 #define PCI_DEVICE_ID_IBM_ICOM_V2_TWO_PORTS_RVX		0x021A
 #define PCI_DEVICE_ID_IBM_ICOM_V2_ONE_PORT_RVX_ONE_PORT_MDM	0x0251
-#define PCI_DEVICE_ID_IBM_ICOM_FOUR_PORT_MODEL	0x252
+#define PCI_DEVICE_ID_IBM_ICOM_FOUR_PORT_MODEL	0x0252
+#define PCI_DEVICE_ID_IBM_PCI_BRIDGE_SUMMIT2	0x02a1
 
 #define PCI_VENDOR_ID_COMPEX2		0x101a // pci.ids says "AT&T GIS (NCR)"
 #define PCI_DEVICE_ID_COMPEX2_100VG	0x0005


-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
