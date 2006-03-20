Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbWCTPT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWCTPT7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966702AbWCTPT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:19:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:30690 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966696AbWCTPT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:19:56 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Adrian Bunk <bunk@stusta.de>,
       Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 007/141] V4L/DVB: VIDEO_CX88_ALSA must select SND_PCM
Date: Mon, 20 Mar 2006 12:08:38 -0300
Message-id: <20060320150838.PS244437000007@infradead.org>
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

From: Adrian Bunk <bunk@stusta.de>
Date: 1138016882 -0200
V4L/DVB: VIDEO_CX88_ALSA must select SND_PCM

- VIDEO_CX88_ALSA must select SND_PCM

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/cx88/Kconfig b/drivers/media/video/cx88/Kconfig
diff --git a/drivers/media/video/cx88/Kconfig b/drivers/media/video/cx88/Kconfig
index 5330891..fdf45f7 100644
--- a/drivers/media/video/cx88/Kconfig
+++ b/drivers/media/video/cx88/Kconfig
@@ -32,6 +32,7 @@ config VIDEO_CX88_DVB
 config VIDEO_CX88_ALSA
 	tristate "ALSA DMA audio support"
 	depends on VIDEO_CX88 && SND && EXPERIMENTAL
+	select SND_PCM
 	---help---
 	  This is a video4linux driver for direct (DMA) audio on
 	  Conexant 2388x based TV cards.

