Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751567AbWAIWVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbWAIWVw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 17:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbWAIWVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 17:21:52 -0500
Received: from fmr18.intel.com ([134.134.136.17]:28079 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751567AbWAIWVu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 17:21:50 -0500
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: jgarzik@redhat.com
Subject: [PATCH 2.6.15 6/6] ahci: AHCI mode SATA patch for Intel ICH8
Date: Mon, 9 Jan 2006 11:09:13 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, jason.d.gaston@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601091109.14105.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch adds the Intel ICH8 DID's to the ahci.c file for AHCI mode SATA support.  This patch was built against the 2.6.15 kernel.  
If acceptable, please apply. 

Thanks,

Jason Gaston

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>

--- linux-2.6.15/drivers/scsi/ahci.c.orig	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.15/drivers/scsi/ahci.c	2006-01-09 08:18:08.014291320 -0800
@@ -277,6 +277,16 @@
 	  board_ahci }, /* ESB2 */
 	{ PCI_VENDOR_ID_INTEL, 0x27c6, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ICH7-M DH */
+	{ PCI_VENDOR_ID_INTEL, 0x2821, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ICH8 */
+	{ PCI_VENDOR_ID_INTEL, 0x2822, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ICH8 */
+	{ PCI_VENDOR_ID_INTEL, 0x2824, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ICH8 */
+	{ PCI_VENDOR_ID_INTEL, 0x2829, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ICH8M */
+	{ PCI_VENDOR_ID_INTEL, 0x282a, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ICH8M */
 	{ }	/* terminate list */
 };
 
