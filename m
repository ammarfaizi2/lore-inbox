Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261545AbTCGMWE>; Fri, 7 Mar 2003 07:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261543AbTCGMWE>; Fri, 7 Mar 2003 07:22:04 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41739 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261545AbTCGMWD>; Fri, 7 Mar 2003 07:22:03 -0500
Date: Fri, 7 Mar 2003 13:32:37 +0100
From: Pavel Machek <pavel@suse.cz>
To: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030307123237.GG18420@atrey.karlin.mff.cuni.cz>
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030301202617.A18142@kerberos.ncsl.nist.gov> <20030306161853.GD2781@zaurus.ucw.cz> <20030307121215.GA68353@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030307121215.GA68353@dspnet.fr.eu.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Can you elaborate? I thought that this
> > "real DAG" structure is more or less
> > equivalent to each developer having
> > his owm CVS repository...
> 
> Nope.  CVS uses RCS, and RCS only knows about trees, not graphs.
> Specifically, branch merges are not tagged as such, and as a result
> CVS is unable to pick up the best grandparent when doing a merge.
> That's the main reason of why branching under CVS is so painful
> (forgetting about the performance issues).

I see. But I still somehow can not understand how merging is
possible. Merge possibly means work-by-hand, right? So it is not as
simple as noting that 1.8 and 1.7.1.1 were merged into 1.9, no? [And
what if developer did really crap job at merging that, like dropping
all changes from 1.7.1.1?]

> > If I fixed CVS renames, added atomic
> > commits, splits and merges, and gave each
> > developer his own CVS repository,
> > would I be in same league as bk?
> > Ie 10 times slower but equivalent
> > functionality?
> 
> Nope.  You'll find out that this per-developper repository quickly
> needs to become a per-branch repository, and even need you need to
> write somewhere when the merges with other repositories happen, and
> you end up with the DAG again.

Yep, that's what I wanted to know. [I see per-branch repository is
pain, but it helps me to understand that.]

Thanx for your explanations,
							Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
