Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263453AbTLTPFb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 10:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263609AbTLTPFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 10:05:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:55707 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263453AbTLTPFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 10:05:24 -0500
Date: Sat, 20 Dec 2003 07:05:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: mingo@elte.hu, hawkes@babylon.engr.sgi.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: [RFC][PATCH] 2.6.0-test11 sched_clock() broken for "drifty ITC"
Message-Id: <20031220070532.05b7b268.akpm@osdl.org>
In-Reply-To: <3FE46345.1040102@cyberone.com.au>
References: <200312182044.hBIKiCLY5477429@babylon.engr.sgi.com>
	<20031220105031.GA17848@elte.hu>
	<3FE46345.1040102@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> 
> 
> Ingo Molnar wrote:
> 
> >
> >So i believe the generic relaxing of sched_clock() synchronization is
> >the right thing to do. I like your patch. It adds minimal overhead and
> >solves a hard problem - nice work! Andrew, please apply it.
> >
> >
> 
> Its a great looking patch if you must have high res sched_clock. So
> I guess I agree with it.

miaow ;)

> Can we have a scheduler day when Andrew is ready to take patches for
> it? I have a few small changes that I'd like to get merged soon too
> (not sched domains - that should probably go to the mm tree for a while)
> 
> Relevant patches are
> sched-ctx-count-preempt.patch
> sched-fork-cleanup.patch
> sched-migrate-comment.patch
> sched-style.patch
> sched-migrate-affinity-race.patch
> 

Post 'em.
