Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbWAWU25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbWAWU25 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWAWU24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:28:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:47301 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964944AbWAWU2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:28:34 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Ian Pickworth <ian@pickworth.me.uk>,
       Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 09/16] Recognise Hauppauge card #34519
Date: Mon, 23 Jan 2006 18:24:44 -0200
Message-id: <20060123202444.PS67002100009@infradead.org>
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

From: Ian Pickworth <ian@pickworth.me.uk>

- Recognise Hauppauge card #34519

Signed-off-by: Ian Pickworth <ian@pickworth.me.uk>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx88/cx88-cards.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

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

