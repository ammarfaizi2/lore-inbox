Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbVI2Aj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbVI2Aj6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 20:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbVI2Aj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 20:39:58 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:42695 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751048AbVI2Aj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 20:39:57 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: [PATCHv3 01/04] pci_ids: remove duplicates from pci_ids.h
Date: Thu, 29 Sep 2005 10:39:46 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <oqdmj1hijfb5t5p51ua227ar7ihprhonsi@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Grant Coady <gcoady@gmail.com>

pci_ids.h cleanup: remove duplicated entries and change some defines to 
explicit value rather than in terms of another constant, preparation for 
removing unused symbols

Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 pci_ids.h |   28 +++++++++-------------------
 1 files changed, 9 insertions(+), 19 deletions(-)

--- linux-2.6.14-rc2-git7/include/linux/pci_ids.h	2005-09-29 08:01:00.000000000 +1000
+++ linux-2.6.14-rc2-git7b/include/linux/pci_ids.h	2005-09-29 08:06:45.000000000 +1000
@@ -273,7 +273,6 @@
 #define PCI_DEVICE_ID_ATI_RAGE128_PP	0x5050
 #define PCI_DEVICE_ID_ATI_RAGE128_PQ	0x5051
 #define PCI_DEVICE_ID_ATI_RAGE128_PR	0x5052
-#define PCI_DEVICE_ID_ATI_RAGE128_TR	0x5452
 #define PCI_DEVICE_ID_ATI_RAGE128_PS	0x5053
 #define PCI_DEVICE_ID_ATI_RAGE128_PT	0x5054
 #define PCI_DEVICE_ID_ATI_RAGE128_PU	0x5055
@@ -515,16 +514,16 @@
 #define PCI_DEVICE_ID_AMD_VIPER_7413	0x7413
 #define PCI_DEVICE_ID_AMD_VIPER_7414	0x7414
 #define PCI_DEVICE_ID_AMD_OPUS_7440	0x7440
-#	define PCI_DEVICE_ID_AMD_VIPER_7440	PCI_DEVICE_ID_AMD_OPUS_7440
+#define PCI_DEVICE_ID_AMD_VIPER_7440	0x7440
 #define PCI_DEVICE_ID_AMD_OPUS_7441	0x7441
-#	define PCI_DEVICE_ID_AMD_VIPER_7441	PCI_DEVICE_ID_AMD_OPUS_7441
+#define PCI_DEVICE_ID_AMD_VIPER_7441	0x7441
 #define PCI_DEVICE_ID_AMD_OPUS_7443	0x7443
-#	define PCI_DEVICE_ID_AMD_VIPER_7443	PCI_DEVICE_ID_AMD_OPUS_7443
+#define PCI_DEVICE_ID_AMD_VIPER_7443	0x7443
 #define PCI_DEVICE_ID_AMD_OPUS_7445	0x7445
 #define PCI_DEVICE_ID_AMD_OPUS_7448	0x7448
-# define	PCI_DEVICE_ID_AMD_VIPER_7448	PCI_DEVICE_ID_AMD_OPUS_7448
+#define PCI_DEVICE_ID_AMD_VIPER_7448	0x7448
 #define PCI_DEVICE_ID_AMD_OPUS_7449	0x7449
-#	define PCI_DEVICE_ID_AMD_VIPER_7449	PCI_DEVICE_ID_AMD_OPUS_7449
+#define PCI_DEVICE_ID_AMD_VIPER_7449	0x7449
 #define PCI_DEVICE_ID_AMD_8111_LAN	0x7462
 #define PCI_DEVICE_ID_AMD_8111_LPC	0x7468
 #define PCI_DEVICE_ID_AMD_8111_IDE	0x7469
@@ -582,7 +581,6 @@
 #define PCI_DEVICE_ID_CT_65550		0x00e0
 #define PCI_DEVICE_ID_CT_65554		0x00e4
 #define PCI_DEVICE_ID_CT_65555		0x00e5
-#define PCI_DEVICE_ID_CT_69000		0x00c0
 
 #define PCI_VENDOR_ID_MIRO		0x1031
 #define PCI_DEVICE_ID_MIRO_36050	0x5601
@@ -1192,7 +1190,6 @@
 #define PCI_DEVICE_ID_QUADRO_FX_GO1400          0x00cc
 #define PCI_DEVICE_ID_QUADRO_FX_1400            0x00ce
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3		0x00d1
-#define PCI_DEVICE_ID_NVIDIA_MCP3_AUDIO		0x00da
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS	0x00d4
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE	0x00d5
 #define PCI_DEVICE_ID_NVIDIA_NVENET_3		0x00d6
@@ -1618,7 +1615,7 @@
 #define PCI_DEVICE_ID_SERVERWORKS_HT1000IDE 0x0214
 #define PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2 0x0217
 #define PCI_DEVICE_ID_SERVERWORKS_OSB4USB 0x0220
-#define PCI_DEVICE_ID_SERVERWORKS_CSB5USB PCI_DEVICE_ID_SERVERWORKS_OSB4USB
+#define PCI_DEVICE_ID_SERVERWORKS_CSB5USB 0x0220
 #define PCI_DEVICE_ID_SERVERWORKS_CSB6USB 0x0221
 #define PCI_DEVICE_ID_SERVERWORKS_CSB6LPC 0x0227
 #define PCI_DEVICE_ID_SERVERWORKS_GCLE    0x0225
@@ -1787,10 +1784,6 @@
 #define PCI_DEVICE_ID_PC300_TE_M_2	0x0320
 #define PCI_DEVICE_ID_PC300_TE_M_1	0x0321
 
-/* Allied Telesyn */
-#define PCI_VENDOR_ID_AT    		0x1259
-#define PCI_SUBDEVICE_ID_AT_2701FX	0x2703
-
 #define PCI_VENDOR_ID_ESSENTIAL		0x120f
 #define PCI_DEVICE_ID_ESSENTIAL_ROADRUNNER	0x0001
 
@@ -2335,16 +2328,13 @@
 #define PCI_VENDOR_ID_DUNORD		0x5544
 #define PCI_DEVICE_ID_DUNORD_I3000	0x0001
 
+#define PCI_VENDOR_ID_GENROCO		0x5555
+#define PCI_DEVICE_ID_GENROCO_HFP832	0x0003
+
 #define PCI_VENDOR_ID_DCI		0x6666
 #define PCI_DEVICE_ID_DCI_PCCOM4	0x0001
 #define PCI_DEVICE_ID_DCI_PCCOM8	0x0002
 
-#define PCI_VENDOR_ID_DUNORD		0x5544
-#define PCI_DEVICE_ID_DUNORD_I3000	0x0001
-
-#define PCI_VENDOR_ID_GENROCO		0x5555
-#define PCI_DEVICE_ID_GENROCO_HFP832	0x0003
-
 #define PCI_VENDOR_ID_INTEL		0x8086
 #define PCI_DEVICE_ID_INTEL_EESSC	0x0008
 #define PCI_DEVICE_ID_INTEL_21145	0x0039
