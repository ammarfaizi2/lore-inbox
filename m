Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268205AbTAMSjV>; Mon, 13 Jan 2003 13:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268211AbTAMSjV>; Mon, 13 Jan 2003 13:39:21 -0500
Received: from m36.net195-132-182.noos.fr ([195.132.182.36]:41346 "EHLO
	epoch.matrix.net") by vger.kernel.org with ESMTP id <S268205AbTAMSjT>;
	Mon, 13 Jan 2003 13:39:19 -0500
Message-ID: <3E2309D9.8020301@no-log.org>
Date: Mon, 13 Jan 2003 19:47:53 +0100
From: Antoniu-George SAVU <santoniu@no-log.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Patch pci_ids.h [2.5.56]
Content-Type: multipart/mixed;
 boundary="------------080704090506050804080903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080704090506050804080903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
The nForce NVidia IDE PCI id is missing from include/linux/pci_ids.h . 
The patch is attached.

Cheers,
G.

--------------080704090506050804080903
Content-Type: text/plain;
 name="pci_ids.h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci_ids.h.patch"

--- include/linux/pci_ids.h.00	2003-01-13 19:40:04.000000000 +0100
+++ include/linux/pci_ids.h	2003-01-13 19:40:44.000000000 +0100
@@ -994,6 +994,7 @@
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_900XGL	0x0258
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_750XGL	0x0259
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_700XGL	0x025B
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_IDE		0x0065
 
 #define PCI_VENDOR_ID_IMS		0x10e0
 #define PCI_DEVICE_ID_IMS_8849		0x8849

--------------080704090506050804080903--

