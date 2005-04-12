Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262153AbVDLUFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbVDLUFf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbVDLT7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:59:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:40392 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262153AbVDLKbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:46 -0400
Message-Id: <200504121031.j3CAVexS005372@shell0.pdx.osdl.net>
Subject: [patch 062/198] ahci: AHCI mode SATA patch for Intel ESB2
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, jason.d.gaston@intel.com,
       Jason.d.gaston@intel.com, linux-scsi@vger.kernel.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jason Gaston <jason.d.gaston@intel.com>

This patch adds the Intel ESB2 DID's to the ahci.c file for AHCI mode SATA
support.

Signed-off-by: Jason Gaston <Jason.d.gaston@intel.com>
Cc: <linux-scsi@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/scsi/ahci.c |    6 ++++++
 1 files changed, 6 insertions(+)

diff -puN drivers/scsi/ahci.c~ahci-ahci-mode-sata-patch-for-intel-esb2 drivers/scsi/ahci.c
--- 25/drivers/scsi/ahci.c~ahci-ahci-mode-sata-patch-for-intel-esb2	2005-04-12 03:21:18.132380360 -0700
+++ 25-akpm/drivers/scsi/ahci.c	2005-04-12 03:21:18.135379904 -0700
@@ -257,6 +257,12 @@ static struct pci_device_id ahci_pci_tbl
 	  board_ahci }, /* ICH7R */
 	{ PCI_VENDOR_ID_AL, 0x5288, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ULi M5288 */
+	{ PCI_VENDOR_ID_INTEL, 0x2681, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ESB2 */
+	{ PCI_VENDOR_ID_INTEL, 0x2682, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ESB2 */
+	{ PCI_VENDOR_ID_INTEL, 0x2683, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ESB2 */
 	{ }	/* terminate list */
 };
 
_
