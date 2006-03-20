Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbWCTPN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbWCTPN3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966243AbWCTPN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:13:29 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:65250 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964941AbWCTPNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:13:24 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Adrian Bunk <bunk@stusta.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 087/141] V4L/DVB (3341): Upstream sync - make 2 structs
	static
Date: Mon, 20 Mar 2006 12:08:51 -0300
Message-id: <20060320150851.PS540018000087@infradead.org>
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

From: Adrian Bunk <bunk@stusta.de>
Date: 1141009675 -0300

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/dvb/bt8xx/dst.c b/drivers/media/dvb/bt8xx/dst.c
diff --git a/drivers/media/dvb/bt8xx/dst.c b/drivers/media/dvb/bt8xx/dst.c
index d800df1..1cfa5e5 100644
--- a/drivers/media/dvb/bt8xx/dst.c
+++ b/drivers/media/dvb/bt8xx/dst.c
@@ -602,7 +602,7 @@ static int dst_type_print(u8 type)
 
 */
 
-struct dst_types dst_tlist[] = {
+static struct dst_types dst_tlist[] = {
 	{
 		.device_id = "200103A",
 		.offset = 0,

