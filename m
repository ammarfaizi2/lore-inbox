Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284956AbRL2R1r>; Sat, 29 Dec 2001 12:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285099AbRL2R1h>; Sat, 29 Dec 2001 12:27:37 -0500
Received: from bitmover.com ([192.132.92.2]:18599 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S284956AbRL2R1a>;
	Sat, 29 Dec 2001 12:27:30 -0500
Date: Sat, 29 Dec 2001 09:27:29 -0800
From: Larry McVoy <lm@bitmover.com>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Larry McVoy <lm@bitmover.com>,
        linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
Message-ID: <20011229092729.X3727@work.bitmover.com>
Mail-Followup-To: Oliver Xymoron <oxymoron@waste.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112271236120.1167-100000@penguin.transmeta.com> <Pine.LNX.4.43.0112291102330.18183-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.43.0112291102330.18183-100000@waste.org>; from oxymoron@waste.org on Sat, Dec 29, 2001 at 11:14:18AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2001 at 11:14:18AM -0600, Oliver Xymoron wrote:
> Other useful tools are things like CVS blame:
> 
> http://bonsai.mozilla.org/cvsblame.cgi?file=mozilla/Makefile.in
> 
> (not sure how this would be done with single user check-in, but there's
> probably a way to hack it in)

We love the "blame" (aka annotate) feature and took it to a new level.
As an old coworker once said of SCM: "You can run, but you can't hide" :-)

We give you every possible variation of annotate in BK.  You can see the
annotated listing of any version of a file, and you construct arbitrary
versions of files.  The most useful one [1] is "show me the annotated
listing of all lines that have ever been in any version of this file".

You can also grep for stuff in the revision history.  From the man page [2]:

       To see if <pattern> occurs anywhere in any version of  any
       file of your tree:

           $ bk -r grep -R pattern

       To see if it occurs anywhere in the most recent version of
       of any file of your tree:

           $ bk -r grep pattern

       To see if it was added by the most recent delta made in of
       any file of your tree:

           $ bk -r grep -R+ pattern

[1] http://www.bitkeeper.com/manpages/bk-annotate-1.html
[2] http://www.bitkeeper.com/manpages/bk-grep-1.html
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
