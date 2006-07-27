Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWG0Vmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWG0Vmi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWG0Vmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 17:42:38 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18119 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751060AbWG0Vmh (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 17:42:37 -0400
Date: Thu, 27 Jul 2006 23:42:25 +0200
From: Pavel Machek <pavel@suse.cz>
To: Olivier Galibert <galibert@pobox.com>, Theodore Tso <tytso@mit.edu>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Nikita Danilov <nikita@clusterfs.com>, Steve Lord <lord@xfs.org>
Subject: suspend2 merge history [was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion]
Message-ID: <20060727214224.GB3797@elf.ucw.cz>
References: <44C12F0A.1010008@namesys.com> <20060722130219.GB7321@thunk.org> <44C42B92.40507@xfs.org> <17604.31844.765717.375423@gargle.gargle.HOWL> <20060724103023.GA7615@thunk.org> <20060724113534.GA64920@dspnet.fr.eu.org> <20060724133939.GA11353@thunk.org> <20060724153853.GA88678@dspnet.fr.eu.org> <20060726130806.GA5270@ucw.cz> <20060727155222.GA30593@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727155222.GA30593@dspnet.fr.eu.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > A much more important effect is that non-maintainers aren't familiar
> > > > with coding and patch submission guidelines.  For example, in
> > > > suspend2, Nigel first tried with patches that were too monolithic,
> > > > and then his next series was too broken down such that it was too
> > > > hard to review (and "git bisect" wouldn't work).
> > > 
> > > All his submissions since 2004 or so?  It's a little easy to limit
> > > oneself to the last two ones.
> > 
> > Nigel did not do any submissions in 2004 or so. Check your fact, that
> > stuff was marked 'RFC' and yes I did comment on it.
> 
> 2004-09-16 submission:
> 
> http://lkml.org/lkml/2004/9/16/76
...
> http://lkml.org/lkml/2004/9/16/90

Yes, Nigel submitted part of suspend2 here (I do not think he
submitted compression code on that day, for example), but then

http://lkml.org/lkml/2004/9/16/347

came:

#I should mention, I'm planning on producing a BK tree with these patches
#(and ones to fix issues raised), so you won't have to include a long
#list in -mm eventually! It will be on suspend2.bkbits.net (not there
#yet).

That sounds like "don't merge it yet, I'll prepare better version" to
me.

> 2004-11-24 submission:
> 
> http://lkml.org/lkml/2004/11/24/93
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Okay, this one is important. It starts with 

#Hi everyone.
#
#I know that I still have work to do on suspend2, but thought it was high
#time I got around to properly submitting the code for review, so here goes.

That looks like request for review, not request for merge. Plus it was
to: lkml, while it should be to: maintainer (or maybe to: akpm). Well,
it also says "Suspend 2 merge" in subject..
 
> > He did 1 (one) submission that looked like SubmittingPatches at the
> > first sight, and that was very recent.
> > 
> > Stop spreading lies.
> 
> I am awaiting your apologies.

Okay, 11/24 looked closer to submission than I recalled. So I guess I
have to say "sorry".

So we have 1 submission for review in 11/2004 and 1 submission for -mm
merge in 2006, right?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
