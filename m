Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVD0ALA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVD0ALA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 20:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVD0ALA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 20:11:00 -0400
Received: from fmr17.intel.com ([134.134.136.16]:12485 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261860AbVD0AKv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 20:10:51 -0400
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: akpm@osdl.org, tiwai@suse.de, perex@suse.cz
Subject: [PATCH 2.6.12-rc3 1/1] intel8x0: fix patch for Intel AC'97 audio driver
Date: Tue, 26 Apr 2005 13:24:12 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, jason.d.gaston@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200504261324.12783.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch fixes a typo in the Intel AC'97 audio driver intel8x0.c for Intel ESB2.  This patch was built against the 2.6.12-rc3 kernel.  
If acceptable, please apply. 

Thanks,

Jason Gaston

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>

--- linux-2.6.12-rc3/sound/pci/intel8x0.c.orig	2005-04-26 13:16:51.385768552 -0700
+++ linux-2.6.12-rc3/sound/pci/intel8x0.c	2005-04-26 13:17:38.540599928 -0700
@@ -125,8 +125,8 @@
 #ifndef PCI_DEVICE_ID_INTEL_ICH7_20
 #define PCI_DEVICE_ID_INTEL_ICH7_20	0x27de
 #endif
-#ifndef PCI_DEVICE_ID_INTEL_ESB2_13
-#define PCI_DEVICE_ID_INTEL_ESB2_13	0x2698
+#ifndef PCI_DEVICE_ID_INTEL_ESB2_14
+#define PCI_DEVICE_ID_INTEL_ESB2_14	0x2698
 #endif
 #ifndef PCI_DEVICE_ID_SI_7012
 #define PCI_DEVICE_ID_SI_7012		0x7012
@@ -2741,7 +2741,7 @@
 	{ PCI_DEVICE_ID_INTEL_ESB_5, "Intel 6300ESB" },
 	{ PCI_DEVICE_ID_INTEL_ICH6_18, "Intel ICH6" },
 	{ PCI_DEVICE_ID_INTEL_ICH7_20, "Intel ICH7" },
-	{ PCI_DEVICE_ID_INTEL_ESB2_13, "Intel ESB2" },
+	{ PCI_DEVICE_ID_INTEL_ESB2_14, "Intel ESB2" },
 	{ PCI_DEVICE_ID_SI_7012, "SiS SI7012" },
 	{ PCI_DEVICE_ID_NVIDIA_MCP_AUDIO, "NVidia nForce" },
 	{ PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO, "NVidia nForce2" },
