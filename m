Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318255AbSGXHfN>; Wed, 24 Jul 2002 03:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318253AbSGXHfN>; Wed, 24 Jul 2002 03:35:13 -0400
Received: from mx2.elte.hu ([157.181.151.9]:20183 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318255AbSGXHfM>;
	Wed, 24 Jul 2002 03:35:12 -0400
Date: Wed, 24 Jul 2002 09:37:20 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@zip.com.au>
Cc: Robert Love <rml@tech9.net>, george anzinger <george@mvista.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] irqlock patch -G3. [was Re: odd memory corruption
 in2.5.27?]
In-Reply-To: <3D3E1B66.F17D8B9E@zip.com.au>
Message-ID: <Pine.LNX.4.44.0207240934450.2193-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 23 Jul 2002, Andrew Morton wrote:

> [...] It'll be untrivial to fix all this, but this very subtle change to
> the locking semantics with CONFIG_PREEMPT is quite nasty.

well, preempt is different, lets face it. I'm very strongly against making
the irq-on path check for preemption ...

	Ingo

