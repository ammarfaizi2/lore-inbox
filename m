Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290685AbSA3Wga>; Wed, 30 Jan 2002 17:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290684AbSA3WgU>; Wed, 30 Jan 2002 17:36:20 -0500
Received: from bitmover.com ([192.132.92.2]:57258 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S290683AbSA3WgJ>;
	Wed, 30 Jan 2002 17:36:09 -0500
Date: Wed, 30 Jan 2002 14:36:08 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Eli Carter <eli.carter@inet.com>, Georg Nikodym <georgn@somanetworks.com>,
        Larry McVoy <lm@bitmover.com>, Ingo Molnar <mingo@elte.hu>,
        Rik van Riel <riel@conectiva.com.br>,
        Tom Rini <trini@kernel.crashing.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Rob Landley <landley@trommello.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130143608.I22323@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Eli Carter <eli.carter@inet.com>,
	Georg Nikodym <georgn@somanetworks.com>,
	Larry McVoy <lm@bitmover.com>, Ingo Molnar <mingo@elte.hu>,
	Rik van Riel <riel@conectiva.com.br>,
	Tom Rini <trini@kernel.crashing.org>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Alexander Viro <viro@math.psu.edu>,
	Rob Landley <landley@trommello.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3C586C8D.2C100509@inet.com> <Pine.LNX.4.33.0201301408290.2618-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0201301408290.2618-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Jan 30, 2002 at 02:17:05PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 02:17:05PM -0800, Linus Torvalds wrote:
> The way BK works now, if we call the quick-and-dirty fix "A", and the real
> fix "B", the developer has a really hard time just sending "B" to me. He'd
> have to re-clone an earlier BK tree, re-do B in that tree, and then send
> me the second version.
> 
> I'm suggesting that he just send me B, and get rid of his tree. There are
> no dependencies on A, and I do not want _crap_ in my tree just because A
> was a temporary state for him.

And you just lost some useful information.  The fact that so-and-so did
fix A and then did B is actually useful.  It tells me that A didn't work
and B does.  You think it's "crap" and by tossing it dooms all future
developers to rethink the A->B transition.

There is a reason that commercial companies guard their revision history
and fight like mad to preserve it.  It contains useful information,
even the bad stuff is useful.

Some stuff may be so bad that it shouldn't ever get in the tree, but you
don't accept anything at all from those people in general.  If Al Viro
takes one pass at a problem and it works well enough that it gets in 
the tree, and then later does a pass two that cleans it up, I can learn
from that.  That's very useful information, his brain frequently shines
a light in a dark corner but I'd miss a lot of that without the history.

Your approach is constantly dropping useful information on the floor.
It may not be useful to you but it's useful to virtually everyone
else.  Saving that information will increase the quality and reduce
the quantity of the patches you get.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
