Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265802AbRGJGuv>; Tue, 10 Jul 2001 02:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265790AbRGJGul>; Tue, 10 Jul 2001 02:50:41 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:26550 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S265802AbRGJGug>;
	Tue, 10 Jul 2001 02:50:36 -0400
Message-ID: <3B4AA77D.BF1BC963@sun.com>
Date: Mon, 09 Jul 2001 23:58:05 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mj@ucw.cz, alan@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI ids unsorted
Content-Type: multipart/mixed;
 boundary="------------DCD701AD56ADAC7C6BB0CABD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DCD701AD56ADAC7C6BB0CABD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

Just a quick patch to put PCI ids in proper sorted order.

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------DCD701AD56ADAC7C6BB0CABD
Content-Type: text/plain; charset=us-ascii;
 name="pci_sort.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci_sort.diff"

diff -ruN dist-2.4.6/include/linux/pci_ids.h cobalt-2.4.6/include/linux/pci_ids.h
--- dist-2.4.6/include/linux/pci_ids.h	Tue Jul  3 07:55:20 2001
+++ cobalt-2.4.6/include/linux/pci_ids.h	Mon Jul  9 11:21:15 2001
@@ -1033,8 +1033,8 @@
 #define PCI_DEVICE_ID_SERVERWORKS_LE	  0x0009
 #define PCI_DEVICE_ID_SERVERWORKS_CIOB30  0x0010
 #define PCI_DEVICE_ID_SERVERWORKS_CMIC_HE 0x0011
-#define PCI_DEVICE_ID_SERVERWORKS_CSB5	  0x0201
 #define PCI_DEVICE_ID_SERVERWORKS_OSB4	  0x0200
+#define PCI_DEVICE_ID_SERVERWORKS_CSB5	  0x0201
 #define PCI_DEVICE_ID_SERVERWORKS_OSB4IDE 0x0211
 #define PCI_DEVICE_ID_SERVERWORKS_CSB5IDE 0x0212
 #define PCI_DEVICE_ID_SERVERWORKS_OSB4USB 0x0220

--------------DCD701AD56ADAC7C6BB0CABD--

