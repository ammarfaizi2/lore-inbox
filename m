Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751901AbWICCGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbWICCGM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 22:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbWICCGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 22:06:12 -0400
Received: from ozlabs.org ([203.10.76.45]:38066 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751901AbWICCGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 22:06:11 -0400
Subject: Re: kernel/stop_machine.c: whose code is it?
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0608311510120.511@twin.jikos.cz>
References: <20060831123241.GB3923@elf.ucw.cz>
	 <Pine.LNX.4.58.0608311510120.511@twin.jikos.cz>
Content-Type: text/plain
Date: Sun, 03 Sep 2006 12:06:07 +1000
Message-Id: <1157249168.19149.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 15:17 +0200, Jiri Kosina wrote:
> On Thu, 31 Aug 2006, Pavel Machek wrote:
> 
> > Would kernel/stop_machine.c author please step up?
> 
> IMHO it's Rusty Russell (added to CC).

Yep.  Not sure the obsession with copyright on every trivial piece of
code is healthy, but if it keeps you happy (I had to look back: this
code was extracted from the module.c code in 2005).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc5-git4/kernel/stop_machine.c tmp/kernel/stop_machine.c
--- linux-2.6.18-rc5-git4/kernel/stop_machine.c	2006-09-01 09:49:11.000000000 +1000
+++ tmp/kernel/stop_machine.c	2006-09-03 11:55:08.000000000 +1000
@@ -1,3 +1,6 @@
+/* Copyright 2005 Rusty Russell rusty@rustcorp.com.au IBM Corporation.
+ * GPL v2 and any later version.
+ */
 #include <linux/stop_machine.h>
 #include <linux/kthread.h>
 #include <linux/sched.h>

-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law


-- 
VGER BF report: U 0.5
