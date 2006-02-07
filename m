Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWBGPlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWBGPlG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWBGPlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:41:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48028 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751120AbWBGPkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:40:42 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Marco Manenti <marco_manenti@colman.it>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 05/16] Add IR support to KWorld DVB-T (cx22702-based)
Date: Tue, 07 Feb 2006 13:33:30 -0200
Message-id: <20060207153330.PS80815300005@infradead.org>
In-Reply-To: <20060207153248.PS50860900000@infradead.org>
References: <20060207153248.PS50860900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Manenti <marco_manenti@colman.it>

add IR support to KWorld DVB-T (cx22702-based)

Signed-off-by: Marco Manenti <marco_manenti@colman.it>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx88/cx88-input.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/cx88/cx88-input.c b/drivers/media/video/cx88/cx88-input.c
index da2ad5c..165d948 100644
--- a/drivers/media/video/cx88/cx88-input.c
+++ b/drivers/media/video/cx88/cx88-input.c
@@ -482,6 +482,7 @@ int cx88_ir_init(struct cx88_core *core,
 	switch (core->board) {
 	case CX88_BOARD_DNTV_LIVE_DVB_T:
 	case CX88_BOARD_KWORLD_DVB_T:
+	case CX88_BOARD_KWORLD_DVB_T_CX22702:
 		ir_codes = ir_codes_dntv_live_dvb_t;
 		ir->gpio_addr = MO_GP1_IO;
 		ir->mask_keycode = 0x1f;

