Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262759AbVGKWJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbVGKWJI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbVGKWHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:07:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:60124 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262870AbVGKWDu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:03:50 -0400
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: drop bogus eeprom comment
In-Reply-To: <11211193763938@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 11 Jul 2005 15:02:56 -0700
Message-Id: <11211193762160@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: drop bogus eeprom comment

This simple patch drops an out-of-date comment in the eeprom i2c chip
driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 2db32767874fe53faff4f80de878ca19927efc1f
tree 4ac3024bd4e29e7770f96244b386429d991c58f7
parent a0920e10438e9fe8b22aba607083347c84458ed8
author Jean Delvare <khali@linux-fr.org> Thu, 23 Jun 2005 23:43:00 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 11 Jul 2005 14:10:36 -0700

 drivers/i2c/chips/eeprom.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c
+++ b/drivers/i2c/chips/eeprom.c
@@ -173,9 +173,6 @@ int eeprom_detect(struct i2c_adapter *ad
 					    | I2C_FUNC_SMBUS_BYTE))
 		goto exit;
 
-	/* OK. For now, we presume we have a valid client. We now create the
-	   client structure, even though we cannot fill it completely yet.
-	   But it allows us to access eeprom_{read,write}_value. */
 	if (!(data = kmalloc(sizeof(struct eeprom_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;

