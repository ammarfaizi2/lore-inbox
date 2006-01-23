Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbWAWUae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbWAWUae (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWAWUa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:30:29 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33989 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964931AbWAWU1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:27:49 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 02/16] Add PCI ID for DigitalNow DVB-T Dual, rebranded
	DViCO FusionHDTV DVB-T Dual.
Date: Mon, 23 Jan 2006 18:24:43 -0200
Message-id: <20060123202443.PS48837800002@infradead.org>
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

- Add PCI ID for DigitalNow DVB-T Dual,
rebranded DViCO FusionHDTV DVB-T Dual.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 Documentation/video4linux/CARDLIST.cx88 |    2 +-
 drivers/media/video/cx88/cx88-cards.c   |    5 +++++
 2 files changed, 6 insertions(+), 1 deletions(-)

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

