Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbSLBS1U>; Mon, 2 Dec 2002 13:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264767AbSLBS1U>; Mon, 2 Dec 2002 13:27:20 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:4992 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S264739AbSLBS1T>;
	Mon, 2 Dec 2002 13:27:19 -0500
Date: Mon, 2 Dec 2002 19:34:43 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.50-current-bk v4l2: too few spaces in struct definition
Message-ID: <20021202183443.GA9798@vana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
    "static structi2c_clientclient_template" works much better
when spaces are added at appropriate places.
						Petr Vandrovec


diff -urdN linux/drivers/media/video/tuner.c linux/drivers/media/video/tuner.c
--- linux/drivers/media/video/tuner.c	2002-12-02 17:28:22.000000000 +0000
+++ linux/drivers/media/video/tuner.c	2002-12-02 17:42:56.000000000 +0000
@@ -982,7 +982,7 @@
 	.detach_client	= tuner_detach,
 	.command	= tuner_command,
 };
-static structi2c_clientclient_template = 
+static struct i2c_client client_template = 
 {
 	.name	= "(tunerunset)",
 	.flags	= I2C_CLIENT_ALLOW_USE,
