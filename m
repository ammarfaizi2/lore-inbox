Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261319AbTCGDyV>; Thu, 6 Mar 2003 22:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbTCGDyV>; Thu, 6 Mar 2003 22:54:21 -0500
Received: from [216.234.192.169] ([216.234.192.169]:25608 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP
	id <S261319AbTCGDyU>; Thu, 6 Mar 2003 22:54:20 -0500
Subject: Re: Those ruddy punctuation fixes
From: Steven Cole <elenstev@mesatop.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Val Henson <val@nmt.edu>, Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <300890000.1047008011@[10.10.2.4]>
References: <20030305111015.B8883@flint.arm.linux.org.uk><20030305122008.GA4280@suse.de>
	 <1046920285.3786.68.camel@spc1.mesatop.com>
	<20030307010422.GI26725@boardwalk>
	<1047005054.4114.99.camel@spc1.mesatop.com> 
	<300890000.1047008011@[10.10.2.4]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 06 Mar 2003 21:02:49 -0700
Message-Id: <1047009782.4114.108.camel@spc1.mesatop.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 20:33, Martin J. Bligh wrote:
> >> Wait, this sounds like a conversation with the Mafia:
> >> 
> >> "Pay us protection money."
> >> "Why do we need to pay you for protection?"
> >> "So we can protect you from criminals like ourselves."
> > 
> > That's a ridiculous comparison and it weakens your argument.  Leaving a
> 
> Reductio ad absurdum is often enlightening.
> 
> > potential problem in place rather than fixing it as I did would be the
> > passive-aggressive approach, not the other way around.
> 
> But that's not exactly what you're doing - you're replacing one 
> (very small) problem with another (very real) problem, the breakage 
> of people's patches. Fixing up patches because of spelling
> errors is a total waste of developer's time.

Agreed.

> 
> >> I'd rather solve this problem by making standalone spelling fixes and
> >> other cosmetic changes taboo.  Cosmetic changes combined with actual
> >> useful code changes are fine with me.  If you're risking breaking the
> >> build, there should be some benefit that justifies the risk.
> > 
> > Breaking the build is a low probability (many hundreds of fixes and one 
> > build break AFAIK) and low consequence failure (a build fix of that
> > nature is obvious and quickly and easily done).
> 
> Breaking the build is indeed a low probability (assuming you compile
> test your tree). Breaking other people's patches is a high probablility.

So another approach to this is to offer cleanup services to willing
maintainers who don't have the time to do it themselves.  If anyone
wants their section of the tree spell-corrected, I can do that with the
help of Dan's scripts (the easy part), and review the resulting diff for
inappropriate fixes (broken puns, changed meaning, broken compiles),
send that around to a small group (the spelling police squad) for
further review, and then send it back to the requesting maintainer, who
can /dev/null it entirely, or hack it up to his delight before sending
it Linuswards.

How's that?

Steven

