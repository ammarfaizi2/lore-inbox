Return-Path: <linux-kernel-owner+w=401wt.eu-S1751369AbXAOTMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbXAOTMa (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 14:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbXAOTMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 14:12:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51487 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbXAOTM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 14:12:28 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 8/9] V4L/DVB (5071): Tveeprom: autodetect LG TAPC G701D as
	tuner type 37
Date: Mon, 15 Jan 2007 16:37:07 -0200
Message-id: <20070115183706.PS8982400008@infradead.org>
In-Reply-To: <20070115183647.PS0588920000@infradead.org>
References: <20070115183647.PS0588920000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Michael Krufky <mkrufky@linuxtv.org>

autodetect LG TAPC G701D as tuner type 37.
Thanks to Adonis Papas, for pointing out the missing autodetection
for this tuner.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/tveeprom.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/tveeprom.c b/drivers/media/video/tveeprom.c
index 2624e3f..4e7c1fa 100644
--- a/drivers/media/video/tveeprom.c
+++ b/drivers/media/video/tveeprom.c
@@ -184,7 +184,7 @@ hauppauge_tuner[] =
 	{ TUNER_ABSENT,        "Thompson DTT757"},
 	/* 80-89 */
 	{ TUNER_ABSENT,        "Philips FQ1216LME MK3"},
-	{ TUNER_ABSENT,        "LG TAPC G701D"},
+	{ TUNER_LG_PAL_NEW_TAPC, "LG TAPC G701D"},
 	{ TUNER_LG_NTSC_NEW_TAPC, "LG TAPC H791F"},
 	{ TUNER_LG_PAL_NEW_TAPC, "TCL 2002MB 3"},
 	{ TUNER_LG_PAL_NEW_TAPC, "TCL 2002MI 3"},

