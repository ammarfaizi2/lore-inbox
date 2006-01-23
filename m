Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbWAWU1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbWAWU1J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWAWU1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:27:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:22469 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932472AbWAWU1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:27:04 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Markus Rechberger <mrechberger@gmail.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 16/16] changed comment in tuner-core.c
Date: Mon, 23 Jan 2006 18:24:45 -0200
Message-id: <20060123202445.PS85612500016@infradead.org>
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

From: Markus Rechberger <mrechberger@gmail.com>

- changed comment in tuner-core.c

Signed-off-by: Markus Rechberger <mrechberger@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/tuner-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
index e6bcd4b..873bf3d 100644
--- a/drivers/media/video/tuner-core.c
+++ b/drivers/media/video/tuner-core.c
@@ -449,7 +449,7 @@ static int tuner_attach(struct i2c_adapt
 			printk("%02x ",buffer[i]);
 		printk("\n");
 	}
-	/* TEA5767 autodetection code - only for addr = 0xc0 */
+	/* autodetection code based on the i2c addr */
 	if (!no_autodetect) {
 		switch (addr) {
 		case 0x42:

