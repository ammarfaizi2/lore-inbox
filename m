Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272606AbTHKOAL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272607AbTHKNnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:43:15 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:34187 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272606AbTHKNk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:40:58 -0400
To: torvalds@transmeta.com
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] c99 initialisers for bttv
Message-Id: <E19mCuP-0003dg-00@tetrachloride>
Date: Mon, 11 Aug 2003 14:40:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/media/video/bttv-cards.c linux-2.5/drivers/media/video/bttv-cards.c
--- bk-linus/drivers/media/video/bttv-cards.c	2003-08-09 03:10:37.000000000 +0100
+++ linux-2.5/drivers/media/video/bttv-cards.c	2003-08-09 03:33:27.000000000 +0100
@@ -1211,7 +1211,7 @@ struct tvcard bttv_tvcards[] = {
 	.tuner_type     = -1,
 	.pll            = PLL_28,
 	.muxsel         = { 2 },
-	gpiomask:       0
+	.gpiomask       = 0
 },{
         /* Tomasz Pyra <hellfire@sedez.iq.pl> */
         .name           = "Prolink Pixelview PV-BT878P+ (Rev.4C,8E)",
@@ -1298,7 +1298,7 @@ struct tvcard bttv_tvcards[] = {
 },{
         .name           = "Powercolor MTV878/ MTV878R/ MTV878F",
         .video_inputs   = 3,
-        audio_inputs:   2, 
+        .audio_inputs   = 2, 
 	.tuner		= 0,
         .svhs           = 2,
         .gpiomask       = 0x1C800F,  // Bit0-2: Audio select, 8-12:remote control 14:remote valid 15:remote reset
@@ -1338,7 +1338,7 @@ struct tvcard bttv_tvcards[] = {
 },{
         .name           = "Jetway TV/Capture JW-TV878-FBK, Kworld KW-TV878RF",
         .video_inputs   = 4,
-        audio_inputs:   3, 
+        .audio_inputs   = 3, 
         .tuner          = 0,
         .svhs           = 2,
         .gpiomask       = 7,
