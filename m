Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263254AbVCDVXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263254AbVCDVXy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 16:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263239AbVCDVUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 16:20:03 -0500
Received: from mail.kroah.org ([69.55.234.183]:1442 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263156AbVCDUya convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:30 -0500
Cc: icampbell@arcom.com
Subject: [PATCH] I2C: fix typo in drivers/i2c/busses/i2c-ixp4xx.c
In-Reply-To: <11099685963312@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:36 -0800
Message-Id: <11099685961094@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2104, 2005/03/02 12:18:36-08:00, icampbell@arcom.com

[PATCH] I2C: fix typo in drivers/i2c/busses/i2c-ixp4xx.c

I was looking at your ixp4xx gpio i2c driver for inspiration (for a
similar pxa2xx one) and I just happened to notice a tiny typo.

Signed-off-by: Ian Campbell <icampbell@arcom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/busses/i2c-ixp4xx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ixp4xx.c b/drivers/i2c/busses/i2c-ixp4xx.c
--- a/drivers/i2c/busses/i2c-ixp4xx.c	2005-03-04 12:24:02 -08:00
+++ b/drivers/i2c/busses/i2c-ixp4xx.c	2005-03-04 12:24:02 -08:00
@@ -133,8 +133,8 @@
 	drv_data->algo_data.mdelay = 10;
 	drv_data->algo_data.timeout = 100;
 
-	drv_data->adapter.id = I2C_HW_B_IXP4XX,
-	drv_data->adapter.algo_data = &drv_data->algo_data,
+	drv_data->adapter.id = I2C_HW_B_IXP4XX;
+	drv_data->adapter.algo_data = &drv_data->algo_data;
 
 	drv_data->adapter.dev.parent = &plat_dev->dev;
 

