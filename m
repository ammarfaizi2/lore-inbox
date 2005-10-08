Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161033AbVJHBEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbVJHBEm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 21:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161034AbVJHBEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 21:04:42 -0400
Received: from smtp3.brturbo.com.br ([200.199.201.164]:47832 "EHLO
	smtp3.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1161033AbVJHBEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 21:04:41 -0400
Date: Fri, 07 Oct 2005 22:04:28 -0300
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH 2/2] V4L: Enable s-video input on DViCO FusionHDTV5 Lite
Message-ID: <43471b1c.4Ogrwj8f6ZKHb7Uq%mchehab@brturbo.com.br>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Krufky <mkrufky@linuxtv.org>

    * bttv-cards.c:
    - Enable S-Video input on DViCO FusionHDTV5 Lite

    Signed-off-by: Michael Krufky <mkrufky@m1k.net>
    Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 bttv-cards.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

------------------

diff -upr linux-2.6.14-rc3-git7/drivers/media/video/bttv-cards.c linux/drivers/media/video/bttv-cards.c
--- linux-2.6.14-rc3-git7/drivers/media/video/bttv-cards.c	2005-10-07 14:54:38.915668669 -0500
+++ linux/drivers/media/video/bttv-cards.c	2005-10-07 15:46:58.019236100 -0500
@@ -2393,10 +2393,10 @@ struct tvcard bttv_tvcards[] = {
 	.tuner          = 0,
 	.tuner_type     = TUNER_LG_TDVS_H062F,
 	.tuner_addr	= ADDR_UNSET,
-	.video_inputs   = 2,
+	.video_inputs   = 3,
 	.audio_inputs   = 1,
 	.svhs           = 2,
-	.muxsel		= { 2, 3 },
+	.muxsel		= { 2, 3, 1 },
 	.gpiomask       = 0x00e00007,
 	.audiomux       = { 0x00400005, 0, 0x00000001, 0, 0x00c00007, 0 },
 	.no_msp34xx     = 1,
