Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWAEBOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWAEBOW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 20:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWAEBOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 20:14:22 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:1937 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751101AbWAEBOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 20:14:22 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH] pci_ids.h: remove duplicate IDs
Date: Thu, 05 Jan 2006 12:14:16 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <1isor19fmroc4ue21gnqkp6k1ln1pp06r1@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Grant Coady <gcoady@gmail.com>

pci_ids.h: removes eight duplicate IDs that crept in during the 
 2.6.15 development cycle, commented a duplicate where one ID was 
 defined in terms of another.  Compile tested with allyesconfig.

Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 pci_ids.h |   12 +-----------
 1 files changed, 1 insertion(+), 11 deletions(-)

--- linux-2.6.15a/include/linux/pci_ids.h	2005-10-28 10:02:08.000000000 +1000
+++ linux-2.6.15b/include/linux/pci_ids.h	2006-01-05 11:37:28.000000000 +1100
@@ -274,7 +274,6 @@
 #define PCI_DEVICE_ID_ATI_RAGE128_PP	0x5050
 #define PCI_DEVICE_ID_ATI_RAGE128_PQ	0x5051
 #define PCI_DEVICE_ID_ATI_RAGE128_PR	0x5052
-#define PCI_DEVICE_ID_ATI_RAGE128_TR	0x5452
 #define PCI_DEVICE_ID_ATI_RAGE128_PS	0x5053
 #define PCI_DEVICE_ID_ATI_RAGE128_PT	0x5054
 #define PCI_DEVICE_ID_ATI_RAGE128_PU	0x5055
@@ -585,7 +584,6 @@
 #define PCI_DEVICE_ID_CT_65550		0x00e0
 #define PCI_DEVICE_ID_CT_65554		0x00e4
 #define PCI_DEVICE_ID_CT_65555		0x00e5
-#define PCI_DEVICE_ID_CT_69000		0x00c0
 
 #define PCI_VENDOR_ID_MIRO		0x1031
 #define PCI_DEVICE_ID_MIRO_36050	0x5601
@@ -1197,7 +1195,6 @@
 #define PCI_DEVICE_ID_QUADRO_FX_GO1400          0x00cc
 #define PCI_DEVICE_ID_QUADRO_FX_1400            0x00ce
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3		0x00d1
-#define PCI_DEVICE_ID_NVIDIA_MCP3_AUDIO		0x00da
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS	0x00d4
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE	0x00d5
 #define PCI_DEVICE_ID_NVIDIA_NVENET_3		0x00d6
@@ -1623,7 +1620,7 @@
 #define PCI_DEVICE_ID_SERVERWORKS_HT1000IDE 0x0214
 #define PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2 0x0217
 #define PCI_DEVICE_ID_SERVERWORKS_OSB4USB 0x0220
-#define PCI_DEVICE_ID_SERVERWORKS_CSB5USB PCI_DEVICE_ID_SERVERWORKS_OSB4USB
+#define PCI_DEVICE_ID_SERVERWORKS_CSB5USB 0x0220 /* same as previous */
 #define PCI_DEVICE_ID_SERVERWORKS_CSB6USB 0x0221
 #define PCI_DEVICE_ID_SERVERWORKS_CSB6LPC 0x0227
 #define PCI_DEVICE_ID_SERVERWORKS_GCLE    0x0225
@@ -1792,10 +1789,6 @@
 #define PCI_DEVICE_ID_PC300_TE_M_2	0x0320
 #define PCI_DEVICE_ID_PC300_TE_M_1	0x0321
 
-/* Allied Telesyn */
-#define PCI_VENDOR_ID_AT    		0x1259
-#define PCI_SUBDEVICE_ID_AT_2701FX	0x2703
-
 #define PCI_VENDOR_ID_ESSENTIAL		0x120f
 #define PCI_DEVICE_ID_ESSENTIAL_ROADRUNNER	0x0001
 
@@ -2344,9 +2337,6 @@
 #define PCI_DEVICE_ID_DCI_PCCOM4	0x0001
 #define PCI_DEVICE_ID_DCI_PCCOM8	0x0002
 
-#define PCI_VENDOR_ID_DUNORD		0x5544
-#define PCI_DEVICE_ID_DUNORD_I3000	0x0001
-
 #define PCI_VENDOR_ID_GENROCO		0x5555
 #define PCI_DEVICE_ID_GENROCO_HFP832	0x0003
 
