Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbVLNDSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbVLNDSW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 22:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbVLNDSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 22:18:21 -0500
Received: from smtp1.brturbo.com.br ([200.199.201.163]:42144 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1030368AbVLNDSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 22:18:20 -0500
Message-Id: <20051214031500.860113000@localhost>
References: <20051214031344.031534000@localhost>
Date: Wed, 14 Dec 2005 01:13:50 -0200
From: mchehab@brturbo.com
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com,
       linux-dvb-maintainer@linuxtv.org, js@linuxtv.org,
       Michael Krufky <mkrufky@gmail.com>
Subject: [patch-mm 6/6] V4L/DVB (3166): "Philips 1236D ATSC/NTSC dual in" -
	fix typo.
Content-Disposition: inline; filename=v4l_dvb_3166__philips_1236d_atsc_ntsc_dual_in_fix_typo.patch
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Krufky <mkrufky@m1k.net>

- "Philips 1236D ATSC/NTSC dual in" - fix typo.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 Documentation/video4linux/CARDLIST.tuner |    2 +-
 drivers/media/video/tuner-simple.c       |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- git.orig/Documentation/video4linux/CARDLIST.tuner
+++ git/Documentation/video4linux/CARDLIST.tuner
@@ -40,7 +40,7 @@ tuner=38 - Philips PAL/SECAM multi (FM12
 tuner=39 - LG NTSC (newer TAPC series)
 tuner=40 - HITACHI V7-J180AT
 tuner=41 - Philips PAL_MK (FI1216 MK)
-tuner=42 - Philips 1236D ATSC/NTSC daul in
+tuner=42 - Philips 1236D ATSC/NTSC dual in
 tuner=43 - Philips NTSC MK3 (FM1236MK3 or FM1236/F)
 tuner=44 - Philips 4 in 1 (ATI TV Wonder Pro/Conexant)
 tuner=45 - Microtune 4049 FM5
--- git.orig/drivers/media/video/tuner-simple.c
+++ git/drivers/media/video/tuner-simple.c
@@ -481,7 +481,7 @@ static struct tunertype tuners[] = {
 		.config = 0x8e,
 	},
 	[TUNER_PHILIPS_ATSC] = { /* Philips ATSC */
-		.name   = "Philips 1236D ATSC/NTSC daul in",
+		.name   = "Philips 1236D ATSC/NTSC dual in",
 		.thresh1= 16 * 157.25 /*MHz*/,
 		.thresh2= 16 * 454.00 /*MHz*/,
 		.VHF_L  = 0xa0,

--

