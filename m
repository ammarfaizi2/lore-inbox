Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754548AbWKMMXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754548AbWKMMXL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 07:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754549AbWKMMXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 07:23:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:12497 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1754548AbWKMMXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 07:23:10 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Alexey Dobriyan <adobriyan@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 1/8] V4L/DVB (4795): Tda826x: use correct max frequency
Date: Mon, 13 Nov 2006 10:18:43 -0200
Message-id: <20061113121843.PS3945940001@infradead.org>
In-Reply-To: <20061113121504.PS7687690000@infradead.org>
References: <20061113121504.PS7687690000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Alexey Dobriyan <adobriyan@gmail.com>

sparse "defined twice" warning

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/frontends/tda826x.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/dvb/frontends/tda826x.c b/drivers/media/dvb/frontends/tda826x.c
index eeab26b..34815b0 100644
--- a/drivers/media/dvb/frontends/tda826x.c
+++ b/drivers/media/dvb/frontends/tda826x.c
@@ -121,7 +121,7 @@ static struct dvb_tuner_ops tda826x_tune
 	.info = {
 		.name = "Philips TDA826X",
 		.frequency_min = 950000,
-		.frequency_min = 2175000
+		.frequency_max = 2175000
 	},
 	.release = tda826x_release,
 	.sleep = tda826x_sleep,

