Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbULPWTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbULPWTI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 17:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbULPWS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 17:18:57 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55045 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262047AbULPWSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 17:18:11 -0500
Date: Thu, 16 Dec 2004 23:18:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] bttv-cards.c: #if 0 function bttv_reset_audio
Message-ID: <20041216221805.GU12937@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The function bttv_reset_audio in drivers/media/video/bttv-cards.c is
completely unused.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/drivers/media/video/bttv-cards.c.old	2004-12-16 22:20:07.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/drivers/media/video/bttv-cards.c	2004-12-16 22:20:30.000000000 +0100
@@ -2498,7 +2498,7 @@
 }
 
 /* ----------------------------------------------------------------------- */
-
+#if 0
 void bttv_reset_audio(struct bttv *btv)
 {
 	/*
@@ -2519,6 +2519,7 @@
 	udelay(10);
 	btwrite(     0, 0x058);
 }
+#endif  /*  0  */
 
 /* initialization part one -- before registering i2c bus */
 void __devinit bttv_init_card1(struct bttv *btv)
