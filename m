Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269326AbRHNCP0>; Mon, 13 Aug 2001 22:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269865AbRHNCPG>; Mon, 13 Aug 2001 22:15:06 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:15804 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S269326AbRHNCOz>;
	Mon, 13 Aug 2001 22:14:55 -0400
Message-ID: <3B788A88.B5E7CBA2@sun.com>
Date: Mon, 13 Aug 2001 19:18:48 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        torvalds@transmeta.com, jgarzik@mandrakesoft.com, mj@ucw.cz,
        alan@redhat.com
Subject: [PATCH] PCI devid ordering 
Content-Type: multipart/mixed;
 boundary="------------59724ED0E9988EA2993EE390"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------59724ED0E9988EA2993EE390
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

All,

Attached is a VERY small patch against 2.4.8, which I have been sending for
a while.  It merely re-orders one of the PCI device ids - the list was
supposed to be kept in order.

If there is any reason this can't go into the next 2.4.x release, please
let me know.

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------59724ED0E9988EA2993EE390
Content-Type: text/plain; charset=us-ascii;
 name="pci_devid.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci_devid.diff"

diff -ruN dist+patches-2.4.8/include/linux/pci_ids.h cobalt-2.4.8/include/linux/pci_ids.h
--- dist+patches-2.4.8/include/linux/pci_ids.h	Mon Aug  6 10:11:58 2001
+++ cobalt-2.4.8/include/linux/pci_ids.h	Mon Aug 13 16:42:50 2001
@@ -1041,8 +1041,8 @@
 #define PCI_DEVICE_ID_SERVERWORKS_LE	  0x0009
 #define PCI_DEVICE_ID_SERVERWORKS_CIOB30  0x0010
 #define PCI_DEVICE_ID_SERVERWORKS_CMIC_HE 0x0011
-#define PCI_DEVICE_ID_SERVERWORKS_CSB5	  0x0201
 #define PCI_DEVICE_ID_SERVERWORKS_OSB4	  0x0200
+#define PCI_DEVICE_ID_SERVERWORKS_CSB5	  0x0201
 #define PCI_DEVICE_ID_SERVERWORKS_OSB4IDE 0x0211
 #define PCI_DEVICE_ID_SERVERWORKS_CSB5IDE 0x0212
 #define PCI_DEVICE_ID_SERVERWORKS_OSB4USB 0x0220

--------------59724ED0E9988EA2993EE390--

