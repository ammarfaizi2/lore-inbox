Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932771AbWCQU5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932771AbWCQU5I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWCQU4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:56:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:61098 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932769AbWCQU4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:56:37 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Matheus Izvekov <mizvekov@gmail.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 07/21] Cx88-input.c: add IR remote control support to
	CX88_BOARD_PROLINK_PLAYTVPVR
Date: Fri, 17 Mar 2006 17:54:34 -0300
Message-id: <20060317205434.PS57776500007@infradead.org>
In-Reply-To: <20060317205359.PS65198900000@infradead.org>
References: <20060317205359.PS65198900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Matheus Izvekov <mizvekov@gmail.com>
Date: 1142132098 \-0300

This patch adds support for the IR remote control found in the card
CX88_BOARD_PROLINK_PLAYTVPVR.

Signed-off-by: Matheus Izvekov <mizvekov@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx88/cx88-input.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/cx88/cx88-input.c b/drivers/media/video/cx88/cx88-input.c
index 165d948..0b7c812 100644
--- a/drivers/media/video/cx88/cx88-input.c
+++ b/drivers/media/video/cx88/cx88-input.c
@@ -517,6 +517,7 @@ int cx88_ir_init(struct cx88_core *core,
 		ir->mask_keydown = 0x02;
 		ir->polling = 5; /* ms */
 		break;
+       case CX88_BOARD_PROLINK_PLAYTVPVR:
 	case CX88_BOARD_PIXELVIEW_PLAYTV_ULTRA_PRO:
 		ir_codes = ir_codes_pixelview;
 		ir->gpio_addr = MO_GP1_IO;

