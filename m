Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbWCTPoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbWCTPoA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965395AbWCTPnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:43:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15032 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964879AbWCTPYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:24:10 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 037/141] V4L/DVB (3442): Allow tristate build for
	cx88-vp3054-i2c
Date: Mon, 20 Mar 2006 12:08:43 -0300
Message-id: <20060320150843.PS181625000037@infradead.org>
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
Date: 1138257439 -0200

- allow tristate build for cx88-vp3054-i2c

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/cx88/Makefile b/drivers/media/video/cx88/Makefile
diff --git a/drivers/media/video/cx88/Makefile b/drivers/media/video/cx88/Makefile
index e78da88..2b90278 100644
--- a/drivers/media/video/cx88/Makefile
+++ b/drivers/media/video/cx88/Makefile
@@ -4,8 +4,9 @@ cx8800-objs	:= cx88-video.o cx88-vbi.o
 cx8802-objs	:= cx88-mpeg.o
 
 obj-$(CONFIG_VIDEO_CX88) += cx88xx.o cx8800.o cx8802.o cx88-blackbird.o
-obj-$(CONFIG_VIDEO_CX88_DVB) += cx88-dvb.o cx88-vp3054-i2c.o
+obj-$(CONFIG_VIDEO_CX88_DVB) += cx88-dvb.o
 obj-$(CONFIG_VIDEO_CX88_ALSA) += cx88-alsa.o
+obj-$(CONFIG_VIDEO_CX88_VP3054) += cx88-vp3054-i2c.o
 
 EXTRA_CFLAGS += -I$(src)/..
 EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/dvb-core

