Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318278AbSGXIQE>; Wed, 24 Jul 2002 04:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318279AbSGXIQE>; Wed, 24 Jul 2002 04:16:04 -0400
Received: from mx2.elte.hu ([157.181.151.9]:20188 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318278AbSGXIQD>;
	Wed, 24 Jul 2002 04:16:03 -0400
Date: Wed, 24 Jul 2002 10:17:38 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>,
       george anzinger <george@mvista.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] irqlock patch -G3. [was Re: odd memory corruptionin2.5.27?]
In-Reply-To: <20020724081511.GC25038@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0207241015050.7968-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Jul 2002, William Lee Irwin III wrote:

> > i've fixed this in my tree: the init thread needs to start up with a
> > nonzero preempt_count, and schedule_init() sets it to 0. [schedule_init()  
> > is the point after we can schedule.]
> 
> Sorry about the duplicated report, I must have missed the fix in the
> changelogs. [...]

sorry - i was too compact. What i wanted to say: "i agree that this is a
bug, and based on your report i've fixed this bug in my tree, it will show
up in the next patch". Thanks!

	Ingo

