Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbVCaXpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbVCaXpo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 18:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbVCaXkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 18:40:14 -0500
Received: from mail.kroah.org ([69.55.234.183]:37344 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262113AbVCaXYK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 18:24:10 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Cleanup adm1021 unused defines
In-Reply-To: <11123113902683@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 31 Mar 2005 15:23:10 -0800
Message-Id: <11123113902974@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2325, 2005/03/31 14:06:09-08:00, khali@linux-fr.org

[PATCH] I2C: Cleanup adm1021 unused defines

While working on the adm1021 driver, I found that this driver has a
number of unused (and useless) defines we could get rid of.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/adm1021.c |   12 ------------
 1 files changed, 12 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	2005-03-31 15:19:00 -08:00
+++ b/drivers/i2c/chips/adm1021.c	2005-03-31 15:19:00 -08:00
@@ -28,18 +28,6 @@
 #include <linux/i2c-sensor.h>
 
 
-/* Registers */
-#define ADM1021_SYSCTL_TEMP		1200
-#define ADM1021_SYSCTL_REMOTE_TEMP	1201
-#define ADM1021_SYSCTL_DIE_CODE		1202
-#define ADM1021_SYSCTL_ALARMS		1203
-
-#define ADM1021_ALARM_TEMP_HIGH		0x40
-#define ADM1021_ALARM_TEMP_LOW		0x20
-#define ADM1021_ALARM_RTEMP_HIGH	0x10
-#define ADM1021_ALARM_RTEMP_LOW		0x08
-#define ADM1021_ALARM_RTEMP_NA		0x04
-
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x18, 0x19, 0x1a,
 					0x29, 0x2a, 0x2b,

