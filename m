Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262731AbTCUU7d>; Fri, 21 Mar 2003 15:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262728AbTCUU6U>; Fri, 21 Mar 2003 15:58:20 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:26756
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263802AbTCUSuP>; Fri, 21 Mar 2003 13:50:15 -0500
Date: Fri, 21 Mar 2003 20:05:28 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212005.h2LK5SCf026236@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix typo in net/core/neighbour
Cc: davem@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/net/core/neighbour.c linux-2.5.65-ac2/net/core/neighbour.c
--- linux-2.5.65/net/core/neighbour.c	2003-02-10 18:37:57.000000000 +0000
+++ linux-2.5.65-ac2/net/core/neighbour.c	2003-03-20 18:46:44.000000000 +0000
@@ -550,7 +550,7 @@
 	write_lock(&tbl->lock);
 
 	/*
-	 *	periodicly recompute ReachableTime from random function
+	 *	periodically recompute ReachableTime from random function
 	 */
 
 	if (now - tbl->last_rand > 300 * HZ) {
