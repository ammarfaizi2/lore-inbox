Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVCCUeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVCCUeW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 15:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbVCCUbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 15:31:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:14469 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261669AbVCCU2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 15:28:08 -0500
Date: Thu, 3 Mar 2005 12:27:40 -0800
From: Greg KH <greg@kroah.com>
To: Sean <seanlkml@sympatico.ca>
Cc: Linus Torvalds <torvalds@osdl.org>, Jens Axboe <axboe@suse.de>,
       Chris Wright <chrisw@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303202740.GA13522@kroah.com>
References: <42268749.4010504@pobox.com> <Pine.LNX.4.58.0503030952120.25732@ppc970.osdl.org> <4737.10.10.10.24.1109878529.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4737.10.10.10.24.1109878529.squirrel@linux1>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 02:35:29PM -0500, Sean wrote:
> On Thu, March 3, 2005 12:53 pm, Linus Torvalds said:
> > On Thu, 3 Mar 2005, Jens Axboe wrote:
> >>
> >> Why should there be one? One of the things I like about this concept is
> >> that it's just a moving tree. There could be daily snapshots like the
> >> -bkX "releases" of Linus's tree, if there are changes from the day
> >> before. It means (hopefully) that no one will "wait for x.y.z.2 because
> >> that is really stable".
> >
> > Exactly. Th ewhole point of this tree is that there shouldn't be anything
> > questionable in it. All the patches are independent, and they are all
> > trivial and small.
> >
> > Which is not to say there couldn't be regressions even from trivial and
> > small patches, and yes, there will be an outcry when there is, but we're
> > talking minimizing the risk, not making it impossible.
> >
> 
> Wait a second though, this tree will be branched from the development
> mainline.   So it will contain many patches that entered with less
> testing.

Less testing than what?  Remember, we don't have a "test suite" for the
kernel, no matter how much propaganda osdl likes to emit :)

> What will be the policy for dealing with regressions relative
> to the previous $sucker release caused by huge patches that entered via
> the development tree?   Is reverting them prohibited because of the patch
> size?

We'll deal with them as they come, on a case-by-case basis.  Acceptable?

thanks,

greg k-h
