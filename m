Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbUKIAx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbUKIAx0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 19:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbUKIAxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 19:53:25 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21769 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261321AbUKIAwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 19:52:11 -0500
Date: Tue, 9 Nov 2004 01:51:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: [2/11] media/video/msp3400.c: remove unused struct d1
Message-ID: <20041109005139.GQ15077@stusta.de>
References: <20041107175017.GP14308@stusta.de> <20041108114008.GB20607@bytesex> <20041109004341.GO15077@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109004341.GO15077@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This struct is simply unused.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/media/video/msp3400.c.old	2004-11-07 17:01:28.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/msp3400.c	2004-11-07 17:01:57.000000000 +0100
@@ -633,14 +633,6 @@
 	char *name;
 };
 
-struct REGISTER_DUMP d1[] = {
-	{ 0x007e, "autodetect" },
-	{ 0x0023, "C_AD_BITS " },
-	{ 0x0038, "ADD_BITS  " },
-	{ 0x003e, "CIB_BITS  " },
-	{ 0x0057, "ERROR_RATE" },
-};
-
 static int
 autodetect_stereo(struct i2c_client *client)
 {

