Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261481AbTCGCfb>; Thu, 6 Mar 2003 21:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261482AbTCGCfb>; Thu, 6 Mar 2003 21:35:31 -0500
Received: from [216.234.192.169] ([216.234.192.169]:18441 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP
	id <S261481AbTCGCfa>; Thu, 6 Mar 2003 21:35:30 -0500
Subject: Re: Those ruddy punctuation fixes
From: Steven Cole <elenstev@mesatop.com>
To: Val Henson <val@nmt.edu>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030307010422.GI26725@boardwalk>
References: <20030305111015.B8883@flint.arm.linux.org.uk>
	<20030305122008.GA4280@suse.de> <1046920285.3786.68.camel@spc1.mesatop.com>
	 <20030307010422.GI26725@boardwalk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 06 Mar 2003 19:44:01 -0700
Message-Id: <1047005054.4114.99.camel@spc1.mesatop.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 18:04, Val Henson wrote:
> On Wed, Mar 05, 2003 at 08:11:11PM -0700, Steven Cole wrote:
> > 
> > That is why I was very careful with my its -> it's patch.
> > In the two files where an extra apostrophe would have broken
> > the build, I changed its to it is.  Why not just leave it alone?
> > Because some well-meaning spelling fixer may come along in the
> > future and break it, just like in proc-fns.h.
> 
> Wait, this sounds like a conversation with the Mafia:
> 
> "Pay us protection money."
> "Why do we need to pay you for protection?"
> "So we can protect you from criminals like ourselves."

That's a ridiculous comparison and it weakens your argument.  Leaving a
potential problem in place rather than fixing it as I did would be the
passive-aggressive approach, not the other way around.

> 
> I'd rather solve this problem by making standalone spelling fixes and
> other cosmetic changes taboo.  Cosmetic changes combined with actual
> useful code changes are fine with me.  If you're risking breaking the
> build, there should be some benefit that justifies the risk.

Breaking the build is a low probability (many hundreds of fixes and one 
build break AFAIK) and low consequence failure (a build fix of that
nature is obvious and quickly and easily done).

> 
> Consider this a vote against standalone spelling/typo patches.
> 
> -VAL (normally a total pedant about spelling and grammar)

The more persuasive argument against tree-wide fixes has been made by
Dave Jones, who has been slowed down by having to reconcile his external
patches with these changes.  For that reason, I've suggested that
maintainers use Dan Kegel's scripts to clean up their own areas when the
time is right for them.  But the maintainers have better things to do
with their time that this kind of low priority work. So chances are that
the spelling fix situation will go back into hibernation for another
release cycle, which I'm sure will make a lot of people happy.

Steven

