Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965277AbWCTPXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965277AbWCTPXA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965275AbWCTPWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:22:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52706 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964939AbWCTPWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:22:30 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Markus Rechberger <mrechberger@gmail.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 050/141] V4L/DVB (3280): Changed description of KWorld PVR
	TV 2800RF
Date: Mon, 20 Mar 2006 12:08:45 -0300
Message-id: <20060320150845.PS321683000050@infradead.org>
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

From: Markus Rechberger <mrechberger@gmail.com>
Date: 1139300741 -0200

Changed description of KWorld PVR TV 2800RF

Signed-off-by: Markus Rechberger <mrechberger@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/Documentation/video4linux/CARDLIST.em28xx b/Documentation/video4linux/CARDLIST.em28xx
diff --git a/Documentation/video4linux/CARDLIST.em28xx b/Documentation/video4linux/CARDLIST.em28xx
index 7a903f7..a302668 100644
--- a/Documentation/video4linux/CARDLIST.em28xx
+++ b/Documentation/video4linux/CARDLIST.em28xx
@@ -8,4 +8,4 @@
   7 -> Leadtek Winfast USB II                   (em2800)
   8 -> Kworld USB2800                           (em2800)
   9 -> Pinnacle Dazzle DVC 90                   (em2820/em2840) [2304:0207]
- 12 -> Unknown EM2820/2840 video grabber        (em2820/em2840)
+ 12 -> Kworld PVR TV 2800 RF                    (em2820/em2840)
diff --git a/drivers/media/video/em28xx/em28xx-cards.c b/drivers/media/video/em28xx/em28xx-cards.c
diff --git a/drivers/media/video/em28xx/em28xx-cards.c b/drivers/media/video/em28xx/em28xx-cards.c
index 573d24d..a9e7cec 100644
--- a/drivers/media/video/em28xx/em28xx-cards.c
+++ b/drivers/media/video/em28xx/em28xx-cards.c
@@ -73,7 +73,7 @@ struct em28xx_board em28xx_boards[] = {
 		}},
 	},
 	[EM2820_BOARD_KWORLD_PVRTV2800RF] = {
-		.name         = "Unknown EM2820/2840 video grabber",
+		.name         = "Kworld PVR TV 2800 RF",
 		.is_em2800    = 0,
 		.vchannels    = 2,
 		.norm         = VIDEO_MODE_PAL,

