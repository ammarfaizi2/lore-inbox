Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266926AbUAXMS4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 07:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266931AbUAXMS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 07:18:56 -0500
Received: from dp.samba.org ([66.70.73.150]:21923 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266926AbUAXMSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 07:18:54 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, linux-kernel@vger.kernel.org,
       John Hawkes <hawkes@sgi.com>
Subject: Re: [PATCH] Directed migration: Don't Change cpumask in sched_balance_exec() 
In-reply-to: Your message of "Fri, 23 Jan 2004 14:30:18 +1100."
             <4010954A.7090904@cyberone.com.au> 
Date: Sat, 24 Jan 2004 16:58:47 +1100
Message-Id: <20040124121909.73AFE2C05E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <4010954A.7090904@cyberone.com.au> you write:
> CPUs have (I think) always been int in sched.c, you're using unsigned
> int. No big deal, but I'll change them to int.

I hate int for unsigned things.  Oh well.

> My patches introduce a "move_tasks" function, so I'll rename yours
> to migrate_task and __migrate_task.

Sure!

> Your version of move_task (now migrate_task) never actually used dest_cpu
> unless I am seeing things. Fixed.

Err... Yeah, I knew that.  <cough>

I was, um, just checking you were reading. 8)

> Hows that?

Looks great!

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
