Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262646AbVAJVfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262646AbVAJVfQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 16:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbVAJVeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 16:34:37 -0500
Received: from fmr18.intel.com ([134.134.136.17]:30955 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S262646AbVAJVbN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 16:31:13 -0500
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: bzolnier@gmail.com
Subject: [PATCH] pci_ids.h correction for Intel ICH7 - 2.6.10-bk13
Date: Mon, 10 Jan 2005 06:36:49 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, jason.d.gaston@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501100636.50064.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the ICH7 LPC controller DID in pci_ids.h from x27B0 to x27B8.  This patch was build against 2.6.10-bk13.
If acceptable, please apply.

Thanks,

Jason Gaston

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>

--- linux-2.6.10-bk13/include/linux/pci_ids.h.orig	2005-01-10 06:20:55.999996392 -0800
+++ linux-2.6.10-bk13/include/linux/pci_ids.h	2005-01-10 06:21:17.519724896 -0800
@@ -2238,7 +2238,7 @@
 #define PCI_DEVICE_ID_INTEL_ICH6_17	0x266d
 #define PCI_DEVICE_ID_INTEL_ICH6_18	0x266e
 #define PCI_DEVICE_ID_INTEL_ICH6_19	0x266f
-#define PCI_DEVICE_ID_INTEL_ICH7_0	0x27b0
+#define PCI_DEVICE_ID_INTEL_ICH7_0	0x27b8
 #define PCI_DEVICE_ID_INTEL_ICH7_1	0x27b1
 #define PCI_DEVICE_ID_INTEL_ICH7_2	0x27c0
 #define PCI_DEVICE_ID_INTEL_ICH7_3	0x27c1
