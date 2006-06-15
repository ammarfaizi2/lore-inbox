Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWFOQ5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWFOQ5W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 12:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWFOQ5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 12:57:22 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:36802 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1751451AbWFOQ5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 12:57:21 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Mike Miller <mike.miller@hp.com>
Subject: [PATCH 8/7] CCISS: tidy up product table indentation
Date: Thu, 15 Jun 2006 10:57:01 -0600
User-Agent: KMail/1.8.3
Cc: iss_storagedev@hp.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <200606141707.27404.bjorn.helgaas@hp.com>
In-Reply-To: <200606141707.27404.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606151057.01874.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make each one fit on a line so it's easier to read.  I re-ordered
COMPAQ_CISSC/0x4091, which was out of order.  I double-checked these,
but it would be good if you'd also check them to make sure I didn't
miss any.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: rc6-mm2/drivers/block/cciss.c
===================================================================
--- rc6-mm2.orig/drivers/block/cciss.c	2006-06-15 10:47:49.000000000 -0600
+++ rc6-mm2/drivers/block/cciss.c	2006-06-15 10:55:48.000000000 -0600
@@ -64,42 +64,24 @@
 
 /* define the PCI info for the cards we can control */
 static const struct pci_device_id cciss_pci_device_id[] = {
-	{PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISS,
-	 0x0E11, 0x4070, 0, 0, 0},
-	{PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSB,
-	 0x0E11, 0x4080, 0, 0, 0},
-	{PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSB,
-	 0x0E11, 0x4082, 0, 0, 0},
-	{PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSB,
-	 0x0E11, 0x4083, 0, 0, 0},
-	{PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
-	 0x0E11, 0x409A, 0, 0, 0},
-	{PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
-	 0x0E11, 0x409B, 0, 0, 0},
-	{PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
-	 0x0E11, 0x409C, 0, 0, 0},
-	{PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
-	 0x0E11, 0x409D, 0, 0, 0},
-	{PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC,
-	 0x0E11, 0x4091, 0, 0, 0},
-	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSA,
-	 0x103C, 0x3225, 0, 0, 0},
-	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSC,
-	 0x103c, 0x3223, 0, 0, 0},
-	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSC,
-	 0x103c, 0x3234, 0, 0, 0},
-	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSC,
-	 0x103c, 0x3235, 0, 0, 0},
-	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSD,
-	 0x103c, 0x3211, 0, 0, 0},
-	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSD,
-	 0x103c, 0x3212, 0, 0, 0},
-	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSD,
-	 0x103c, 0x3213, 0, 0, 0},
-	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSD,
-	 0x103c, 0x3214, 0, 0, 0},
-	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_CISSD,
-	 0x103c, 0x3215, 0, 0, 0},
+	{PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISS,  0x0E11, 0x4070},
+	{PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSB, 0x0E11, 0x4080},
+	{PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSB, 0x0E11, 0x4082},
+	{PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSB, 0x0E11, 0x4083},
+	{PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC, 0x0E11, 0x4091},
+	{PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC, 0x0E11, 0x409A},
+	{PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC, 0x0E11, 0x409B},
+	{PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC, 0x0E11, 0x409C},
+	{PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSC, 0x0E11, 0x409D},
+	{PCI_VENDOR_ID_HP,     PCI_DEVICE_ID_HP_CISSA,     0x103C, 0x3225},
+	{PCI_VENDOR_ID_HP,     PCI_DEVICE_ID_HP_CISSC,     0x103C, 0x3223},
+	{PCI_VENDOR_ID_HP,     PCI_DEVICE_ID_HP_CISSC,     0x103C, 0x3234},
+	{PCI_VENDOR_ID_HP,     PCI_DEVICE_ID_HP_CISSC,     0x103C, 0x3235},
+	{PCI_VENDOR_ID_HP,     PCI_DEVICE_ID_HP_CISSD,     0x103C, 0x3211},
+	{PCI_VENDOR_ID_HP,     PCI_DEVICE_ID_HP_CISSD,     0x103C, 0x3212},
+	{PCI_VENDOR_ID_HP,     PCI_DEVICE_ID_HP_CISSD,     0x103C, 0x3213},
+	{PCI_VENDOR_ID_HP,     PCI_DEVICE_ID_HP_CISSD,     0x103C, 0x3214},
+	{PCI_VENDOR_ID_HP,     PCI_DEVICE_ID_HP_CISSD,     0x103C, 0x3215},
 	{0,}
 };
 
