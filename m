Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965815AbWCTQKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965815AbWCTQKQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966272AbWCTPOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:14:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18840 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966287AbWCTPOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:14:12 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 099/141] V4L/DVB (3365): Kworld ATSC110: cleanups
Date: Mon, 20 Mar 2006 12:08:53 -0300
Message-id: <20060320150853.PS506811000099@infradead.org>
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

From: Michael Krufky <mkrufky@linuxtv.org>
Date: 1141009716 -0300

- There is no radio with this tuner card...
  Thanks-to: Dwaine Garden <DwaineGarden@rogers.com>
- fixed capitalization in card name.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/Documentation/video4linux/CARDLIST.saa7134 b/Documentation/video4linux/CARDLIST.saa7134
diff --git a/Documentation/video4linux/CARDLIST.saa7134 b/Documentation/video4linux/CARDLIST.saa7134
index f74d2f9..e1484df 100644
--- a/Documentation/video4linux/CARDLIST.saa7134
+++ b/Documentation/video4linux/CARDLIST.saa7134
@@ -88,4 +88,4 @@
  87 -> ADS Instant TV Duo Cardbus PTV331        [0331:1421]
  88 -> Tevion DVB-T 220RF                       [17de:7201]
  89 -> ELSA EX-VISION 700TV                     [1131:7130]
- 90 -> KWORLD ATSC110                           [17de:7350]
+ 90 -> Kworld ATSC110                           [17de:7350]
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index 0cc171e..99cefdd 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -2732,7 +2732,7 @@ struct saa7134_board saa7134_boards[] = 
 		},
 	},
 	[SAA7134_BOARD_KWORLD_ATSC110] = {
-		.name           = "KWORLD ATSC110",
+		.name           = "Kworld ATSC110",
 		.audio_clock    = 0x00187de7,
 		.tuner_type     = TUNER_PHILIPS_TUV1236D,
 		.radio_type     = UNSET,

