Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbVICIPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbVICIPT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 04:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbVICIPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 04:15:19 -0400
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:56465 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751392AbVICIPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 04:15:17 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Date: Sat, 3 Sep 2005 18:14:48 +1000
User-Agent: KMail/1.8.2
Cc: vatsa@in.ibm.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk>
In-Reply-To: <20050903090650.B26998@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509031814.49666.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Sep 2005 18:06, Russell King wrote:
> On Sat, Sep 03, 2005 at 06:01:08PM +1000, Con Kolivas wrote:
> > On Sat, 3 Sep 2005 17:58, Russell King wrote:
> > > On Sat, Sep 03, 2005 at 04:13:10PM +1000, Con Kolivas wrote:
> > > > Noone's ignoring you.
> > > >
> > > > What we need to do is ensure that dynamic ticks is working properly
> > > > on x86 and worth including before anything else. If and when we
> > > > confirm this it makes sense only then to try and merge code from the
> > > > other 2 architectures to as much common code as possible as no doubt
> > > > we'll be modifying other architectures we're less familiar with. At
> > > > that stage we will definitely want to tread even more cautiously at
> > > > that stage.
> > >
> > > dyntick has all the hallmarks of ending up another mess just like the
> > > "generic" (hahaha) irq stuff in kernel/irq - it's being developed in
> > > precisely the same way - by ignore non-x86 stuff.
> > >
> > > I can well see that someone will say "ok, this is ready, merge it"
> > > at which point we then end up with multiple differing userspace
> > > methods of controlling it depending on the architecture, but
> > > multiple differing kernel interfaces as well.
> > >
> > > Indeed, you seem to be at the point where you'd like akpm to merge
> > > it.  That sets alarm bells ringing if you haven't considered these
> > > issues.
> > >
> > > I want to avoid that.  Just because a couple of people say "we'll
> > > deal with that later" it's no guarantee that it _will_ happen.  I
> > > want to ensure that ARM doesn't get fscked over again like it did
> > > with the generic IRQ crap.
> >
> > Ok I'll make it clearer. We don't merge x86 dynticks to mainline till all
> > are consolidated in -mm.
>
> Does this mean you're seriously going to rewrite bits of it after
> you've spent what seems like months sorting out all the problems
> currently being found?
>
> Excuse me for being stupid, but I somehow don't see that happening.
> Those months would be effectively wasted effort, both on the side
> of the people working on the patches and those testing them.

I've personally been on this code for 3 separate days in total and have no 
deadline or requirement for this to go in ever so I should stop speaking on 
behalf of the others.

Cheers,
Con
