Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261711AbTCGSj4>; Fri, 7 Mar 2003 13:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261712AbTCGSj4>; Fri, 7 Mar 2003 13:39:56 -0500
Received: from mx1.elte.hu ([157.181.1.137]:2779 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261711AbTCGSjz>;
	Fri, 7 Mar 2003 13:39:55 -0500
Date: Fri, 7 Mar 2003 19:50:06 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Cc: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "interactivity changes", sched-2.5.64-B2
In-Reply-To: <5.2.0.9.2.20030307164223.00c7de70@pop.gmx.net>
Message-ID: <Pine.LNX.4.44.0303071949160.16478-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Mar 2003, Mike Galbraith wrote:

> Done.  If either the softirq.c change or changing WAKER_BONUS_RATIO
> value (25:50:75) make any difference at all with what I'm doing, it's
> too close for me to tell.

hm. Could you then please just re-test the -A6 patch with the same base
tree again? I'd like to make sure that it _is_ the -A6 => -B0 delta that
causes this considerable level of improvement for you.

	Ingo

