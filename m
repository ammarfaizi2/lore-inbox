Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbTIYVvs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 17:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbTIYVvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 17:51:43 -0400
Received: from mail.kroah.org ([65.200.24.183]:33180 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261910AbTIYVug convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 17:50:36 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1064526609700@kroah.com>
Subject: Re: [PATCH] More i2c driver fixes for 2.6.0-test5
In-Reply-To: <1064526609144@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 25 Sep 2003 14:50:09 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1325.5.2, 2003/09/24 15:01:39-07:00, greg@kroah.com

[PATCH] I2C: remove unneeded #defines in the eeprom chip driver.


 drivers/i2c/chips/eeprom.c |    7 -------
 1 files changed, 7 deletions(-)


diff -Nru a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c	Thu Sep 25 14:49:30 2003
+++ b/drivers/i2c/chips/eeprom.c	Thu Sep 25 14:49:30 2003
@@ -47,13 +47,6 @@
 /* EEPROM registers */
 #define EEPROM_REG_CHECKSUM	0x3f
 
-/* EEPROM memory types: */
-#define ONE_K			1
-#define TWO_K			2
-#define FOUR_K			3
-#define EIGHT_K			4
-#define SIXTEEN_K		5
-
 /* Size of EEPROM in bytes */
 #define EEPROM_SIZE		256
 

