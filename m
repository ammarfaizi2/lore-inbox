Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVCGUNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVCGUNg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 15:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbVCGUNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:13:36 -0500
Received: from fmr18.intel.com ([134.134.136.17]:24512 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261302AbVCGTbG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 14:31:06 -0500
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: bzolnier@gmail.com
Subject: [PATCH] pci_ids.h correction for Intel ICH7R - 2.6.11
Date: Mon, 7 Mar 2005 12:36:22 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, jason.d.gaston@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503071236.22193.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes an incorrect ICH7R DID in pci_ids.h.  This patch was build against 2.6.11.
If acceptable, please apply.

Thanks,

Jason Gaston

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>


--- linux-2.6.11/include/linux/pci_ids.h.orig	2005-03-04 17:58:10.000000000 -0800
+++ linux-2.6.11/include/linux/pci_ids.h	2005-03-07 12:32:16.029768744 -0800
@@ -2264,7 +2264,6 @@
 #define PCI_DEVICE_ID_INTEL_ICH7_1	0x27b1
 #define PCI_DEVICE_ID_INTEL_ICH7_2	0x27c0
 #define PCI_DEVICE_ID_INTEL_ICH7_3	0x27c1
-#define PCI_DEVICE_ID_INTEL_ICH7_4	0x27c2
 #define PCI_DEVICE_ID_INTEL_ICH7_5	0x27c4
 #define PCI_DEVICE_ID_INTEL_ICH7_6	0x27c5
 #define PCI_DEVICE_ID_INTEL_ICH7_7	0x27c8

