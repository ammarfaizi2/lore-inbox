Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVDESls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVDESls (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVDESlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:41:05 -0400
Received: from fmr18.intel.com ([134.134.136.17]:56473 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261898AbVDESjI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:39:08 -0400
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: jgarzik@redhat.com
Subject: [PATCH 2.6.11.6 5/6] ahci: AHCI mode SATA patch for Intel ESB2
Date: Tue, 5 Apr 2005 08:14:58 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, jason.d.gaston@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200504050814.58292.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch adds the Intel ESB2 DID's to the ahci.c file for AHCI mode SATA support.  This patch was built against the 2.6.11.6 kernel.  
If acceptable, please apply. 

Thanks,

Jason Gaston

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>

--- linux-2.6.11.6/drivers/scsi/ahci.c.orig	2005-03-28 09:03:45.359692512 -0800
+++ linux-2.6.11.6/drivers/scsi/ahci.c	2005-03-28 09:06:51.745357584 -0800
@@ -255,6 +255,12 @@
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
 
