Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263070AbTIWADY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 20:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbTIWAB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 20:01:58 -0400
Received: from mail.kroah.org ([65.200.24.183]:31137 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262841AbTIVXbb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:31:31 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10642734162392@kroah.com>
Subject: [PATCH] i2c driver fixes for 2.6.0-test5
In-Reply-To: <20030922232846.GA800@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 22 Sep 2003 16:30:16 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1153.85.1, 2003/08/27 15:24:53-07:00, greg@kroah.com

[PATCH] I2C: added new id for Radeon driver.

As requested by kronos@kronoz.cjb.net


 include/linux/i2c-id.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/include/linux/i2c-id.h b/include/linux/i2c-id.h
--- a/include/linux/i2c-id.h	Mon Sep 22 16:17:15 2003
+++ b/include/linux/i2c-id.h	Mon Sep 22 16:17:15 2003
@@ -100,7 +100,7 @@
 #define I2C_DRIVERID_STM41T00	52	/* real time clock		*/
 #define I2C_DRIVERID_UDA1342	53	/* UDA1342 audio codec		*/
 #define I2C_DRIVERID_ADV7170	54	/* video encoder		*/
-
+#define I2C_DRIVERID_RADEON	55	/* I2C bus on Radeon boards	*/
 
 
 #define I2C_DRIVERID_EXP0	0xF0	/* experimental use id's	*/

