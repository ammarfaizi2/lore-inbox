Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271697AbTGRFO4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 01:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271699AbTGRFO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 01:14:56 -0400
Received: from fed1mtao07.cox.net ([68.6.19.124]:49322 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S271697AbTGRFO4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 01:14:56 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] /proc/slabinfo formatting cosmetic fix (2.6.0-test1)
From: junkio@cox.net
Date: Thu, 17 Jul 2003 22:29:50 -0700
Message-ID: <7v1xwo5rn5.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The slabinfo header line seems to have unbalanced <> pairs.

--- linux-2.6.0-test1/mm/slab.c	2003-07-10 13:12:58.000000000 -0700
+++ linux-2.6.0-test1/mm/slab.c	2003-07-17 22:26:26.000000000 -0700
@@ -2482,11 +2482,11 @@
 		seq_puts(m, "slabinfo - version: 2.0\n");
 #endif
 		seq_puts(m, "# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>");
-		seq_puts(m, " : tunables <batchcount> <limit <sharedfactor>");
+		seq_puts(m, " : tunables <batchcount> <limit> <sharedfactor>");
 		seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
 #if STATS
 		seq_puts(m, " : globalstat <listallocs> <maxobjs> <grown> <reaped> <error> <maxfreeable> <freelimit>");
-		seq_puts(m, " : cpustat <allochit <allocmiss <freehit <freemiss>");
+		seq_puts(m, " : cpustat <allochit> <allocmiss> <freehit> <freemiss>");
 #endif
 		seq_putc(m, '\n');
 	}

