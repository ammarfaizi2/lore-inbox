Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbVJ2U2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbVJ2U2i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 16:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932065AbVJ2U2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 16:28:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20151 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932086AbVJ2U2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 16:28:37 -0400
Date: Sat, 29 Oct 2005 13:28:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Tony Luck <tony.luck@gmail.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: New (now current development process)
In-Reply-To: <20051029195115.GD14039@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0510291314100.3348@g5.osdl.org>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
 <12c511ca0510291157u5557b6b1x85a47311f0e16436@mail.gmail.com>
 <20051029195115.GD14039@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 29 Oct 2005, Russell King wrote:

> On Sat, Oct 29, 2005 at 11:57:30AM -0700, Tony Luck wrote:
> > IIRC the goal was to make a release in around 8 weeks (which would
> > be closer to six per year).  But you have the important part, which is
> > that Linus doesn't make the release until it is "ready".  2.6.13 was
> > released on August 28th, and 2.6.14 on October 27th ... so we
> > appear to have hit the goal this time through.
> 
> However, three months is _far_ too long.  Look at what is happening
> post-2.6.14?  There's loads of really huge changes going in which
> were backed up over the last two months.

Yes. Three months would be too much. I considered even 2.6.14 to be 
delayed by at least one week. So 8 weeks is certainly better than it used 
to be, but I think 6 weeks should be the goal-post.

But to hit that, we'd might need to shrink the "merge window" from two 
weeks to just one, otherwise there's not enough time to calm down. With 
most of the real development happening during the previous calm-down 
stage, that might not be impossible: we'd only have one week for merges, 
but that isn't the week when development actually happens, so who cares?

Everything said, I think 2.6.13->14 worked well enough, even if it's hard 
to say how well a process works after one release. Considering that 2.6.13 
had the painful PCI changes (you may not have noticed too much, since they 
were x86 only) and there were some potentially painful SCSI changes in the 
.14 early merges, so it's not like 13->14 was an "easy" release - so the 
process certainly _seems_ to be workable.

So I'm planning on continuing with it unchanged for now. Two-week merge 
window until -rc1, and then another -rc kernel roughly every week until 
release. With the goal being 6 weeks, and 8 weeks being ok.

I don't think anybody has been really unhappy with this approach? Hmm?

			Linus
