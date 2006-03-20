Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWCTQLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWCTQLI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966271AbWCTPOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:14:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18072 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966240AbWCTPOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:14:06 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 044/141] V4L/DVB (3270): Tuner_dbg will show tuner param
	and range selected
Date: Mon, 20 Mar 2006 12:08:44 -0300
Message-id: <20060320150844.PS333396000044@infradead.org>
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

From: Michael Krufky <mkrufky@linuxtv.org>
Date: 1139300735 -0200

- tuner_dbg will show tuner param and range selected

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/tuner-simple.c b/drivers/media/video/tuner-simple.c
diff --git a/drivers/media/video/tuner-simple.c b/drivers/media/video/tuner-simple.c
index 58fa0d2..17e29cc 100644
--- a/drivers/media/video/tuner-simple.c
+++ b/drivers/media/video/tuner-simple.c
@@ -188,7 +188,7 @@ static void default_set_tv_freq(struct i
 	/*  i == 0 -> VHF_LO
 	 *  i == 1 -> VHF_HI
 	 *  i == 2 -> UHF     */
-	tuner_dbg("tv: range %d\n",i);
+	tuner_dbg("tv: param %d, range %d\n",j,i);
 
 	div=freq + IFPCoff + offset;
 

