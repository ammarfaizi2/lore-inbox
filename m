Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281723AbRKQLrD>; Sat, 17 Nov 2001 06:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281722AbRKQLqy>; Sat, 17 Nov 2001 06:46:54 -0500
Received: from medelec.uia.ac.be ([143.169.17.1]:49415 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S281723AbRKQLqp>;
	Sat, 17 Nov 2001 06:46:45 -0500
Date: Sat, 17 Nov 2001 12:46:35 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] linux-2.4.15-pre5 - i8xx series chipsets patches (patch1)
Message-ID: <20011117124635.A18560@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

in attach a patch against linux-2.4.15-pre5 . The patch cleans up the include/linux/pci_ids.h file for intel device ID's. (It deletes the double 82801CA entries and it gets the list back sorted on the device id itself).

Greetings,
Wim.


diff -u --recursive --new-file linux-2.4.15-pre5/include/linux/pci_ids.h linux-2.4.15-pre5-patch1/include/linux/pci_ids.h
--- linux-2.4.15-pre5/include/linux/pci_ids.h	Fri Nov 16 23:23:21 2001
+++ linux-2.4.15-pre5-patch1/include/linux/pci_ids.h	Sat Nov 17 12:02:43 2001
@@ -1582,15 +1582,6 @@
 #define PCI_DEVICE_ID_INTEL_82380FB	0x124b
 #define PCI_DEVICE_ID_INTEL_82439	0x1250
 #define PCI_DEVICE_ID_INTEL_80960_RP	0x1960
-#define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
-#define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
-#define PCI_DEVICE_ID_INTEL_82371SB_2	0x7020
-#define PCI_DEVICE_ID_INTEL_82437VX	0x7030
-#define PCI_DEVICE_ID_INTEL_82439TX	0x7100
-#define PCI_DEVICE_ID_INTEL_82371AB_0	0x7110
-#define PCI_DEVICE_ID_INTEL_82371AB	0x7111
-#define PCI_DEVICE_ID_INTEL_82371AB_2	0x7112
-#define PCI_DEVICE_ID_INTEL_82371AB_3	0x7113
 #define PCI_DEVICE_ID_INTEL_82801AA_0	0x2410
 #define PCI_DEVICE_ID_INTEL_82801AA_1	0x2411
 #define PCI_DEVICE_ID_INTEL_82801AA_2	0x2412
@@ -1610,16 +1601,6 @@
 #define PCI_DEVICE_ID_INTEL_82801BA_2	0x2443
 #define PCI_DEVICE_ID_INTEL_82801BA_3	0x2444
 #define PCI_DEVICE_ID_INTEL_82801BA_4	0x2445
-#define PCI_DEVICE_ID_INTEL_82801CA_0	0x2480
-#define PCI_DEVICE_ID_INTEL_82801CA_2	0x2482
-#define PCI_DEVICE_ID_INTEL_82801CA_3	0x2483
-#define PCI_DEVICE_ID_INTEL_82801CA_4	0x2484
-#define PCI_DEVICE_ID_INTEL_82801CA_5	0x2485
-#define PCI_DEVICE_ID_INTEL_82801CA_6	0x2486
-#define PCI_DEVICE_ID_INTEL_82801CA_7	0x2487
-#define PCI_DEVICE_ID_INTEL_82801CA_10	0x248a
-#define PCI_DEVICE_ID_INTEL_82801CA_11	0x248b
-#define PCI_DEVICE_ID_INTEL_82801CA_12	0x248c
 #define PCI_DEVICE_ID_INTEL_82801BA_5	0x2446
 #define PCI_DEVICE_ID_INTEL_82801BA_6	0x2448
 #define PCI_DEVICE_ID_INTEL_82801BA_7	0x2449
@@ -1638,6 +1619,15 @@
 #define PCI_DEVICE_ID_INTEL_82801CA_11	0x248b
 #define PCI_DEVICE_ID_INTEL_82801CA_12	0x248c
 #define PCI_DEVICE_ID_INTEL_80310	0x530d
+#define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
+#define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
+#define PCI_DEVICE_ID_INTEL_82371SB_2	0x7020
+#define PCI_DEVICE_ID_INTEL_82437VX	0x7030
+#define PCI_DEVICE_ID_INTEL_82439TX	0x7100
+#define PCI_DEVICE_ID_INTEL_82371AB_0	0x7110
+#define PCI_DEVICE_ID_INTEL_82371AB	0x7111
+#define PCI_DEVICE_ID_INTEL_82371AB_2	0x7112
+#define PCI_DEVICE_ID_INTEL_82371AB_3	0x7113
 #define PCI_DEVICE_ID_INTEL_82810_MC1	0x7120
 #define PCI_DEVICE_ID_INTEL_82810_IG1	0x7121
 #define PCI_DEVICE_ID_INTEL_82810_MC3	0x7122
