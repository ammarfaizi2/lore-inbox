Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWIGJ56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWIGJ56 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 05:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWIGJ55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 05:57:57 -0400
Received: from 84.ipsec.info ([194.1.141.84]:29961 "EHLO nms.sk")
	by vger.kernel.org with ESMTP id S1751461AbWIGJ54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 05:57:56 -0400
Subject: [PATCH 2.6.18-rc6] USB Storage: unusual_devs.h entry for Sony
	Ericsson P990i
From: Jan Mate <mate@fiit.stuba.sk>
To: mdharm-usb@one-eyed-alien.net
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Faculty of Informatics and Information Technologies
Date: Thu, 07 Sep 2006 11:57:40 +0200
Message-Id: <1157623060.6969.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Mate <mate@fiit.stuba.sk>

USB Storage: this patch adds support for Sony Ericsson P990i

Signed-off-by: Jan Mate <mate@fiit.stuba.sk>

---

diff -ru linux-2.6.18-rc6-clean/drivers/usb/storage/unusual_devs.h linux-2.6.18-rc6-mod/drivers/usb/storage/unusual_devs.h
--- linux-2.6.18-rc6-clean/drivers/usb/storage/unusual_devs.h	2006-09-07 11:15:34.000000000 +0200
+++ linux-2.6.18-rc6-mod/drivers/usb/storage/unusual_devs.h	2006-09-07 11:17:07.000000000 +0200
@@ -1261,6 +1261,13 @@
 		US_SC_DEVICE, US_PR_DEVICE, NULL,
 		US_FL_FIX_CAPACITY ),
 
+/* Reported by Jan Mate <mate@fiit.stuba.sk> */
+UNUSUAL_DEV(  0x0fce, 0xe030, 0x0000, 0x0000,
+		"Sony Ericsson",
+		"P990i",
+		US_SC_DEVICE, US_PR_DEVICE, NULL,
+		US_FL_FIX_CAPACITY ),
+
 /* Reported by Kevin Cernekee <kpc-usbdev@gelato.uiuc.edu>
  * Tested on hardware version 1.10.
  * Entry is needed only for the initializer function override.


