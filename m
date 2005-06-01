Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVFALn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVFALn3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 07:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVFALn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 07:43:29 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:37255 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261331AbVFALnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 07:43:13 -0400
Subject: Re: RT patch acceptance
From: Steven Rostedt <rostedt@goodmis.org>
To: John Alvord <jalvo@mbay.net>
Cc: Andrea Arcangeli <andrea@suse.de>, Esben Nielsen <simlo@phys.au.dk>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, hch@infradead.org,
       dwalker@mvista.com, Ingo Molnar <mingo@elte.hu>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, Andi Kleen <ak@muc.de>,
       "Bill Huey (hui)" <bhuey@lnxw.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       James Bruce <bruce@andrew.cmu.edu>
In-Reply-To: <5rkq915auako3ju5dg7cih0dfiepkaass8@4ax.com>
References: <Pine.OSF.4.05.10505311347290.1707-100000@da410.phys.au.dk>
	 <1117556283.2569.26.camel@localhost.localdomain>
	 <20050531171143.GS5413@g5.random>
	 <1117561379.2569.57.camel@localhost.localdomain>
	 <20050531175152.GT5413@g5.random>
	 <1117564192.2569.83.camel@localhost.localdomain>
	 <5rkq915auako3ju5dg7cih0dfiepkaass8@4ax.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 01 Jun 2005 07:41:51 -0400
Message-Id: <1117626111.4364.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-31 at 23:23 -0700, John Alvord wrote:
> It seems obvious to me that people are waving around soft qualitative
> words when the reality is that only a quantitative specification is
> possible. And nothing is 100%, it is always a distribution of
> potential results. Any modern processor will have fluctuations in the
> sub-microsecond range. A work of ram might have a single-bit error
> [Thank you Mr X-ray from some collapsing star] and take a bit more
> time then usual to do the ECC logic.  A program proving system *might*
> have an error. Every proper analysis should include an error estimate.
> 

Yeah, yeah, I know about the variations of the hardware. That all needs
to be taken into account too when determining worst-case. But I was
focusing on the behavior of Software.  When talking about 100% (or close
to) and hard guarantees, I was talking about knowing the worst case
scenario, so you know that it will work in some time frame, not a point
in time.  Funny, the hardware we used then was also ten years old, and
was much slower than the hardware of the time. Basically, all the
hardware was designed to have little variation, so it also sacrificed
efficiency.  It really felt like working on a 486 today.

> So an operating environment must have some
> estimated/measured/calculated results from which an estimate can be
> made on whether certain workload can be processed in the time alotted.
> An audio application will have one requirement, flying an airplane is
> another...  All this hand-waving about hard versus soft RT just
> exposes the prejudices and experience of each writer.

I wanted to make a point about the differences that people make when
using the term hard-RT. Unfortunately, I was writing more than thinking,
and really just went on tangent and down a complete wrong path. I guess
that happens when you are doing real work and trying to keep up on this
thread.  My last post on this topic I believe (hopefully) clears up what
I was thinking.

> No offence...

None taken* ;-)    I deserved a noodle whipping!

-- Steve

* and I didn't take any offense either :-)


