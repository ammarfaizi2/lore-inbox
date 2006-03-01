Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbWCAPAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWCAPAk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 10:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbWCAPAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 10:00:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32932 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030208AbWCAPAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 10:00:14 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Adrian Bunk <bunk@stusta.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 04/13] Upstream sync - make 2 structs static
Date: Wed, 01 Mar 2006 09:05:37 -0300
Message-id: <20060301120537.PS78644300004@infradead.org>
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


From: Adrian Bunk <bunk@stusta.de>
Date: 1141009675 \-0300

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/bt8xx/dst.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/dvb/bt8xx/dst.c b/drivers/media/dvb/bt8xx/dst.c
index 3a2ff1c..0310e3d 100644
--- a/drivers/media/dvb/bt8xx/dst.c
+++ b/drivers/media/dvb/bt8xx/dst.c
@@ -602,7 +602,7 @@ static int dst_type_print(u8 type)
 
 */
 
-struct dst_types dst_tlist[] = {
+static struct dst_types dst_tlist[] = {
 	{
 		.device_id = "200103A",
 		.offset = 0,

