Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269232AbTGORxO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269190AbTGORvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:51:12 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:23239 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S269120AbTGORt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:49:58 -0400
Message-ID: <3F144247.7020001@despammed.com>
Date: Tue, 15 Jul 2003 14:04:55 -0400
From: Lev Makhlis <mlev@despammed.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [2.6.0-test1] Typos in /proc/slabinfo
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u linux-2.6.0-test1/mm/slab.c linux/mm/slab.c
--- linux-2.6.0-test1/mm/slab.c    2003-07-13 23:36:48.000000000 -0400
+++ linux/mm/slab.c    2003-07-15 11:52:12.337986224 -0400
@@ -2482,11 +2482,11 @@
        seq_puts(m, "slabinfo - version: 2.0\n");
#endif
        seq_puts(m, "# name            <active_objs> <num_objs> 
<objsize> <objperslab> <pagesperslab>");
-        seq_puts(m, " : tunables <batchcount> <limit <sharedfactor>");
+        seq_puts(m, " : tunables <batchcount> <limit> <sharedfactor>");
        seq_puts(m, " : slabdata <active_slabs> <num_slabs> 
<sharedavail>");
#if STATS
        seq_puts(m, " : globalstat <listallocs> <maxobjs> <grown> 
<reaped> <error> <maxfreeable> <freelimit>");
-        seq_puts(m, " : cpustat <allochit <allocmiss <freehit 
<freemiss>");
+        seq_puts(m, " : cpustat <allochit> <allocmiss> <freehit> 
<freemiss>");
#endif
        seq_putc(m, '\n');
    }


