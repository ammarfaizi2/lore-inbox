Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264642AbSIWAkn>; Sun, 22 Sep 2002 20:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264643AbSIWAkm>; Sun, 22 Sep 2002 20:40:42 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:56452 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP
	id <S264642AbSIWAkm>; Sun, 22 Sep 2002 20:40:42 -0400
Message-Id: <200209230057.g8N0vcFJ001540@pool-141-150-241-241.delv.east.verizon.net>
Date: Sun, 22 Sep 2002 20:57:35 -0400
From: Skip Ford <skip.ford@verizon.net>
To: "Michel Eyckmans (MCE)" <mce@pi.be>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.38
References: <Pine.LNX.4.33.0209212130360.2433-100000@penguin.transmeta.com> <200209230019.g8N0JmvC003642@jebril.pi.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209230019.g8N0JmvC003642@jebril.pi.be>; from mce@pi.be on Mon, Sep 23, 2002 at 02:19:48AM +0200
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out001.verizon.net from [141.150.241.241] at Sun, 22 Sep 2002 19:45:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michel Eyckmans (MCE) wrote:
> By the way, 2.3.38 gives me this:
> 
> depmod: *** Unresolved symbols in /lib/modules/2.5.38/kernel/net/ipv4/netfilter/ipt_owner.o
> depmod:         find_task_by_pid


--- linux/kernel/ksyms.c~	Sun Sep 22 20:56:07 2002
+++ linux/kernel/ksyms.c	Sun Sep 22 20:56:22 2002
@@ -606,6 +606,7 @@
 EXPORT_SYMBOL(init_thread_union);
 
 EXPORT_SYMBOL(tasklist_lock);
+EXPORT_SYMBOL(find_task_by_pid);
 #if defined(CONFIG_SMP) && defined(__GENERIC_PER_CPU)
 EXPORT_SYMBOL(__per_cpu_offset);
 #endif


-- 
Skip
