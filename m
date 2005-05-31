Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVEaRyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVEaRyz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 13:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVEaRyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 13:54:37 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:40971
	"EHLO g5.random") by vger.kernel.org with ESMTP id S262009AbVEaRwC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 13:52:02 -0400
Date: Tue, 31 May 2005 19:51:52 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, hch@infradead.org, dwalker@mvista.com,
       Ingo Molnar <mingo@elte.hu>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, Andi Kleen <ak@muc.de>,
       "Bill Huey (hui)" <bhuey@lnxw.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       James Bruce <bruce@andrew.cmu.edu>
Subject: Re: RT patch acceptance
Message-ID: <20050531175152.GT5413@g5.random>
References: <Pine.OSF.4.05.10505311347290.1707-100000@da410.phys.au.dk> <1117556283.2569.26.camel@localhost.localdomain> <20050531171143.GS5413@g5.random> <1117561379.2569.57.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117561379.2569.57.camel@localhost.localdomain>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 01:42:59PM -0400, Steven Rostedt wrote:
> How does one demonstrate that something works without a test. You may
> call it a "demo", but in reality it is just another test.  It's been
> quite some time since I use to work on that, and I never read the
> MilSpec myself, I was just told what to do by those that did read it.
> But I would still call it testing.  Every requirement must have a way to
> prove that it was fulfilled, whether it was by "demo", inspection, or
> measurement, I would call all those tests. 

With testing I meant to run the OS on the bare hardware in the
final configuration and verifying that it works (possibly by measuring
the worst case latencies you get during the testing, like what Ingo does
to claim worst case latency for preempt-RT).

> One of the tests that were done was to inspect ever module (or function)
> for every code path it took.  This grows exponential with every branch.

Yes, that's what I meant.

> the integration level, and system level.  Could you imagine what it
> would take to do this with Linux!  Linux is much bigger than that code
> that ran the engine of an aircraft, and that testing took ten years!

Indeed, that's why I believe hard-RT with preempt-RT is just a joke.

> Not to mention that Linux is a moving target, and the engine control
> code was designed for a single purpose and a single type of hardware.

Exactly.

> Before I put my hand under that saw, I would want to test it several
> times with a hotdog first!

;)
