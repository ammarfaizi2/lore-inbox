Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265137AbUEYUK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265137AbUEYUK4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 16:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265139AbUEYUK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 16:10:56 -0400
Received: from waste.org ([209.173.204.2]:26085 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S265137AbUEYUKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 16:10:47 -0400
Date: Tue, 25 May 2004 15:10:41 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andy Isaacson <adi@hexapodia.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
Message-ID: <20040525201041.GZ5414@waste.org>
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org> <20040525164232.GD28169@fieldses.org> <Pine.LNX.4.58.0405250948530.9951@ppc970.osdl.org> <20040525180834.GC26081@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040525180834.GC26081@hexapodia.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 01:08:34PM -0500, Andy Isaacson wrote:
> On Tue, May 25, 2004 at 10:05:26AM -0700, Linus Torvalds wrote:
> > On Tue, 25 May 2004, J. Bruce Fields wrote:
> > > The patch-submission process can be more complicated than a simple path
> > > up a heirarchy of maintainers--patches get bounced around a lot
> > > sometimes.
> > 
> > Yes. And documenting the complex relationships obviously can't be sanely 
> > done. The best we can do is a "it went through these people".
> > 
> > Perfect is the enemy of good. If we tried to be perfect, we'd never get 
> > anything done.
> 
> Agreed, but...
> 
> > > 	* I write a patch.  Developers X and Y suggest significant
> > > 	  changes.  I make the changes before I submit them to maintainer
> > > 	  Z.  Suppose the changes are significant enough that I no longer
> > > 	  feel comfortable representing myself as the sole author of the
> > > 	  patch.  Should I also be asking developer X  and Y to add their
> > > 	  own "Signed-off-by" lines?
> > 
> > That, my friend, is a matter of your own taste and conscience. My answer
> > is that if you wrote it all, you clearly don't _need_ to. At the same
> > time, I think that it's certainly in good taste to at least _ask_ them. 
> > Wouldn't you agree?
> 
> This is one example of a general class of problem; another example is
> "Andrew integrated 15 patches into -mm5".  When you have an aggregate
> work representing a conglomeration of works from several different
> developers, it becomes unwieldy to apply "tags" as you're suggesting.
> 
> What if I send a patch to l-k, and Bruce forwards it on to Andrew;
> meanwhile, Joe sends another patch to l-k and Peter forwards it on to
> Andrew.  Andrew integrates both patches, as well as several unrelated
> bits he creates himself, into -mm77, which he sends to Linus and gets
> integrated.

But -mm is actually maintained as a serial set of patches, each
submitted independently. Occassionally patches are rolled together
here, but that's the exception.

The case I'm still worried about is something like a filesystem that
gets worked on out-of-tree for an extended period of time and gets
submitted in a lump. If it's developed inside the confines of a
corporation, sure, it can be signed off by one person in authority,
but if it's developed in the open with numerous outside submissions,
it's less clear what the right thing is. Aggregating 500
signed-off-bys might get messy.

-- 
Mathematics is the supreme nostalgia of our time.
