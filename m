Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUBNRCU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 12:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbUBNRCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 12:02:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:32696 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262425AbUBNRCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 12:02:19 -0500
Date: Sat, 14 Feb 2004 09:02:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Hellwig <hch@lst.de>
cc: jsimmons@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] back out fbdev sysfs support
In-Reply-To: <20040214165037.GA15985@lst.de>
Message-ID: <Pine.LNX.4.58.0402140857520.13436@home.osdl.org>
References: <20040214165037.GA15985@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 14 Feb 2004, Christoph Hellwig wrote:
> 
> <rant>
> James, what about pushing the 2GB worth of fbdev driver fixes in your
> tree to Linus so people actually get working fb support again instead
> of adding new holes?

Sorry, but at this point I WOULD NOT EVEN TAKE IT ANY MORE.

That's just how I work: if somebody maintains his own tree and builds up a 
lot of patches, that's _his_ problem. I'm not going to replace things 
totally unless there is some really fundamental reason I would have to. 
And quite frankly, the most common "fundamental reason" is that the 
maintainer has not done his job.

I want controlled patches that do one thing at a time. Not a 2GB untested 
dump.

>  A maintainers job can't be to apply patches to
> his personal CVS repository and sitting on them forever
> </rant>

.. and once he has patches, he can't just "dump" them out, either.

These things need to be done in a timely fashion, incrementally, one thing 
at a time. Anything else does not work.

And btw, for anybody who is impacted by this: you are encouraged to help. 
If you have a machine that works with some out-of-tree code but does 
_not_ work with the in-tree code, send a patch that fixes JUST THAT BUG.

Because if James can't trickle them in, somebody else will have to. That's 
what happened with the new radeon driver.

		Linus
