Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbWCWSBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbWCWSBl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 13:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWCWSBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 13:01:41 -0500
Received: from build.arklinux.osuosl.org ([140.211.166.26]:14812 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S964929AbWCWSBk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 13:01:40 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: akpm@osdl.org
Subject: [PATCH] 2.6.16-mm1 x1205 RTC driver doesn't compile
Date: Thu, 23 Mar 2006 18:54:45 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603231854.45960.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rtc-x1205 uses I2C_DRIVERID_X1205 without defining it.

Signed-off-by: Bernhard Rosenkraenzer <bero@arklinux.org>

---
--- linux-2.6.16/include/linux/i2c-id.h.ark	2006-03-23 18:56:50.000000000 
+0100
+++ linux-2.6.16/include/linux/i2c-id.h	2006-03-23 18:56:22.000000000 +0100
@@ -108,6 +108,7 @@
 #define I2C_DRIVERID_UPD64083	78	/* upd64083 video processor	*/
 #define I2C_DRIVERID_UPD64031A	79	/* upd64031a video processor	*/
 #define I2C_DRIVERID_SAA717X	80	/* saa717x video encoder	*/
+#define I2C_DRIVERID_X1205	81	/* X1205 RTC			*/
 
 #define I2C_DRIVERID_I2CDEV	900
 #define I2C_DRIVERID_ARP        902    /* SMBus ARP Client              */
