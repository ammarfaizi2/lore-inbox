Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbTDXXvh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264520AbTDXXvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:51:18 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:46255 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264544AbTDXXpG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:45:06 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10512287463226@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.68
In-Reply-To: <10512287462983@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 24 Apr 2003 16:59:06 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1179.3.3, 2003/04/23 11:33:28-07:00, hch@lst.de

[PATCH] i2c: remove dead init code from i2c-sensors.c


 drivers/i2c/i2c-sensor.c |   12 ------------
 1 files changed, 12 deletions(-)


diff -Nru a/drivers/i2c/i2c-sensor.c b/drivers/i2c/i2c-sensor.c
--- a/drivers/i2c/i2c-sensor.c	Thu Apr 24 16:47:26 2003
+++ b/drivers/i2c/i2c-sensor.c	Thu Apr 24 16:47:26 2003
@@ -163,20 +163,8 @@
 	return 0;
 }
 
-static int __init i2c_sensor_init(void)
-{
-	return 0;
-}
-
-static void __exit i2c_sensor_exit(void)
-{
-}
-
 EXPORT_SYMBOL(i2c_detect);
 
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
 MODULE_DESCRIPTION("i2c-sensor driver");
 MODULE_LICENSE("GPL");
-
-module_init(i2c_sensor_init);
-module_exit(i2c_sensor_exit);

