Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbVCEGun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVCEGun (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 01:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbVCEGun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 01:50:43 -0500
Received: from bama.hardrock.org ([68.146.16.251]:23199 "EHLO
	mail.hardrock.org") by vger.kernel.org with ESMTP id S261964AbVCEGu1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 01:50:27 -0500
Date: Fri, 4 Mar 2005 23:50:22 -0700 (MST)
From: James Bourne <jbourne@hardrock.org>
X-X-Sender: jbourne@rio.clgy.hardrock.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0503042340080.7221@rio.clgy.hardrock.org>
References: <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net>
 <422674A4.9080209@pobox.com> <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
 <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net>
 <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com>
 <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com>
 <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com>
 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2005, Linus Torvalds wrote:

> On Thu, 3 Mar 2005, Jeff Garzik wrote:
> > 
> > We have all these problems precisely because _nobody_ is saying "I'm 
> > only going to accept bug fixes".  We _need_ some amount of release 
> > engineering.  Right now we basically have none.
> 
> I agree that this is one of the main problems.
> 
> But look at how to solve it. The _logical_ solution is to have a third
> line of defense: we have the -mm trees (wild and wacky patches), and we
> have my tree (hopefully not wacky any more), and it would be good to have
> a third level tree (which I'm just not interested in, because that one
> doesn't do any development any more) which only takes the "so totally not
> wild that it's really boring" patches.
> 
> In fact, if somebody maintained that kind of tree, especially in BK, it 
> would be trivial for me to just pull from it every once in a while (like 
> ever _day_ if necessary). But for that to work, then that tree would have 
> to be about so _obviously_ not wild patches that it's a no-brainer.

Sorry, I'm just on the end of this thread but I wanted to put in my 2 bits,

I was maintaining this type of tree for 2.4 before.  It was well received by
those who used it and it was stable (ssssh, I'm still running that puppy on
a couple well hidden 7.2 servers).

The key then was to only put in patches that fixed issues.  If it was a hard
factual solution to a problem then it went into the patch.  BTW, it was just
that, a patch (or set of patches) not actually a seperate tree.  It was
completely focused on stability as that's what I needed for work at the
time.

> So what's the problem with this approach? It would seem to make everybody
> happy: it would reduce my load, it would give people the alternate "2.6.x
> base kernel plus fixes only" parallell track, and it would _not_ have the 
> testability issue (because I think a lot of people would be happy to test 
> that tree, and if it was always based on the last 2.6.x release, there 
> would be no issues.

It was good for 2.4 and I think for 2.6, the legitimacy (coming from the top
down) will be a good thing.  It wasn't as widely received in 2.4 due to it
not being "officially sanctioned"...

BTW, it's not actually that much work.  Watching the list and getting feed
back on what works and what doesn't is all that it takes.  Naturally, there
will be a couple "frell, where was I when I did that" patches but that's
life in the semi-fast lane.

This will be a good thing.

Regards
James


-- 
James Bourne                  | Email:            jbourne@hardrock.org          
UNIX Systems Administration   | WWW:           http://www.hardrock.org
Custom UNIX Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  
