Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965192AbWCTPQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965192AbWCTPQY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966452AbWCTPQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:16:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41112 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965191AbWCTPQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:16:20 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Markus Rechberger <mrechberger@gmail.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 032/141] V4L/DVB (3434): changed comment in tuner-core.c
Date: Mon, 20 Mar 2006 12:08:42 -0300
Message-id: <20060320150842.PS346496000032@infradead.org>
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
Date: 1138043471 -0200

- changed comment in tuner-core.c

Signed-off-by: Markus Rechberger <mrechberger@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
index cd2d5a7..788eada 100644
--- a/drivers/media/video/tuner-core.c
+++ b/drivers/media/video/tuner-core.c
@@ -450,7 +450,7 @@ static int tuner_attach(struct i2c_adapt
 			printk("%02x ",buffer[i]);
 		printk("\n");
 	}
-	/* TEA5767 autodetection code - only for addr = 0xc0 */
+	/* autodetection code based on the i2c addr */
 	if (!no_autodetect) {
 		switch (addr) {
 		case 0x42:

