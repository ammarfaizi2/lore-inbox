Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWCAO6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWCAO6v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 09:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWCAO6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 09:58:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21668 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932341AbWCAO6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 09:58:50 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Manu Abraham <manu@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 03/13] Make a struct static
Date: Wed, 01 Mar 2006 09:05:37 -0300
Message-id: <20060301120537.PS47493300003@infradead.org>
In-Reply-To: <20060301120529.PS80375900000@infradead.org>
References: <20060301120529.PS80375900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Manu Abraham <manu@linuxtv.org>
Date: 1141009672 \-0300

Signed-off-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/bt8xx/bt878.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/dvb/bt8xx/bt878.c b/drivers/media/dvb/bt8xx/bt878.c
index 34c3189..356f447 100644
--- a/drivers/media/dvb/bt8xx/bt878.c
+++ b/drivers/media/dvb/bt8xx/bt878.c
@@ -382,7 +382,7 @@ bt878_device_control(struct bt878 *bt, u
 EXPORT_SYMBOL(bt878_device_control);
 
 
-struct cards card_list[] __devinitdata = {
+static struct cards card_list[] __devinitdata = {
 
 	{ 0x01010071, BTTV_BOARD_NEBULA_DIGITV,			"Nebula Electronics DigiTV" },
 	{ 0x07611461, BTTV_BOARD_AVDVBT_761,			"AverMedia AverTV DVB-T 761" },

