Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965200AbWCTQC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965200AbWCTQC4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965692AbWCTQCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:02:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42136 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966467AbWCTPQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:16:31 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Ian Pickworth <ian@pickworth.me.uk>,
       Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 017/141] V4L/DVB (3416): Recognise Hauppauge card #34519
Date: Mon, 20 Mar 2006 12:08:39 -0300
Message-id: <20060320150839.PS881289000017@infradead.org>
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

From: Ian Pickworth <ian@pickworth.me.uk>
Date: 1138043467 -0200

- Recognise Hauppauge card #34519

Signed-off-by: Ian Pickworth <ian@pickworth.me.uk>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
diff --git a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
index 517257b..1bc9992 100644
--- a/drivers/media/video/cx88/cx88-cards.c
+++ b/drivers/media/video/cx88/cx88-cards.c
@@ -1298,6 +1298,7 @@ static void hauppauge_eeprom(struct cx88
 	switch (tv.model)
 	{
 	case 28552: /* WinTV-PVR 'Roslyn' (No IR) */
+	case 34519: /* WinTV-PCI-FM */
 	case 90002: /* Nova-T-PCI (9002) */
 	case 92001: /* Nova-S-Plus (Video and IR) */
 	case 92002: /* Nova-S-Plus (Video and IR) */

