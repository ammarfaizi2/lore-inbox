Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314641AbSEKVPp>; Sat, 11 May 2002 17:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314652AbSEKVPo>; Sat, 11 May 2002 17:15:44 -0400
Received: from medelec.uia.ac.be ([143.169.17.1]:59657 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S314641AbSEKVPl>;
	Sat, 11 May 2002 17:15:41 -0400
Date: Sat, 11 May 2002 23:15:36 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.19-pre8 - i8xx series chipsets patches (patch 4)
Message-ID: <20020511231536.A16462@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am sending the following patch to Marcelo for inclusion in the kernel.

Greetings,
Wim.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.408   -> 1.409  
#	include/linux/pci_ids.h	1.40    -> 1.41   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/11	wim@iguana.be	1.409
# [PATCH] 2.4.19-pre8 - i8xx series chipsets patches
# 
# Add defines to pci_ids.h for 82801E I/O Controller Hub PCI-IDS.
# --------------------------------------------
#
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Sat May 11 10:54:07 2002
+++ b/include/linux/pci_ids.h	Sat May 11 10:54:07 2002
@@ -1655,6 +1655,13 @@
 #define PCI_DEVICE_ID_INTEL_82801BA_11	0x244b
 #define PCI_DEVICE_ID_INTEL_82801BA_12	0x244c
 #define PCI_DEVICE_ID_INTEL_82801BA_14	0x244e
+#define PCI_DEVICE_ID_INTEL_82801E_0	0x2450
+#define PCI_DEVICE_ID_INTEL_82801E_2	0x2452
+#define PCI_DEVICE_ID_INTEL_82801E_3	0x2453
+#define PCI_DEVICE_ID_INTEL_82801E_9	0x2459
+#define PCI_DEVICE_ID_INTEL_82801E_11	0x245b
+#define PCI_DEVICE_ID_INTEL_82801E_13	0x245d
+#define PCI_DEVICE_ID_INTEL_82801E_14	0x245e
 #define PCI_DEVICE_ID_INTEL_82801CA_0	0x2480
 #define PCI_DEVICE_ID_INTEL_82801CA_2	0x2482
 #define PCI_DEVICE_ID_INTEL_82801CA_3	0x2483
