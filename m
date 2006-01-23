Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbWAWU1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbWAWU1q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWAWU1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:27:36 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:25029 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964931AbWAWU1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:27:18 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Adrian Bunk <bunk@stusta.de>,
       Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 04/16] VIDEO_CX88_ALSA must select SND_PCM
Date: Mon, 23 Jan 2006 18:24:43 -0200
Message-id: <20060123202443.PS82191400004@infradead.org>
In-Reply-To: <20060123202404.PS66974000000@infradead.org>
References: <20060123202404.PS66974000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>

- VIDEO_CX88_ALSA must select SND_PCM

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx88/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

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

