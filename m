Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315754AbSFDSjg>; Tue, 4 Jun 2002 14:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316289AbSFDSjf>; Tue, 4 Jun 2002 14:39:35 -0400
Received: from medelec.uia.ac.be ([143.169.17.1]:24071 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S315754AbSFDSjb>;
	Tue, 4 Jun 2002 14:39:31 -0400
Date: Tue, 4 Jun 2002 20:39:24 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] linux-2.4.19-pre10 - i8xx series chipsets patches (patch 3)
Message-ID: <20020604203924.A14653@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I redid my i8xx series patches for v2.4.19-pre10 . They include support for the 82801DB and 82801E 
I/O Controller Hubs for various modules.

Patch 3 adds these ICH's to the pci_ids.h include file so that they can be used in other code/modules.

Greetings,
Wim.


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.539   -> 1.540  
#	include/linux/pci_ids.h	1.41    -> 1.42   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/04	wim@iguana.be	1.540
# [PATCH] 2.4.19-pre10 - i8xx series chipsets patches (patch 3)
# 
# Add defines to pci_ids.h for 82801E and 82801DB I/O Controller Hub PCI-IDS.
# --------------------------------------------
#
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Tue Jun  4 19:13:54 2002
+++ b/include/linux/pci_ids.h	Tue Jun  4 19:13:55 2002
@@ -1658,6 +1658,13 @@
 #define PCI_DEVICE_ID_INTEL_82801BA_9	0x244b
 #define PCI_DEVICE_ID_INTEL_82801BA_10	0x244c
 #define PCI_DEVICE_ID_INTEL_82801BA_11	0x244e
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
@@ -1668,6 +1675,15 @@
 #define PCI_DEVICE_ID_INTEL_82801CA_10	0x248a
 #define PCI_DEVICE_ID_INTEL_82801CA_11	0x248b
 #define PCI_DEVICE_ID_INTEL_82801CA_12	0x248c
+#define PCI_DEVICE_ID_INTEL_82801DB_0	0x24c0
+#define PCI_DEVICE_ID_INTEL_82801DB_2	0x24c2
+#define PCI_DEVICE_ID_INTEL_82801DB_3	0x24c3
+#define PCI_DEVICE_ID_INTEL_82801DB_4	0x24c4
+#define PCI_DEVICE_ID_INTEL_82801DB_5	0x24c5
+#define PCI_DEVICE_ID_INTEL_82801DB_6	0x24c6
+#define PCI_DEVICE_ID_INTEL_82801DB_7	0x24c7
+#define PCI_DEVICE_ID_INTEL_82801DB_11	0x24cb
+#define PCI_DEVICE_ID_INTEL_82801DB_13	0x24cd
 #define PCI_DEVICE_ID_INTEL_80310	0x530d
 #define PCI_DEVICE_ID_INTEL_82810_MC1	0x7120
 #define PCI_DEVICE_ID_INTEL_82810_IG1	0x7121
