Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277044AbRJDAfu>; Wed, 3 Oct 2001 20:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277046AbRJDAfl>; Wed, 3 Oct 2001 20:35:41 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:28421 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S277044AbRJDAfd>; Wed, 3 Oct 2001 20:35:33 -0400
Date: Wed, 3 Oct 2001 20:36:01 -0400
Message-Id: <200110040036.f940a1I08480@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel changes
X-Newsgroups: linux.dev.kernel
In-Reply-To: <07f901c148b8$720a6230$1a01a8c0@allyourbase>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <07f901c148b8$720a6230$1a01a8c0@allyourbase> dmaas@dcine.com wrote:
| > The answer is to treat all linus/ac/aa/... kernels as development
| > kernels.  Don't treat anything as stable until it's been through
| > a real QA cycle.
| 
| I definitely have to second what you guys are saying here... 2.2.x is the
| stable kernel series, 2.4.x is for caffeine-fueled developers who read the
| LKML at least once every day...

  Not really. I have found that 2.4 kernels are usefully stable if you
pick them carefully.

| e.g. I consider it extremely embarrassing that fundamental drivers like
| aic7xxx, emu10k1, tulip, etc. are breaking regularly in the mainline
| kernels. I haven't had any trouble with things like this in Windows for
| several years now... Sure the Windows drivers are probably a few percent
| slower, but as Nathan Myers once wrote, "It is meaningless to compare the
| efficiency of a running system against one which might have done some
| operations faster if it had not crashed."

  Again, given the choice of the o/s failing every few months or not
using your hardware, where do you go? I haven't found a 2.2 kernel which
like running multiple NICs at 85% of max most of the time, while several
of the 2.4.kernels, most recently 2.4.6 will.

| I think we all owe major thanks to Alan Cox, who does his best to keep the
| house in order amidst the chaos of kernel development (kudos to Mr. Cox for
| holding on to Rik's VM design long enough for it to stabilize!). If anything
| I wish there were a third primary maintainer who would take an even more
| conservative stance, hanging maybe 2 minor versions behind Linus and -ac,
| and only picking up changes that have been tested widely. Hmm, the people
| working on distro kernels are probably just about doing this already...
| Maybe if they could combine efforts somehow?

  A quick look at the c.o.l.development.system will show I said ages ago
that we should QA "stable" kernel releases before sending them out. I
offered to set up a group to do that for each release candidate, but
there was no interest.

  The VM work is really needed, but I wish the development was in "pre"
kernels, not releases. I've been playing while on vacation, and
2.4.9-ac14 looks much better, 2.4.9-ac16 has minor problems on a machine
I won't see until I "get back to work," and I haven't deceded if I want
to try 2.4.9-ac18 or not. Sadly, horror stories on 2.4.10 have suggested
that I let others try that.

  Given the load of totally new VM stuff dropped in, I admit I'd like to
see useful stuff which only takes effect if configured (the so-called
Athlon patch) in the kernel, since many systems simply will not run an
Athlon kernel without it. I only wish the preempt was being pushed as
hard as VM, it looks really good on loaded machines.

  Perhaps it's time for 2.5 indeed.

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe

