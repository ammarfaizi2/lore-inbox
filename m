Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754577AbWKMMYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577AbWKMMYs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 07:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754571AbWKMMYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 07:24:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:22225 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1754560AbWKMMXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 07:23:48 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, "pasky@ucw.cz" <pasky@ucw.cz>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 6/8] V4L/DVB (4816): Change tuner type for Avermedia A16AR
Date: Mon, 13 Nov 2006 10:18:44 -0200
Message-id: <20061113121844.PS3412290006@infradead.org>
In-Reply-To: <20061113121504.PS7687690000@infradead.org>
References: <20061113121504.PS7687690000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: pasky@ucw.cz <pasky@ucw.cz>

This changes it from TDA8290 which is allegedly very unlikely to TD1316 which
is allegedly very likely. I didn't get it to work with either, but expected
that this got applied when Mauro sent it to me, so here it goes again; feel
free to drop it to the floor. :-)

Signed-off-by: Petr Baudis <pasky@ucw.cz>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/saa7134/saa7134-cards.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index 1a402e4..51f0cfd 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -2969,7 +2969,7 @@ struct saa7134_board saa7134_boards[] = 
 		/* Petr Baudis <pasky@ucw.cz> */
 		.name           = "AVerMedia TV Hybrid A16AR",
 		.audio_clock    = 0x187de7,
-		.tuner_type     = TUNER_PHILIPS_TDA8290, /* untested */
+		.tuner_type     = TUNER_PHILIPS_TD1316, /* untested */
 		.radio_type     = TUNER_TEA5767, /* untested */
 		.tuner_addr     = ADDR_UNSET,
 		.radio_addr     = ADDR_UNSET,

