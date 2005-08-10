Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965229AbVHJRa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965229AbVHJRa2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 13:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbVHJRa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 13:30:28 -0400
Received: from fmr18.intel.com ([134.134.136.17]:19101 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S965229AbVHJRa2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 13:30:28 -0400
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: jgarzik@redhat.com
Subject: [PATCH 2.6.13-rc6 1/1] ahci: AHCI mode SATA patch for Intel ICH7-M DH
Date: Wed, 10 Aug 2005 06:18:43 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, jason.d.gaston@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200508100618.43236.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch adds the Intel ICH7-M DH DID to the ahci.c file for AHCI mode SATA support.  This patch was built against the 2.6.13-rc6 kernel.  
If acceptable, please apply. 

Thanks,

Jason Gaston

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>

--- linux-2.6.13-rc6/drivers/scsi/ahci.c.orig	2005-08-10 06:06:34.993968056 -0700
+++ linux-2.6.13-rc6/drivers/scsi/ahci.c	2005-08-10 06:09:01.614678320 -0700
@@ -269,6 +269,8 @@
 	  board_ahci }, /* ESB2 */
 	{ PCI_VENDOR_ID_INTEL, 0x2683, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ESB2 */
+	{ PCI_VENDOR_ID_INTEL, 0x27c6, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ICH7-M DH */
 	{ }	/* terminate list */
 };
 

