Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWAPJXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWAPJXM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWAPJXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:23:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:28139 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932263AbWAPJWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:22:30 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 04/25] Include missing MODULE_* macros
Date: Mon, 16 Jan 2006 07:11:19 -0200
Message-id: <20060116091119.PS85392200004@infradead.org>
In-Reply-To: <20060116091105.PS83611600000@infradead.org>
References: <20060116091105.PS83611600000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Mauro Carvalho Chehab <mchehab@infradead.org>

- Include missing MODULE_* macros.
- Fixed cx88_vp3054_i2c: module license 'unspecified' taints kernel.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx88/cx88-vp3054-i2c.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/cx88/cx88-vp3054-i2c.c b/drivers/media/video/cx88/cx88-vp3054-i2c.c
index 372cd29..751a754 100644
--- a/drivers/media/video/cx88/cx88-vp3054-i2c.c
+++ b/drivers/media/video/cx88/cx88-vp3054-i2c.c
@@ -32,6 +32,10 @@
 #include "cx88-vp3054-i2c.h"
 
 
+MODULE_DESCRIPTION("driver for cx2388x VP3054 design");
+MODULE_AUTHOR("Chris Pascoe <c.pascoe@itee.uq.edu.au>");
+MODULE_LICENSE("GPL");
+
 /* ----------------------------------------------------------------------- */
 
 static void vp3054_bit_setscl(void *data, int state)

