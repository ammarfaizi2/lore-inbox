Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263663AbTCUS3P>; Fri, 21 Mar 2003 13:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263690AbTCUS20>; Fri, 21 Mar 2003 13:28:26 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:54403
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263728AbTCUSZF>; Fri, 21 Mar 2003 13:25:05 -0500
Date: Fri, 21 Mar 2003 19:40:20 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211940.h2LJeKWi025881@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: remove unused ali-ircc variable
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/net/irda/ali-ircc.c linux-2.5.65-ac2/drivers/net/irda/ali-ircc.c
--- linux-2.5.65/drivers/net/irda/ali-ircc.c	2003-02-10 18:38:27.000000000 +0000
+++ linux-2.5.65-ac2/drivers/net/irda/ali-ircc.c	2003-02-17 00:17:15.000000000 +0000
@@ -248,7 +248,6 @@
 	struct ali_ircc_cb *self;
 	struct pm_dev *pmdev;
 	int dongle_id;
-	int ret;
 	int err;
 			
 	IRDA_DEBUG(2, "%s(), ---------------- Start ----------------\n", __FUNCTION__);	
