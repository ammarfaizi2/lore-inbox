Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVAHB37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVAHB37 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 20:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVAHB36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 20:29:58 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27660 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261752AbVAHB3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 20:29:04 -0500
Date: Sat, 8 Jan 2005 02:29:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Gerd Knorr <kraxel@bytesex.org>, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] bttv-cards.c: #if 0 function bttv_reset_audio (fwd)
Message-ID: <20050108012900.GM14108@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 2.6.10-mm2.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Thu, 16 Dec 2004 23:18:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] bttv-cards.c: #if 0 function bttv_reset_audio

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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

