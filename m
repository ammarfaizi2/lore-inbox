Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287191AbRL2WEe>; Sat, 29 Dec 2001 17:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287018AbRL2WEY>; Sat, 29 Dec 2001 17:04:24 -0500
Received: from bitmover.com ([192.132.92.2]:19624 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S286794AbRL2WEL>;
	Sat, 29 Dec 2001 17:04:11 -0500
Date: Sat, 29 Dec 2001 14:04:10 -0800
From: Larry McVoy <lm@bitmover.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Oliver Xymoron <oxymoron@waste.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
Message-ID: <20011229140410.A13883@work.bitmover.com>
Mail-Followup-To: Benjamin LaHaise <bcrl@redhat.com>,
	Oliver Xymoron <oxymoron@waste.org>,
	Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011229190600.2556C36DE6@hog.ctrl-c.liu.se> <Pine.LNX.4.43.0112291313160.18183-100000@waste.org> <20011229113749.D19306@work.bitmover.com> <20011229160334.A9919@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011229160334.A9919@redhat.com>; from bcrl@redhat.com on Sat, Dec 29, 2001 at 04:03:34PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2001 at 04:03:34PM -0500, Benjamin LaHaise wrote:
> On Sat, Dec 29, 2001 at 11:37:49AM -0800, Larry McVoy wrote:
> > If you have N people trying to patch the same file, you'll require N
> > releases and some poor shlep is going to have to resubmit their patch
> > N-1 times before it gets in.
> 
> Wrong.  Most patches are independant, and even touch different functions.  

Really?  And the data which shows this absolute statement to be true is
where?  I'm happy to believe data, but there is no data here.

> Things like "add member foo of type baz to struct z" are independant 
> changes even if they conflict when patching.

So what?  A conflict is anything that the patch(1) can't handle automatically.
The fact that the conflicts are independent changes is irrelevant, patch
doesn't care.

> > Anyway, I'm interested to see if there are screams of "all I ever do is
> > merge and I hate it" or "merging?  what's that?".
> 
> How about "I'm sick of resending this one line bugfix to maintainer of 
> $foo who keeps dropping it"?  That's the problem that patchbot is meant 
> to solve, not the merging problem.

OK, so go solve it already.  Just don't be surprised when if it doesn't
get used because it is yet another 10% solution.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
