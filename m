Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262765AbUJ0WzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbUJ0WzC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 18:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbUJ0Wqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 18:46:40 -0400
Received: from mail.dif.dk ([193.138.115.101]:31671 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262765AbUJ0Wnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 18:43:43 -0400
Date: Thu, 28 Oct 2004 00:52:01 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Airlie <airlied@gmail.com>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
In-Reply-To: <Pine.LNX.4.58.0410271424590.28839@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0410280036490.3284@dragon.hygekrogen.localhost>
References: <4179F81A.4010601@yahoo.com.au> <417D7089.3070208@tmr.com> 
 <Pine.LNX.4.58.0410251458080.427@ppc970.osdl.org>  <20041027200805.GA17759@4t2.com>
  <Pine.LNX.4.58.0410271323040.28839@ppc970.osdl.org>
 <21d7e997041027141358b05c41@mail.gmail.com> <Pine.LNX.4.58.0410271424590.28839@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Linus Torvalds wrote:

> 
> 
> On Thu, 28 Oct 2004, Dave Airlie wrote:
> > 
> > There has been a fair bit of bike shedding going on... so I think we
> > should use some sort of timber and paint it red...
> 
> Ok, I nominate this for the strangest entry in the discussion so far.
> 
Heh, yeah, glad I'm not the only one incapable of making sense of that. :)

Anyway, I've been reading this thread and just want to add my own small 
comments to it  :

Personally I was a bit sceptical of the "new development model" at first, 
but as 2.6.x has progressed I've come to like it very much.
I'm using 2.6 on a number of boxes, servers, workstations at work and my 
personal machine at work, and my impression is that it's the fastest 
kernel we've had so far, and it's stable (at least I've not had any major 
issues). So to me it seems to be working just fine.

Some people have been asking for a sepperate tree for all the experimental 
and unstable stuff, but as I see it that role is fulfilled by Andrews -mm 
tree.
Things go into -mm, then get a bit (or a lot in some cases) workout and 
then slowly migrate into the mainline (Linus) tree as they settle down and 
are proven to be stable. This is good since it keeps the stable kernel 
up-to-date feature wise, and stuff has a place to get fixed and 
stabilized before it moves to mainline, so mainline 2.6 is not a minefield 
of unstable changes (and I think Andrew is doing a very good job at 
this), but it's not a hugely out-of-date thing as it used to be with a 
sepperate 2.<odd number>.x development tree.

The people asking for a very stable 2.6.x.y.z.whatever tree are forgetting 
a few things in my oppinion;
First they seem to forget that point releases actually serve the role of 
"new and improved stable kernel", so 2.6.x is the new "maintainance 
release" of the 2.6.x-1 kernel. 
Also they forget that there's a period of -rc releases before a point 
release where stability and incompatibility problems can be dealt with.
They also forget that there's nothing stopping them from forking off 2.6.x 
at any point in time and maintaining their own "ultra stable" kernel based 
on that release (hopefully they would still merge their fixes into 
whatever is the current Linus kernel).

I'm starting to ramble, all I really want to say is that I think the 
current model works well - changes get testing in -mm before hitting 
mainline, and mainline is not lacking behind in fixes and features as 
badly as we've seen earlier with 2.4.x vs 2.5.x, 2.3.x vs 2.2.x and 
previous development branches. And I think Andrew, Linus and the other 
main kernel people are doing a very good job with the kernel atm.

--
Jesper Juhl

