Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966384AbWCTPPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966384AbWCTPPd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966383AbWCTPPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:15:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32664 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966386AbWCTPPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:15:30 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Adrian Bunk <bunk@stusta.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 140/141] V4L/DVB (3414): Saa7134: document that there's
	also a 220RF from KWorld
Date: Mon, 20 Mar 2006 12:09:00 -0300
Message-id: <20060320150900.PS345873000140@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: 1141825806 -0300

I have the same card with the same PCI id, but from KWorld.
The patch documents that this is the same card.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/Documentation/video4linux/CARDLIST.saa7134 b/Documentation/video4linux/CARDLIST.saa7134
diff --git a/Documentation/video4linux/CARDLIST.saa7134 b/Documentation/video4linux/CARDLIST.saa7134
index 17ea5a0..874ffc4 100644
--- a/Documentation/video4linux/CARDLIST.saa7134
+++ b/Documentation/video4linux/CARDLIST.saa7134
@@ -86,6 +86,6 @@
  85 -> AverTV DVB-T 777                         [1461:2c05]
  86 -> LifeView FlyDVB-T                        [5168:0301]
  87 -> ADS Instant TV Duo Cardbus PTV331        [0331:1421]
- 88 -> Tevion DVB-T 220RF                       [17de:7201]
+ 88 -> Tevion/KWorld DVB-T 220RF                [17de:7201]
  89 -> ELSA EX-VISION 700TV                     [1048:226c]
  90 -> Kworld ATSC110                           [17de:7350]
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index ea2fa0d..4071313 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -2706,7 +2706,7 @@ struct saa7134_board saa7134_boards[] = 
 		}},
 	},
 	[SAA7134_BOARD_TEVION_DVBT_220RF] = {
-		.name           = "Tevion DVB-T 220RF",
+		.name           = "Tevion/KWorld DVB-T 220RF",
 		.audio_clock    = 0x00187de7,
 		.tuner_type     = TUNER_PHILIPS_TDA8290,
 		.radio_type     = UNSET,

