Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965430AbWCTPq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965430AbWCTPq0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965423AbWCTPqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:46:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44258 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966827AbWCTPVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:21:18 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Manu Abraham <manu@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 086/141] V4L/DVB (3340): Make a struct static
Date: Mon, 20 Mar 2006 12:08:51 -0300
Message-id: <20060320150851.PS375921000086@infradead.org>
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

From: Manu Abraham <manu@linuxtv.org>
Date: 1141009672 -0300

Signed-off-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/dvb/bt8xx/bt878.c b/drivers/media/dvb/bt8xx/bt878.c
diff --git a/drivers/media/dvb/bt8xx/bt878.c b/drivers/media/dvb/bt8xx/bt878.c
index d276ce6..5500f8a 100644
--- a/drivers/media/dvb/bt8xx/bt878.c
+++ b/drivers/media/dvb/bt8xx/bt878.c
@@ -382,7 +382,7 @@ bt878_device_control(struct bt878 *bt, u
 EXPORT_SYMBOL(bt878_device_control);
 
 
-struct cards card_list[] __devinitdata = {
+static struct cards card_list[] __devinitdata = {
 
 	{ 0x01010071, BTTV_BOARD_NEBULA_DIGITV,			"Nebula Electronics DigiTV" },
 	{ 0x07611461, BTTV_BOARD_AVDVBT_761,			"AverMedia AverTV DVB-T 761" },

