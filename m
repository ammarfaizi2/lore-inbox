Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263577AbVCEBRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263577AbVCEBRc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 20:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263578AbVCEBHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 20:07:01 -0500
Received: from fmr17.intel.com ([134.134.136.16]:46052 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S263482AbVCEA7h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 19:59:37 -0500
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: bzolnier@gmail.com
Subject: [PATCH] pci_ids.h correction for Intel ICH7M - 2.6.11
Date: Fri, 4 Mar 2005 18:04:43 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503041804.43413.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the ICH7M LPC controller DID in pci_ids.h from x27B1 to x27B9.  This patch was build against 2.6.11.
If acceptable, please apply.

Thanks,

Jason Gaston

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>

--- linux-2.6.11/include/linux/pci_ids.h.orig	2005-03-04 17:58:10.490587200 -0800
+++ linux-2.6.11/include/linux/pci_ids.h	2005-03-04 17:58:29.990622744 -0800
@@ -2261,7 +2261,7 @@
 #define PCI_DEVICE_ID_INTEL_ICH6_18	0x266e
 #define PCI_DEVICE_ID_INTEL_ICH6_19	0x266f
 #define PCI_DEVICE_ID_INTEL_ICH7_0	0x27b8
-#define PCI_DEVICE_ID_INTEL_ICH7_1	0x27b1
+#define PCI_DEVICE_ID_INTEL_ICH7_1	0x27b9
 #define PCI_DEVICE_ID_INTEL_ICH7_2	0x27c0
 #define PCI_DEVICE_ID_INTEL_ICH7_3	0x27c1
 #define PCI_DEVICE_ID_INTEL_ICH7_4	0x27c2

