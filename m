Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272572AbTG1AmI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272571AbTG1AER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:04:17 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28659 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272727AbTG0W6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:58:19 -0400
Date: Sun, 27 Jul 2003 21:24:24 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272024.h6RKOO88029804@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: the rest of the slab.c fix...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Junkio)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/mm/slab.c linux-2.6.0-test2-ac1/mm/slab.c
--- linux-2.6.0-test2/mm/slab.c	2003-07-27 19:56:29.000000000 +0100
+++ linux-2.6.0-test2-ac1/mm/slab.c	2003-07-27 20:45:45.000000000 +0100
@@ -2492,7 +2492,7 @@
 		seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
 #if STATS
 		seq_puts(m, " : globalstat <listallocs> <maxobjs> <grown> <reaped> <error> <maxfreeable> <freelimit>");
-		seq_puts(m, " : cpustat <allochit> <allocmiss> <freehit <freemiss>");
+		seq_puts(m, " : cpustat <allochit> <allocmiss> <freehit> <freemiss>");
 #endif
 		seq_putc(m, '\n');
 	}
