Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbWCTPiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbWCTPiQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965297AbWCTPZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:25:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:31160 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965296AbWCTPZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:25:39 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 014/141] V4L/DVB (3411): group dvb-bt8xx Subsystem ID's
	together, in order.
Date: Mon, 20 Mar 2006 12:08:39 -0300
Message-id: <20060320150839.PS387641000014@infradead.org>
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
Date: 1138043466 -0200

- group dvb-bt8xx Subsystem ID's together, in order.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/bttv-cards.c b/drivers/media/video/bttv-cards.c
diff --git a/drivers/media/video/bttv-cards.c b/drivers/media/video/bttv-cards.c
index 9749d6e..21ffe1c 100644
--- a/drivers/media/video/bttv-cards.c
+++ b/drivers/media/video/bttv-cards.c
@@ -275,7 +275,6 @@ static struct CARD {
 	{ 0x03116000, BTTV_BOARD_SENSORAY311,   "Sensoray 311" },
 	{ 0x00790e11, BTTV_BOARD_WINDVR,        "Canopus WinDVR PCI" },
 	{ 0xa0fca1a0, BTTV_BOARD_ZOLTRIX,       "Face to Face Tvmax" },
-	{ 0x20007063, BTTV_BOARD_PC_HDTV,       "pcHDTV HD-2000 TV"},
 	{ 0x82b2aa6a, BTTV_BOARD_SIMUS_GVC1100, "SIMUS GVC1100" },
 	{ 0x146caa0c, BTTV_BOARD_PV951,         "ituner spectra8" },
 	{ 0x200a1295, BTTV_BOARD_PXC200,        "ImageNation PXC200A" },
@@ -297,13 +296,14 @@ static struct CARD {
 	* { 0x13eb0070, BTTV_BOARD_HAUPPAUGE_IMPACTVCB,  "Hauppauge ImpactVCB" }, */
 
 	/* DVB cards (using pci function .1 for mpeg data xfer) */
-	{ 0x01010071, BTTV_BOARD_NEBULA_DIGITV, "Nebula Electronics DigiTV" },
-	{ 0x07611461, BTTV_BOARD_AVDVBT_761,    "AverMedia AverTV DVB-T 761" },
 	{ 0x001c11bd, BTTV_BOARD_PINNACLESAT,   "Pinnacle PCTV Sat" },
+	{ 0x01010071, BTTV_BOARD_NEBULA_DIGITV, "Nebula Electronics DigiTV" },
+	{ 0x20007063, BTTV_BOARD_PC_HDTV,       "pcHDTV HD-2000 TV"},
 	{ 0x002611bd, BTTV_BOARD_TWINHAN_DST,   "Pinnacle PCTV SAT CI" },
 	{ 0x00011822, BTTV_BOARD_TWINHAN_DST,   "Twinhan VisionPlus DVB" },
 	{ 0xfc00270f, BTTV_BOARD_TWINHAN_DST,   "ChainTech digitop DST-1000 DVB-S" },
 	{ 0x07711461, BTTV_BOARD_AVDVBT_771,    "AVermedia AverTV DVB-T 771" },
+	{ 0x07611461, BTTV_BOARD_AVDVBT_761,    "AverMedia AverTV DVB-T 761" },
 	{ 0xdb1018ac, BTTV_BOARD_DVICO_DVBT_LITE,    "DViCO FusionHDTV DVB-T Lite" },
 	{ 0xd50018ac, BTTV_BOARD_DVICO_FUSIONHDTV_5_LITE,    "DViCO FusionHDTV 5 Lite" },
 

