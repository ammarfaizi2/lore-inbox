Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262621AbVAUXvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbVAUXvm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 18:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVAUXtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 18:49:33 -0500
Received: from fmr19.intel.com ([134.134.136.18]:61399 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262618AbVAUXsS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:48:18 -0500
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: jgarzik@redhat.com
Subject: [PATCH] SATA AHCI support for Intel ICH7R - 2.6.11-rc1
Date: Fri, 21 Jan 2005 08:53:49 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, jason.d.gaston@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501210853.49746.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the Intel ICH7R DID's to the ahci.c SATA AHCI driver for ICH7R SATA support.
If acceptable, please apply.

Thanks,

Jason Gaston

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>

--- linux-2.6.11-rc1/drivers/scsi/ahci.c.orig	2005-01-21 07:46:58.202269784 -0800
+++ linux-2.6.11-rc1/drivers/scsi/ahci.c	2005-01-21 07:48:58.732946336 -0800
@@ -246,6 +246,10 @@ static struct pci_device_id ahci_pci_tbl
 	  board_ahci }, /* ICH7 */
 	{ PCI_VENDOR_ID_INTEL, 0x27c5, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ICH7M */
+	{ PCI_VENDOR_ID_INTEL, 0x27c2, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ICH7R */
+	{ PCI_VENDOR_ID_INTEL, 0x27c3, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ICH7R */
 	{ }	/* terminate list */
 };
 
