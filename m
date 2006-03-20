Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965177AbWCTQHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965177AbWCTQHf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965767AbWCTQHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:07:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:28056 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966355AbWCTPPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:15:08 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 029/141] V4L/DVB (3431): fixed spelling error, exectuted
	--> executed.
Date: Mon, 20 Mar 2006 12:08:41 -0300
Message-id: <20060320150841.PS852556000029@infradead.org>
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

From: Michael Krufky <mkrufky@m1k.net>
Date: 1138043470 -0200

- fixed spelling error, exectuted --> executed.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/em28xx/em28xx-core.c b/drivers/media/video/em28xx/em28xx-core.c
diff --git a/drivers/media/video/em28xx/em28xx-core.c b/drivers/media/video/em28xx/em28xx-core.c
index dff3893..82f0c5f 100644
--- a/drivers/media/video/em28xx/em28xx-core.c
+++ b/drivers/media/video/em28xx/em28xx-core.c
@@ -253,7 +253,7 @@ int em28xx_write_ac97(struct em28xx *dev
 	if ((ret = em28xx_read_reg(dev, AC97BUSY_REG)) < 0)
 		return ret;
 	else if (((u8) ret) & 0x01) {
-		em28xx_warn ("AC97 command still being exectuted: not handled properly!\n");
+		em28xx_warn ("AC97 command still being executed: not handled properly!\n");
 	}
 	return 0;
 }

