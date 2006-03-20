Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965602AbWCTPzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965602AbWCTPzT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965598AbWCTPzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:55:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:25570 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966645AbWCTPTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:19:25 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 101/141] V4L/DVB (3368): KWorld HardwareMpegTV XPert:
	update comments
Date: Mon, 20 Mar 2006 12:08:53 -0300
Message-id: <20060320150853.PS831375000101@infradead.org>
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
Date: 1141009723 -0300

Standard video using the cx88 broadcast decoder is
working, but blackbird isn't working yet, audio is only
working correctly for television mode. S-Video and Composite
are working for video-only, so I have them disabled for now.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
diff --git a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
index 09f5739..cc9d660 100644
--- a/drivers/media/video/cx88/cx88-cards.c
+++ b/drivers/media/video/cx88/cx88-cards.c
@@ -1049,9 +1049,7 @@ struct cx88_board cx88_boards[] = {
 		.dvb            = 1,
 	},
 	[CX88_BOARD_KWORLD_HARDWARE_MPEG_TV_XPERT] = {
-		/* FIXME: This card is shipped without a windows tv app,
-		 * so I haven't been able to use regspy to figure out the GPIO
-		 * settings. Standard video using the cx88 broadcast decoder is
+		/* FIXME: Standard video using the cx88 broadcast decoder is
 		 * working, but blackbird isn't working yet, audio is only
 		 * working correctly for television mode. S-Video and Composite
 		 * are working for video-only, so I have them disabled for now.

