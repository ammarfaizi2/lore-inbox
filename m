Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289053AbSANVFc>; Mon, 14 Jan 2002 16:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289046AbSANVFX>; Mon, 14 Jan 2002 16:05:23 -0500
Received: from medelec.uia.ac.be ([143.169.17.1]:60943 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S289053AbSANVFP>;
	Mon, 14 Jan 2002 16:05:15 -0500
Date: Mon, 14 Jan 2002 22:04:44 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.18-pre3 - i8xx series chipsets patches (patch1)
Message-ID: <20020114220444.A14224@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

in attach a patch against linux-2.4.18-pre3 . The patch cleans up the include/linux/pci_ids.h file for intel
device ID's. (It deletes the double 82801CA entries and it gets the list back sorted on the device id
itself).

Greetings,
Wim.


diff -u --recursive --new-file linux-2.4.18-pre3/include/linux/pci_ids.h linux-2.4.18-pre3-patch1/include/linux/pci_ids.h
--- linux-2.4.18-pre3/include/linux/pci_ids.h	Mon Jan 14 20:44:25 2002
+++ linux-2.4.18-pre3-patch1/include/linux/pci_ids.h	Mon Jan 14 21:17:31 2002
@@ -1600,15 +1600,6 @@
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
@@ -1628,16 +1619,6 @@
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
@@ -1656,6 +1637,15 @@
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
