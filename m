Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263205AbTDCAzG>; Wed, 2 Apr 2003 19:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263206AbTDCAzG>; Wed, 2 Apr 2003 19:55:06 -0500
Received: from codepoet.org ([166.70.99.138]:2953 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S263205AbTDCAzF>;
	Wed, 2 Apr 2003 19:55:05 -0500
Date: Wed, 2 Apr 2003 18:06:33 -0700
From: Erik Andersen <andersen@codepoet.org>
To: marcelo@conectiva.com.br
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] missing pci ids to make piix.c compile
Message-ID: <20030403010633.GD10796@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	marcelo@conectiva.com.br, linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that these are missing from the latest 2.4 BK tree 
for 2.4.21 pre6, at least as of ChangeSet 1.1095.  Without this
patch, drivers/ide/pci/piix.c will not compile.  Plese apply,

--- linux/include/linux/pci_ids.h.orig	2003-04-02 18:00:14.000000000 -0700
+++ linux/include/linux/pci_ids.h	2003-04-02 18:00:43.000000000 -0700
@@ -1604,7 +1604,7 @@
 #define PCI_DEVICE_ID_ZOLTRIX_2BD0	0x2bd0 
 
 #define PCI_VENDOR_ID_PDC		0x15e9
-#define PCI_DEVICE_ID_PDC_1841		0x1841
+#define PCI_DEVICE_ID_PDC_ADMA100	0x1841
 
 #define PCI_VENDOR_ID_ALTIMA		0x173b
 #define PCI_DEVICE_ID_ALTIMA_AC1000	0x03e8
@@ -1760,8 +1760,18 @@
 #define PCI_DEVICE_ID_INTEL_82801DB_5	0x24c5
 #define PCI_DEVICE_ID_INTEL_82801DB_6	0x24c6
 #define PCI_DEVICE_ID_INTEL_82801DB_7	0x24c7
+#define PCI_DEVICE_ID_INTEL_82801DB_10	0x24ca
 #define PCI_DEVICE_ID_INTEL_82801DB_11	0x24cb
 #define PCI_DEVICE_ID_INTEL_82801DB_13	0x24cd
+#define PCI_DEVICE_ID_INTEL_82801EB_0	0x24d0
+#define PCI_DEVICE_ID_INTEL_82801EB_2	0x24d2
+#define PCI_DEVICE_ID_INTEL_82801EB_3	0x24d3
+#define PCI_DEVICE_ID_INTEL_82801EB_4	0x24d4
+#define PCI_DEVICE_ID_INTEL_82801EB_5	0x24d5
+#define PCI_DEVICE_ID_INTEL_82801EB_6	0x24d6
+#define PCI_DEVICE_ID_INTEL_82801EB_7	0x24d7
+#define PCI_DEVICE_ID_INTEL_82801EB_11	0x24db
+#define PCI_DEVICE_ID_INTEL_82801EB_13	0x24dd
 #define PCI_DEVICE_ID_INTEL_80310	0x530d
 #define PCI_DEVICE_ID_INTEL_82810_MC1	0x7120
 #define PCI_DEVICE_ID_INTEL_82810_IG1	0x7121

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
