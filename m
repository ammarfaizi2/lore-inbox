Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132521AbRDDXMi>; Wed, 4 Apr 2001 19:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132520AbRDDXM3>; Wed, 4 Apr 2001 19:12:29 -0400
Received: from roam2.singnet.com.sg ([165.21.101.198]:44540 "EHLO
	roam2.singnet.com.sg") by vger.kernel.org with ESMTP
	id <S132519AbRDDXMQ>; Wed, 4 Apr 2001 19:12:16 -0400
Message-ID: <3ACBA961.6080009@smartbridges.com>
Date: Thu, 05 Apr 2001 07:08:17 +0800
From: Nikhil Goel <devlst2@smartbridges.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-pre4 i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Petko Manolov <petkan@dce.bg>
Subject: [PATCH] - USB/Vendor ID update, nothing earthshaking..
Content-Type: multipart/mixed;
 boundary="------------090306030106080001090200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090306030106080001090200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


but shall be helpful for a few thousand users of the device.

Thanks,
Nikhil

-- ------------------------------------ Nikhil Goel 
<nikhil@smartbridges.com> <mailto:nikhil@smartbridges.com> 10, Anson 
Road Ph +65 3240210 Ext 20 International Plaza,#22-14 Fx +65 3240607 
Singapore 079903 ------------------------------------

A good reputation is more valuable than money.
-- Publilius Syrus

------------------------------------



--------------090306030106080001090200
Content-Type: text/plain;
 name="patch-vid-pegasus.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-vid-pegasus.txt"

--- drivers/usb/pegasus.h.orig	Mon Jan  1 12:54:29 2001
+++ drivers/usb/pegasus.h	Mon Jan  1 13:06:38 2001
@@ -140,7 +140,7 @@
 #define VENDOR_MELCO            0x0411
 #define VENDOR_SMC              0x0707
 #define VENDOR_SOHOWARE         0x15e8
-
+#define VENDOR_SMARTBRIDGES	0x08d1
 
 #else	/* PEGASUS_DEV */
 
@@ -193,6 +193,7 @@
 		DEFAULT_GPIO_RESET )
 PEGASUS_DEV( "SOHOware NUB100 Ethernet", VENDOR_SOHOWARE, 0x9100,
 		DEFAULT_GPIO_RESET )
-
+PEGASUS_DEV( "smartNIC 2 PnP Adapter", VENDOR_SMARTBRIDGES, 0x0003,
+		DEFAULT_GPIO_RESET | PEGASUS_II )
 
 #endif	/* PEGASUS_DEV */

--------------090306030106080001090200--

