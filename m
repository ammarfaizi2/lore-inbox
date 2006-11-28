Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758738AbWK1Scr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758738AbWK1Scr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 13:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758737AbWK1Scr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 13:32:47 -0500
Received: from mga02.intel.com ([134.134.136.20]:62554 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1758735AbWK1Scq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 13:32:46 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,470,1157353200"; 
   d="scan'208"; a="167469918:sNHT30923011"
From: Jason Gaston <jason.d.gaston@intel.com>
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       jason.d.gaston@intel.com, htejun@gmail.com
Subject: [PATCH 2.6.19-rc6][reRESEND] ata_piix: IDE mode SATA patch for Intel ICH9
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
Date: Tue, 28 Nov 2006 10:32:38 -0800
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200611281032.39214.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This updated patch adds the Intel ICH9 IDE mode SATA controller DID's.

Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>

--- linux-2.6.19-rc6/drivers/ata/ata_piix.c.orig	2006-11-20 04:58:48.000000000 
-0800
+++ linux-2.6.19-rc6/drivers/ata/ata_piix.c	2006-11-22 02:59:05.000000000 
-0800
@@ -227,15 +227,27 @@
 	{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
 	/* 2801GBM/GHM (ICH7M, identical to ICH6M) */
 	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6m_sata_ahci },
-	/* Enterprise Southbridge 2 (where's the datasheet?) */
+	/* Enterprise Southbridge 2 (631xESB/632xESB) */
 	{ 0x8086, 0x2680, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
-	/* SATA Controller 1 IDE (ICH8, no datasheet yet) */
+	/* SATA Controller 1 IDE (ICH8) */
 	{ 0x8086, 0x2820, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
-	/* SATA Controller 2 IDE (ICH8, ditto) */
+	/* SATA Controller 2 IDE (ICH8) */
 	{ 0x8086, 0x2825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
-	/* Mobile SATA Controller IDE (ICH8M, ditto) */
+	/* Mobile SATA Controller IDE (ICH8M) */
 	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
-
+	/* SATA Controller IDE (ICH9) */
+	{ 0x8086, 0x2920, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
+	/* SATA Controller IDE (ICH9) */
+	{ 0x8086, 0x2921, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
+	/* SATA Controller IDE (ICH9) */
+	{ 0x8086, 0x2926, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
+	/* SATA Controller IDE (ICH9M) */
+	{ 0x8086, 0x2928, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
+	/* SATA Controller IDE (ICH9M) */
+	{ 0x8086, 0x292d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
+	/* SATA Controller IDE (ICH9M) */
+	{ 0x8086, 0x292e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
+	
 	{ }	/* terminate list */
 };
 
