Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbTIAPjN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 11:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262981AbTIAPjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 11:39:12 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:48595 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262965AbTIAPjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 11:39:05 -0400
Subject: Re: bitkeeper comments
From: Albert Cahalan <albert@users.sf.net>
To: Larry McVoy <lm@bitmover.com>
Cc: lm@work.bitmover.com, Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, ak@suse.de
In-Reply-To: <20030901140706.GG18458@work.bitmover.com>
References: <1062389729.314.31.camel@cube>
	 <20030901140706.GG18458@work.bitmover.com>
Content-Type: text/plain
Organization: 
Message-Id: <1062430014.314.59.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 01 Sep 2003 11:26:55 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-01 at 10:07, Larry McVoy wrote:
> On Mon, Sep 01, 2003 at 12:15:30AM -0400, Albert Cahalan wrote:
> > This just got into BitKeeper, about 10 hours ago:
> > 
> > > [PATCH] x86-64 update
> > >
> > > Make everything compile and boot again.
> > >
> > > The earlier third party ioport.c changes unfortunately
> > > didn't even compile, fix that too.
> > >
> > > - Update defconfig
> > > - Some minor cleanup
> > > - Introduce physid_t for APIC masks (fixes UP kernels)
> > > - Finish ioport.c merge and fix compilation
> > 
> > Several days ago, I mailed Andi Kleen a build log which
> > showed that ioport.c builds perfectly well on x86-64.
> > The whole 2.6.0-test4 kernel does in fact, as downloaded
> > from kernel.org. Andi Kleen agreed...
> > 
> > ...and now this comment gets submitted to Linus, ending
> > up in BitKeeper. I'd like this changed. I realize that
> > it may be a rather difficult thing to change at this point,
> > but it is clearly wrong.
> 
> If you want the comments changed I can do that on bkbits.net and anyone
> who grabs the update from there will get the new comments.  If you want
> the patch gone out of BK anyone can do that with a cset -x.

The code itself is OK I guess; the physid_t changes
may well be important, although they could be redone.

It's the comment that bugs me, specifically:

"Make everything compile and boot again."
"The earlier third party ioport.c changes unfortunately
didn't even compile, fix that too."
"Finish ioport.c merge and fix compilation"

(BTW, there's a bit more beyond the end of what I quoted)

I'm OK with whatever ensures that somebody looking back
through the BitKeeper logs isn't going to come to the
conclusion that I broke something.

Um, not everybody will grab updates from bkbits.net,
right? Pardon me for being clueless about BitKeeper,
but is there some command Andi or Linus could run?


