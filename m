Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWCRRWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWCRRWT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 12:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWCRRVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 12:21:44 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:15349 "EHLO
	linux") by vger.kernel.org with ESMTP id S1750728AbWCRRVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 12:21:22 -0500
Message-Id: <20060318171948.235827000@towertech.it>
References: <20060318171946.821316000@towertech.it>
User-Agent: quilt/0.43-1
Date: Sat, 18 Mar 2006 18:19:53 +0100
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au
Subject: [PATCH 07/18] RTC subsystem, I2C driver ids
Content-Disposition: inline; filename=rtc-i2c-ids.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the I2C driver ids to i2c-id.h
in preparation of the I2C direct probing method.

This is kept separate so that it can be integrated to
different patchsets without conficts.

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>

---
 include/linux/i2c-id.h |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-rtc.orig/include/linux/i2c-id.h	2006-03-03 00:15:32.000000000 +0100
+++ linux-rtc/include/linux/i2c-id.h	2006-03-15 03:08:52.000000000 +0100
@@ -108,6 +108,10 @@
 #define I2C_DRIVERID_UPD64083	78	/* upd64083 video processor	*/
 #define I2C_DRIVERID_UPD64031A	79	/* upd64031a video processor	*/
 #define I2C_DRIVERID_SAA717X	80	/* saa717x video encoder	*/
+#define I2C_DRIVERID_DS1672	81	/* Dallas/Maxim DS1672 RTC	*/
+#define I2C_DRIVERID_X1205	82	/* Xicor/Intersil X1205 RTC	*/
+#define I2C_DRIVERID_PCF8563	83	/* Philips PCF8563 RTC		*/
+#define I2C_DRIVERID_RS5C372	84	/* Ricoh RS5C372 RTC		*/
 
 #define I2C_DRIVERID_I2CDEV	900
 #define I2C_DRIVERID_ARP        902    /* SMBus ARP Client              */

--
