Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310333AbSBRJlb>; Mon, 18 Feb 2002 04:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310340AbSBRJlV>; Mon, 18 Feb 2002 04:41:21 -0500
Received: from 89dyn216.com21.casema.net ([62.234.20.216]:52375 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S310333AbSBRJlK>; Mon, 18 Feb 2002 04:41:10 -0500
Message-Id: <200202180941.KAA00769@cave.bitwizard.nl>
Subject: Re: Disgusted with kbuild developers
In-Reply-To: <20020215153636.D32005@work.bitmover.com> from Larry McVoy at "Feb
 15, 2002 03:36:36 pm"
To: Larry McVoy <lm@bitmover.com>
Date: Mon, 18 Feb 2002 10:41:03 +0100 (MET)
CC: linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> On Sat, Feb 16, 2002 at 12:23:12AM +0100, Matthias Andree wrote:
> > Are you telling that kernel programmers don't rewrite code from scratch?
> > Is that a correct interpretation of "improve the existing system"? Note
> > that "it can't be done" can also imply "cannot reasonable be done".
> > 
> > If that's not what you mean, stop reading this mail, drop a line to
> > clarify this and forget this piece of mail.
> 
> That's not what I mean.  But it's worthwhile to note that almost all
> "rewrite from scratch" projects really translate into "I'm unwilling to
> learn what the last guy did, and I'm smarter, so I'm going to do what
> I want to do".  And that is not what kernel programmers do.  They would
> love to be able to do that but it's very rare that doing so makes sense.

Sometimes the "old" code is set up in such a way that the "right" way
to do it is not possible. That doesn't make the last guy "stupid": it
can be that when he did it, that was the right way to do things, but
that we've learned since then.

If the "cleanup" would result in changing more than say 60% of the
code, then a rewrite is in order. The old code is usually still in
place. That will allow you to "steal" code that is not the core of the
rewrite: just copy it.


I've heard that someone is trying to revolutionize "source code
control systems". He's rewriting almost everything, and not enhancing
any previous systems. What was his name again?

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
