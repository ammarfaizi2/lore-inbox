Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289117AbSAVA6k>; Mon, 21 Jan 2002 19:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289115AbSAVA6U>; Mon, 21 Jan 2002 19:58:20 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:11660 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S289117AbSAVA6O>; Mon, 21 Jan 2002 19:58:14 -0500
Date: Mon, 21 Jan 2002 18:58:13 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020121185813.A10347@asooo.flowerfire.com>
In-Reply-To: <Pine.LNX.3.96.1020121151224.23079A-100000@gatekeeper.tmr.com> <Pine.LNX.4.33.0201211626230.17139-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0201211626230.17139-100000@coffee.psychology.mcmaster.ca>; from hahn@physics.mcmaster.ca on Mon, Jan 21, 2002 at 04:42:28PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm ranting, and not at you directly, Mark.  But I think it's important
to get perspective here.

On Mon, Jan 21, 2002 at 04:42:28PM -0500, Mark Hahn wrote:
| > Explaining responsiveness is like describing color to a blind person, any
| > quantifications totally miss the experience.
| 
| you overestimate human uniqueness - we all have near-identical
| perceptual hardware, and there *is* an absolute limit
| beyond which no human can perceive.  for our purposes, let's
| say it's 5ms.

A 5ms wavelength is 200Hz.  Whether xterm lines scroll with a 5ms or a
10ms latency will most likely not be perceivable by most people.  On the
other hand, audio and video processing is worthless with a 5ms latency,
especially when the current worst-case is atrocious.

5ms is clearly a poor choice for human latency, but hard/software
latencies can never be small enough, just as processor speeds can never
be fast enough.  And we certainly can't pull these debatably "absolute"
limits out of thin air.

Of course, Linux is just for people who don't actually want to USE an
operating system, only those who want to write kernel code and don't
want to have to worry about "needless" complexity.

It is an invalid statement that all kernel modifications need to have
benchmarks or human case studies to justify them.  There are many parts
and functions of these systems that are not well-specified by
benchmarks, not to mention that one person's benchmark is another
person's non-real-world invalid test.

Ultimately the maintainers need to make this decision, based on the
community's exploration of theory, practice, and from appropriate
benchmarks or other research.  Research like the O(1) scheduler, rmap,
preemptive, and others need SUPPORT from this community.  One random
person should not get in the way of progress in a kernel that is not
only intended for that one person's narrow view of the world.

That being said, this one person's narrow view of the world is quite
important.  But however cheesy it sounds, "the greater good" is the
priority.

IMHO, latency is a critical part of Linux's growth, as is SMP
scalability (and a hundred other projects).  These are, perhaps due to
hardware restrictions, not a top priority.  But work on this type of
advancement MUST occur, and it must occur without having to fend off
people whose sole basis for argument is that they don't need it, or that
it will be hard, or that they need proof from sources they are unwilling
to mention.

>From what I've seen of the preemption and latency discussions, the Linux
kernel is going to be constrained to old technology and old ideas for
the foreseeable future.  People unable or unwilling to see the light
insist on being able to see the chicken before the egg is hatched.

Can this community be open-source and research-oriented without seeing
the business model and profit forecasts first?

I hope so.
-- 
Ken.
brownfld@irridia.com


| > There are some responsemarks which may or may not be useful, feel free to
| > actually locate and run these and post the results instead of posting
| 
| I posted "realfeel" last year, AKPM added some touches to it.
| it's in his amlat bundle.  


