Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264647AbTGKRxg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 13:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264722AbTGKRw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 13:52:28 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:1412
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264700AbTGKRvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:51:41 -0400
Date: Fri, 11 Jul 2003 19:05:29 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111805.h6BI5T8c017230@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: isurf compile fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/drivers/isdn/hisax/isurf.c linux-2.5.75-ac1/drivers/isdn/hisax/isurf.c
--- linux-2.5.75/drivers/isdn/hisax/isurf.c	2003-07-10 21:10:25.000000000 +0100
+++ linux-2.5.75-ac1/drivers/isdn/hisax/isurf.c	2003-07-11 13:05:43.000000000 +0100
@@ -237,7 +237,7 @@
 		struct pnp_card *pb;
 		struct pnp_dev *pd;
 	
-		cs->subtyp = 0;
+		card->cs->subtyp = 0;
 		if ((pb = pnp_find_card(
 			     ISAPNP_VENDOR('S', 'I', 'E'),
 			     ISAPNP_FUNCTION(0x0010), pnp_surf))) {
