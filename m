Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVCGT0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVCGT0Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 14:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVCGTZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 14:25:47 -0500
Received: from fmr19.intel.com ([134.134.136.18]:6370 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261252AbVCGTLO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 14:11:14 -0500
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: jgarzik@redhat.com
Subject: [PATCH] SATA AHCI correction Intel ICH7R - 2.6.11
Date: Mon, 7 Mar 2005 12:16:24 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, jason.d.gaston@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503071216.24530.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes an invalid DID for Intel ICH7R from the ahci.c SATA AHCI driver.
If acceptable, please apply.

Thanks,

Jason Gaston

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>

--- linux-2.6.11/drivers/scsi/ahci.c.orig	2005-03-07 12:09:54.586699088 -0800
+++ linux-2.6.11/drivers/scsi/ahci.c	2005-03-07 12:10:45.446967152 -0800
@@ -249,8 +249,6 @@ static struct pci_device_id ahci_pci_tbl
 	  board_ahci }, /* ICH7 */
 	{ PCI_VENDOR_ID_INTEL, 0x27c5, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ICH7M */
-	{ PCI_VENDOR_ID_INTEL, 0x27c2, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* ICH7R */
 	{ PCI_VENDOR_ID_INTEL, 0x27c3, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ICH7R */
 	{ PCI_VENDOR_ID_AL, 0x5288, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
