Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262688AbUJ1Bzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262688AbUJ1Bzd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 21:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbUJ1Bzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 21:55:33 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:41168 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262688AbUJ1BzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 21:55:13 -0400
Date: Thu, 28 Oct 2004 03:49:52 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Larry McVoy <lm@bitmover.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@novell.com>,
       Joe Perches <joe@perches.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: BK kernel workflow
In-Reply-To: <20041028005412.GA8065@work.bitmover.com>
Message-ID: <Pine.LNX.4.61.0410280314490.877@scrub.home>
References: <1098707342.7355.44.camel@localhost.localdomain>
 <20041025133951.GW14325@dualathlon.random> <20041025162022.GA27979@work.bitmover.com>
 <20041025164732.GE14325@dualathlon.random> <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org>
 <Pine.LNX.4.61.0410252350240.17266@scrub.home> <20041026010141.GA15919@work.bitmover.com>
 <Pine.LNX.4.61.0410270338310.877@scrub.home> <20041027035412.GA8493@work.bitmover.com>
 <Pine.LNX.4.61.0410272214580.877@scrub.home> <20041028005412.GA8065@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 27 Oct 2004, Larry McVoy wrote:

> 100% of the data, diffs, comments, everything, is available in a BK2CVS
> exported CVS tree.  The comparison of the metadata is as follows:
> 
>     System          File deltas		Commits
>     BK              203,999		53,274        (1)
>     CVS             195,689		23,429        (2)
> 
> In other words, the files which contain the data have 96% of the same
> information as the BK files, at the same boundaries, the same patches can
> be generated, etc.  In 4% of the cases you are looking at a patch which
> was two commits in BK but one commit in CVS.  In 4% of the cases only.
> 96% of the time you'd get the same patch from each system.

Actually the Commit numbers are far more interesting and here you have 
difference of 56% you haven't explained.
A large number of CVS commits are really also single BK commits (let's say 
30%, I have to leave the verification to you, but I don't think I'm that 
far of), that would leave 70% of BK commits merged into 32% of CVS 
commits. These 70% can't be extracted anymore as a single logical change 
from CVS.
The only reason this number isn't worse is that the kernel development is 
still quite serial, e.g. most of the patches sent by Andrew show up as a 
single commit, but the more people use bk the worse these numbers get.

> That's pretty darned good IMO.

I can play with numbers too...

> Maybe you weren't aware that that is the situation so you were complaining
> about something that wasn't true.  Now that you are aware that you are
> getting all of the data, all of the comments, in a form which is 96%
> of the way to being identical to BK you will no longer have a complaint.

You're only telling half of the story and I'm afraid you'll get away with 
it, because most people don't really know the topic that well and I can't 
blame them.

bye, Roman
