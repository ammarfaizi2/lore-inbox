Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965413AbWCTPop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965413AbWCTPop (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965279AbWCTPXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:23:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56034 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965274AbWCTPWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:22:47 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 001/141] V4L/DVB (3392): Add PCI ID for DigitalNow DVB-T
	Dual, rebranded DViCO FusionHDTV DVB-T Dual.
Date: Mon, 20 Mar 2006 12:08:37 -0300
Message-id: <20060320150837.PS252797000001@infradead.org>
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

From: Michael Krufky <mkrufky@m1k.net>
Date: 1137477023 -0200

- Add PCI ID for DigitalNow DVB-T Dual,
rebranded DViCO FusionHDTV DVB-T Dual.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/Documentation/video4linux/CARDLIST.cx88 b/Documentation/video4linux/CARDLIST.cx88
diff --git a/Documentation/video4linux/CARDLIST.cx88 b/Documentation/video4linux/CARDLIST.cx88
index 56e194f..8bea3fb 100644
--- a/Documentation/video4linux/CARDLIST.cx88
+++ b/Documentation/video4linux/CARDLIST.cx88
@@ -42,4 +42,4 @@
  41 -> Hauppauge WinTV-HVR1100 DVB-T/Hybrid (Low Profile)  [0070:9800,0070:9802]
  42 -> digitalnow DNTV Live! DVB-T Pro                     [1822:0025]
  43 -> KWorld/VStream XPert DVB-T with cx22702             [17de:08a1]
- 44 -> DViCO FusionHDTV DVB-T Dual Digital                 [18ac:db50]
+ 44 -> DViCO FusionHDTV DVB-T Dual Digital                 [18ac:db50,18ac:db54]
diff --git a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
diff --git a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
index ad2f565..517257b 100644
--- a/drivers/media/video/cx88/cx88-cards.c
+++ b/drivers/media/video/cx88/cx88-cards.c
@@ -1246,6 +1246,11 @@ struct cx88_subid cx88_subids[] = {
 		.card      = CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_DUAL,
 	},{
 		.subvendor = 0x18ac,
+		.subdevice = 0xdb54,
+		.card      = CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_DUAL,
+		/* Re-branded DViCO: DigitalNow DVB-T Dual */
+	},{
+		.subvendor = 0x18ac,
 		.subdevice = 0xdb11,
 		.card      = CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_PLUS,
 		/* Re-branded DViCO: UltraView DVB-T Plus */

