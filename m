Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVDESc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVDESc0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVDESbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:31:13 -0400
Received: from fmr19.intel.com ([134.134.136.18]:25477 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261874AbVDESYs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:24:48 -0400
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: mj@ucw.cz
Subject: [PATCH 2.6.11.6 1/6] irq and pci_ids: patch for Intel ESB2
Date: Tue, 5 Apr 2005 08:00:43 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, jason.d.gaston@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200504050800.44117.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch adds the Intel ESB2 DID's to the irq.c and pci_ids.h files.  This patch was built against the 2.6.11.6 kernel.  
If acceptable, please apply. 

Thanks,

Jason Gaston

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>

--- linux-2.6.11.6/arch/i386/pci/irq.c.orig	2005-03-28 08:44:26.350888632 -0800
+++ linux-2.6.11.6/arch/i386/pci/irq.c	2005-03-28 08:49:38.961364616 -0800
@@ -495,6 +495,7 @@
 		case PCI_DEVICE_ID_INTEL_ICH6_1:
 		case PCI_DEVICE_ID_INTEL_ICH7_0:
 		case PCI_DEVICE_ID_INTEL_ICH7_1:
+		case PCI_DEVICE_ID_INTEL_ESB2_0:
 			r->name = "PIIX/ICH";
 			r->get = pirq_piix_get;
 			r->set = pirq_piix_set;
--- linux-2.6.11.6/include/linux/pci_ids.h.orig	2005-03-28 09:09:51.343054584 -0800
+++ linux-2.6.11.6/include/linux/pci_ids.h	2005-03-28 09:29:16.883865448 -0800
@@ -2260,6 +2260,25 @@
 #define PCI_DEVICE_ID_INTEL_ICH6_17	0x266d
 #define PCI_DEVICE_ID_INTEL_ICH6_18	0x266e
 #define PCI_DEVICE_ID_INTEL_ICH6_19	0x266f
+#define PCI_DEVICE_ID_INTEL_ESB2_0	0x2670
+#define PCI_DEVICE_ID_INTEL_ESB2_1	0x2680
+#define PCI_DEVICE_ID_INTEL_ESB2_2	0x2681
+#define PCI_DEVICE_ID_INTEL_ESB2_3	0x2682
+#define PCI_DEVICE_ID_INTEL_ESB2_4	0x2683
+#define PCI_DEVICE_ID_INTEL_ESB2_5	0x2688
+#define PCI_DEVICE_ID_INTEL_ESB2_6	0x2689
+#define PCI_DEVICE_ID_INTEL_ESB2_7	0x268a
+#define PCI_DEVICE_ID_INTEL_ESB2_8	0x268b
+#define PCI_DEVICE_ID_INTEL_ESB2_9	0x268c
+#define PCI_DEVICE_ID_INTEL_ESB2_10	0x2690
+#define PCI_DEVICE_ID_INTEL_ESB2_11	0x2692
+#define PCI_DEVICE_ID_INTEL_ESB2_12	0x2694
+#define PCI_DEVICE_ID_INTEL_ESB2_13	0x2696
+#define PCI_DEVICE_ID_INTEL_ESB2_14	0x2698
+#define PCI_DEVICE_ID_INTEL_ESB2_15	0x2699
+#define PCI_DEVICE_ID_INTEL_ESB2_16	0x269a
+#define PCI_DEVICE_ID_INTEL_ESB2_17	0x269b
+#define PCI_DEVICE_ID_INTEL_ESB2_18	0x269e
 #define PCI_DEVICE_ID_INTEL_ICH7_0	0x27b8
 #define PCI_DEVICE_ID_INTEL_ICH7_1	0x27b1
 #define PCI_DEVICE_ID_INTEL_ICH7_2	0x27c0
@@ -2285,6 +2304,18 @@
 #define PCI_DEVICE_ID_INTEL_ICH7_22	0x27e0
 #define PCI_DEVICE_ID_INTEL_ICH7_23	0x27e2
 #define PCI_DEVICE_ID_INTEL_82855PM_HB	0x3340
+#define PCI_DEVICE_ID_INTEL_ESB2_19	0x3500
+#define PCI_DEVICE_ID_INTEL_ESB2_20	0x3501
+#define PCI_DEVICE_ID_INTEL_ESB2_21	0x3504
+#define PCI_DEVICE_ID_INTEL_ESB2_22	0x3505
+#define PCI_DEVICE_ID_INTEL_ESB2_23	0x350c
+#define PCI_DEVICE_ID_INTEL_ESB2_24	0x350d
+#define PCI_DEVICE_ID_INTEL_ESB2_25	0x3510
+#define PCI_DEVICE_ID_INTEL_ESB2_26	0x3511
+#define PCI_DEVICE_ID_INTEL_ESB2_27	0x3514
+#define PCI_DEVICE_ID_INTEL_ESB2_28	0x3515
+#define PCI_DEVICE_ID_INTEL_ESB2_29	0x3518
+#define PCI_DEVICE_ID_INTEL_ESB2_30	0x3519
 #define PCI_DEVICE_ID_INTEL_82830_HB	0x3575
 #define PCI_DEVICE_ID_INTEL_82830_CGC	0x3577
 #define PCI_DEVICE_ID_INTEL_82855GM_HB	0x3580
