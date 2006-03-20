Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbWCTPiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWCTPiZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWCTPiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:38:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:25784 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964885AbWCTPZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:25:12 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, BoyZonder <boyzonder@spymac.com>,
       Ricardo Cerqueira <v4l@cerqueira.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 093/141] V4L/DVB (3349): Remote control codes for
	BTTV_BOARD_CONTVFMI
Date: Mon, 20 Mar 2006 12:08:52 -0300
Message-id: <20060320150852.PS525502000093@infradead.org>
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

From: BoyZonder <boyzonder@spymac.com>
Date: 1141009695 -0300

The remote control interface for this board is the same as the one for 
BTTV_BOARD_CONCEPTRONIC_CTVFMI2

Signed-off-by: Ricardo Cerqueira <v4l@cerqueira.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/bttv-input.c b/drivers/media/video/bttv-input.c
diff --git a/drivers/media/video/bttv-input.c b/drivers/media/video/bttv-input.c
index c637677..69efa0e 100644
--- a/drivers/media/video/bttv-input.c
+++ b/drivers/media/video/bttv-input.c
@@ -328,6 +328,7 @@ int bttv_input_init(struct bttv *btv)
 		ir->polling      = 50; // ms
 		break;
 	case BTTV_BOARD_CONCEPTRONIC_CTVFMI2:
+	case BTTV_BOARD_CONTVFMI:
 		ir_codes         = ir_codes_pixelview;
 		ir->mask_keycode = 0x001F00;
 		ir->mask_keyup   = 0x006000;

