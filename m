Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbTDGX1y (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263876AbTDGX1W (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:27:22 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:14465
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263736AbTDGXTS (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:19:18 -0400
Date: Tue, 8 Apr 2003 01:38:09 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080038.h380c9BK009276@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: irda typo fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/net/irda/irlap_event.c linux-2.5.67-ac1/net/irda/irlap_event.c
--- linux-2.5.67/net/irda/irlap_event.c	2003-04-08 00:37:40.000000000 +0100
+++ linux-2.5.67-ac1/net/irda/irlap_event.c	2003-04-03 16:57:13.000000000 +0100
@@ -1038,7 +1038,7 @@
 				 * we send 2000B packets, we may wait another
 				 * 1000B until our turnaround expire. That's
 				 * why we need to be proactive in avoiding
-				 * comming here. - Jean II
+				 * coming here. - Jean II
 				 */
 				return -EPROTO;
 			}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/net/irda/irlmp.c linux-2.5.67-ac1/net/irda/irlmp.c
--- linux-2.5.67/net/irda/irlmp.c	2003-04-08 00:37:40.000000000 +0100
+++ linux-2.5.67-ac1/net/irda/irlmp.c	2003-04-03 16:57:13.000000000 +0100
@@ -925,7 +925,7 @@
 	 * Now, check all discovered devices (if any), and notify client
 	 * only about the services that the client is interested in
 	 * We also notify only about the new devices unless the caller
-	 * explicity request a dump of the log. Jean II
+	 * explicitly request a dump of the log. Jean II
 	 */
 	discoveries = irlmp_copy_discoveries(log, &number,
 					     client->hint_mask.word,
