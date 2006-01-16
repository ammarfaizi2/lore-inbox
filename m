Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWAPJWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWAPJWy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWAPJW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:22:29 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24555 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932266AbWAPJWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:22:17 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 05/25] Build cx88-alsa when CONFIG_VIDEO_CX88_ALSA is
	selected.
Date: Mon, 16 Jan 2006 07:11:20 -0200
Message-id: <20060116091120.PS12796800005@infradead.org>
In-Reply-To: <20060116091105.PS83611600000@infradead.org>
References: <20060116091105.PS83611600000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Michael Krufky <mkrufky@m1k.net>

- Build cx88-alsa when CONFIG_VIDEO_CX88_ALSA is selected.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx88/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/cx88/Makefile b/drivers/media/video/cx88/Makefile
index e4b2134..6e5eaa2 100644
--- a/drivers/media/video/cx88/Makefile
+++ b/drivers/media/video/cx88/Makefile
@@ -5,6 +5,7 @@ cx8802-objs	:= cx88-mpeg.o
 
 obj-$(CONFIG_VIDEO_CX88) += cx88xx.o cx8800.o cx8802.o cx88-blackbird.o
 obj-$(CONFIG_VIDEO_CX88_DVB) += cx88-dvb.o cx88-vp3054-i2c.o
+obj-$(CONFIG_VIDEO_CX88_ALSA) += cx88-alsa.o
 
 EXTRA_CFLAGS += -I$(src)/..
 EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/dvb-core

