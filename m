Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278401AbRJWX6A>; Tue, 23 Oct 2001 19:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278414AbRJWX5u>; Tue, 23 Oct 2001 19:57:50 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:34699 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S278408AbRJWX5j>;
	Tue, 23 Oct 2001 19:57:39 -0400
Message-ID: <3BD6031E.5A55DDD3@sun.com>
Date: Tue, 23 Oct 2001 16:54:06 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jgarzik@mandrakesoft.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alan@redhat.com, torvalds@transmeta.com
Subject: [PATCH] add pci ids
Content-Type: multipart/mixed;
 boundary="------------46990AFB9D724AEA6DAD264B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------46990AFB9D724AEA6DAD264B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Patch adds pci ids for Natsemi DP83820 and Netgear GA622.  Please pop into
next 2.4.x.

Tim

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------46990AFB9D724AEA6DAD264B
Content-Type: text/plain; charset=us-ascii;
 name="pci_ids.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci_ids.diff"

--- virgin-2.4.12/drivers/pci/pci.ids	Wed Oct 10 14:37:15 2001
+++ CVS-checkout/drivers/pci/pci.ids	Mon Oct 22 09:36:36 2001
@@ -268,6 +268,7 @@
 	0011  National PCI System I/O
 	0012  USB Controller
 	0020  DP83815
+	0022  DP83820
 	d001  87410 IDE
 100c  Tseng Labs Inc
 	3202  ET4000/W32p rev A
@@ -3591,6 +3592,7 @@
 1384  Reality Simulation Systems Inc
 1385  Netgear
 	620a  GA620
+	622a  GA622
 	f311  FA311
 1386  Video Domain Technologies
 1387  Systran Corp
--- virgin-2.4.12/include/linux/pci_ids.h	Thu Oct 11 13:46:54 2001
+++ CVS-checkout/include/linux/pci_ids.h	Tue Oct 23 16:45:44 2001
@@ -285,6 +285,8 @@
 #define PCI_DEVICE_ID_NS_87415		0x0002
 #define PCI_DEVICE_ID_NS_87560_LIO	0x000e
 #define PCI_DEVICE_ID_NS_87560_USB	0x0012
+#define PCI_DEVICE_ID_NS_83815		0x0020
+#define PCI_DEVICE_ID_NS_83820		0x0022
 #define PCI_DEVICE_ID_NS_87410		0xd001
 
 #define PCI_VENDOR_ID_TSENG		0x100c
@@ -1382,6 +1384,7 @@
 
 #define PCI_VENDOR_ID_NETGEAR		0x1385
 #define PCI_DEVICE_ID_NETGEAR_GA620	0x620a
+#define PCI_DEVICE_ID_NETGEAR_GA622	0x622a
 
 #define PCI_VENDOR_ID_APPLICOM		0x1389
 #define PCI_DEVICE_ID_APPLICOM_PCIGENERIC 0x0001

--------------46990AFB9D724AEA6DAD264B--

