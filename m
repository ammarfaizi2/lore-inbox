Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265155AbUATAWB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265188AbUATAUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:20:07 -0500
Received: from mail.kroah.org ([65.200.24.183]:30636 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265155AbUATAAP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:00:15 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
In-Reply-To: <10745567603666@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 15:59:21 -0800
Message-Id: <10745567611379@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.98.8, 2004/01/14 11:19:29-08:00, khali@linux-fr.org

[PATCH] I2C: i2c-rpx.c doesn't need ioports.h nor parport.h

One more simple patch... These headers are useless as far as I can see.


 drivers/i2c/busses/i2c-rpx.c |    2 --
 1 files changed, 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-rpx.c b/drivers/i2c/busses/i2c-rpx.c
--- a/drivers/i2c/busses/i2c-rpx.c	Mon Jan 19 15:31:59 2004
+++ b/drivers/i2c/busses/i2c-rpx.c	Mon Jan 19 15:31:59 2004
@@ -12,11 +12,9 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/stddef.h>
-#include <linux/parport.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-8xx.h>
 #include <asm/mpc8xx.h>

