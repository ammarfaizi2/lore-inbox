Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261496AbTCGKRC>; Fri, 7 Mar 2003 05:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261498AbTCGKRC>; Fri, 7 Mar 2003 05:17:02 -0500
Received: from mx2.elte.hu ([157.181.151.9]:31902 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261496AbTCGKRB>;
	Fri, 7 Mar 2003 05:17:01 -0500
Date: Fri, 7 Mar 2003 11:27:15 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: Martin Waitz <tali@admingilde.org>,
       Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <1046988457.715.37.camel@phantasy.awol.org>
Message-ID: <Pine.LNX.4.44.0303071126250.8284-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 6 Mar 2003, Robert Love wrote:

> > in addition, timeslices should be shortest for high priority processes
> > (depending on dynamic prio, not static)
> 
> No, they should be longer.  In some cases they should be nearly
> infinitely long (which is sort of what we do with the reinsertion into
> the active array for highly interactive tasks). [...]

yes, and in fact tasks with 'infinite timeslice' do exist: RT tasks with 
SCHED_FIFO/SCHED_RR.

	Ingo

