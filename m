Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbSI1A4k>; Fri, 27 Sep 2002 20:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262664AbSI1A4k>; Fri, 27 Sep 2002 20:56:40 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:48561 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP
	id <S262662AbSI1A4j>; Fri, 27 Sep 2002 20:56:39 -0400
Message-Id: <200209280114.g8S1E9hg007737@pool-141-150-241-241.delv.east.verizon.net>
Date: Fri, 27 Sep 2002 21:14:06 -0400
From: Skip Ford <skip.ford@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Export find_task_by_pid and next_thread
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out002.verizon.net from [141.150.241.241] at Fri, 27 Sep 2002 20:01:55 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ipt_owner needs find_task_by_pid and next_thread.


--- linux/kernel/ksyms.c~	Fri Sep 27 21:09:13 2002
+++ linux/kernel/ksyms.c	Fri Sep 27 21:09:36 2002
@@ -614,6 +614,8 @@
 EXPORT_SYMBOL(init_thread_union);
 
 EXPORT_SYMBOL(tasklist_lock);
+EXPORT_SYMBOL(find_task_by_pid);
+EXPORT_SYMBOL(next_thread);
 #if defined(CONFIG_SMP) && defined(__GENERIC_PER_CPU)
 EXPORT_SYMBOL(__per_cpu_offset);
 #endif


-- 
Skip
