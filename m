Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932626AbWCXOJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbWCXOJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 09:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbWCXOJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 09:09:28 -0500
Received: from mail.gmx.de ([213.165.64.20]:11402 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932626AbWCXOJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 09:09:27 -0500
X-Authenticated: #14349625
Subject: Re: [2.6.16-mm1 patch] throttling tree patches
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <200603250052.40235.kernel@kolivas.org>
References: <1143198208.7741.8.camel@homer>
	 <200603242334.19837.kernel@kolivas.org> <1143205342.7741.104.camel@homer>
	 <200603250052.40235.kernel@kolivas.org>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 15:10:12 +0100
Message-Id: <1143209412.7664.11.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-25 at 00:52 +1100, Con Kolivas wrote:
> On Saturday 25 March 2006 00:02, Mike Galbraith wrote:
> > On Fri, 2006-03-24 at 23:34 +1100, Con Kolivas wrote:
> > > I feel this discussion may degenerate beyond this point. Should we say to
> > > agree to disagree at this point? I don't like these changes.
> >
> > Why should it degenerate?  You express your concerns, I answer them.
> > You don't have to agree with me, and I don't have to agree with you.
> > That's no reason for the discussion to degenerate.
> 
> By degenerate I mean get stuck in an endless loop. I don't have the energy for 
> cyclical discussions where no conclusive endpoint can ever be reached. That 
> is the nature of what we're discussing. Everything is some sort of compromise 
> and you're moving one set of compromises for another which means this can be 
> debated forever without a right or wrong.
> 
> The merits of throttling seem obvious with a sliding scale between 
> interactivity and fairness. These other changes, to me, do not. On the 
> interactivity side I only have interbench for hard data, and it is showing me 
> regressions consistent with my concerns from these other "cleanups". You'll 
> trade some other advantage for these and we'll repeat the discussion all over 
> again. Rinse and repeat.

So be it.  We shall agree to disagree.

I'll close with this.  I'm not basing any of my changes on a benchmark,
I'm basing them on real life applications and exploits written by people
who were experiencing problems with their real life applications.  It is
my carefully considered opinion that those changes which you so strongly
oppose are important.

	-Mike

