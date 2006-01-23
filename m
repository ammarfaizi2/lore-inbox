Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbWAWUbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWAWUbI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWAWU1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:27:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:31429 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964939AbWAWU1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:27:41 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 14/16] fixed spelling error, exectuted --> executed.
Date: Mon, 23 Jan 2006 18:24:45 -0200
Message-id: <20060123202445.PS52002200014@infradead.org>
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

From: Michael Krufky <mkrufky@m1k.net>

- fixed spelling error, exectuted --> executed.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/em28xx/em28xx-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

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

