Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965270AbWCTPWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965270AbWCTPWb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbWCTPW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:22:29 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50402 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964820AbWCTPV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:21:56 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Hartmut Hackmann <hartmut.hackmann@t-online.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 130/141] V4L/DVB (3401): Coding style fixes in saa7134-dvb.c
Date: Mon, 20 Mar 2006 12:08:58 -0300
Message-id: <20060320150858.PS714367000130@infradead.org>
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

From: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Date: 1141085676 -0300

deleted 2 semicolons at end of functions

Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/saa7134/saa7134-dvb.c b/drivers/media/video/saa7134/saa7134-dvb.c
diff --git a/drivers/media/video/saa7134/saa7134-dvb.c b/drivers/media/video/saa7134/saa7134-dvb.c
index ad34eb5..86cfdb8 100644
--- a/drivers/media/video/saa7134/saa7134-dvb.c
+++ b/drivers/media/video/saa7134/saa7134-dvb.c
@@ -814,7 +814,7 @@ static int philips_tiger_pll_set(struct 
 	tda8290_msg.buf = tda8290_open;
 	i2c_transfer(&dev->i2c_adap, &tda8290_msg, 1);
 	return ret;
-};
+}
 
 static int philips_tiger_dvb_mode(struct dvb_frontend *fe)
 {
@@ -891,7 +891,7 @@ static int ads_duo_pll_set(struct dvb_fr
 
 	ret = philips_tda827xa_pll_set(0x61, fe, params);
 	return ret;
-};
+}
 
 static int ads_duo_dvb_mode(struct dvb_frontend *fe)
 {

