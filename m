Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265351AbTL3WYC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265844AbTL3WOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:14:06 -0500
Received: from mail.kroah.org ([65.200.24.183]:53953 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265351AbTL3WGf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:06:35 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.0
In-Reply-To: <10728219741342@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Dec 2003 14:06:14 -0800
Message-Id: <10728219742126@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1496.9.5, 2003/12/04 13:53:21-08:00, khali@linux-fr.org

[PATCH] I2C: fix author of i2c-savage4.c driver

This patch rehabilitates Alexander Wold as the author of the i2c-savage4
driver. For some reason, his name was not mentioned anywhere in the
first place.

The change was requested by Alexander Wold himself.


 drivers/i2c/busses/i2c-savage4.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-savage4.c b/drivers/i2c/busses/i2c-savage4.c
--- a/drivers/i2c/busses/i2c-savage4.c	Tue Dec 30 12:31:52 2003
+++ b/drivers/i2c/busses/i2c-savage4.c	Tue Dec 30 12:31:52 2003
@@ -1,13 +1,11 @@
 /*
     i2c-savage4.c - Part of lm_sensors, Linux kernel modules for hardware
               monitoring
-    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>,
-    Philip Edelbrock <phil@netroedge.com>,
-    Ralph Metzler <rjkm@thp.uni-koeln.de>, and
+    Copyright (C) 1998-2003  The LM Sensors Team
+    Alexander Wold <awold@bigfoot.com>
     Mark D. Studebaker <mdsxyz123@yahoo.com>
     
-    Based on code written by Ralph Metzler <rjkm@thp.uni-koeln.de> and
-    Simon Vogl
+    Based on i2c-voodoo3.c.
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -195,9 +193,7 @@
 	pci_unregister_driver(&savage4_driver);
 }
 
-MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>, "
-		"Philip Edelbrock <phil@netroedge.com>, "
-		"Ralph Metzler <rjkm@thp.uni-koeln.de>, "
+MODULE_AUTHOR("Alexander Wold <awold@bigfoot.com> "
 		"and Mark D. Studebaker <mdsxyz123@yahoo.com>");
 MODULE_DESCRIPTION("Savage4 I2C/SMBus driver");
 MODULE_LICENSE("GPL");

