Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264312AbSIQQO0>; Tue, 17 Sep 2002 12:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264314AbSIQQO0>; Tue, 17 Sep 2002 12:14:26 -0400
Received: from mx1.elte.hu ([157.181.1.137]:2786 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S264312AbSIQQO0>;
	Tue, 17 Sep 2002 12:14:26 -0400
Date: Tue, 17 Sep 2002 18:26:27 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BUG(): sched.c: Line 944
In-Reply-To: <Pine.LNX.4.44.0209170911230.4253-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209171826160.6719-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Sep 2002, Linus Torvalds wrote:

> On the other hand, we do have other ways to test the preempt count
> inside the scheduler. In particular, we might just move the
> "in_atomic()" check a few lines downwards, at which point we've released
> the kernel lock and explicitly disabled preemption, so at that point the
> test should be even simpler with fewer conditionals..

indeed ...

	Ingo

