Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbTEZODa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 10:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264385AbTEZODa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 10:03:30 -0400
Received: from static213-229-38-018.adsl.inode.at ([213.229.38.18]:36505 "HELO
	home.winischhofer.net") by vger.kernel.org with SMTP
	id S264376AbTEZOD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 10:03:29 -0400
Message-ID: <3ED2219C.2040303@winischhofer.net>
Date: Mon, 26 May 2003 16:15:56 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030521 Debian/1.3.1-1
X-Accept-Language: en-us, en, de-at, de, de-de, sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] SiS651 AGP support (2.4)
Content-Type: multipart/mixed;
 boundary="------------080501090203040905050006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080501090203040905050006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Patch to add (generic) AGPgart support for the SiS651. Please apply.

-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net          *** http://www.winischhofer.net/
mailto:twini@xfree86.org

--------------080501090203040905050006
Content-Type: text/plain;
 name="sisagp_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sisagp_patch"

--- drivers/char/agp/agpgart_be.c_old	2003-05-26 16:11:13.000000000 +0200
+++ drivers/char/agp/agpgart_be.c	2003-05-26 16:11:47.000000000 +0200
@@ -4571,6 +4571,12 @@
 		"SiS",
 		"650",
 		sis_generic_setup },
+	{ PCI_DEVICE_ID_SI_651,
+		PCI_VENDOR_ID_SI,
+		SIS_GENERIC,
+		"SiS",
+		"651",
+		sis_generic_setup },
 	{ PCI_DEVICE_ID_SI_645,
 		PCI_VENDOR_ID_SI,
 		SIS_GENERIC,

--------------080501090203040905050006--

