Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262655AbRFQTK1>; Sun, 17 Jun 2001 15:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262641AbRFQTKR>; Sun, 17 Jun 2001 15:10:17 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:520 "EHLO
	Opus.bloom.county") by vger.kernel.org with ESMTP
	id <S262616AbRFQTKJ>; Sun, 17 Jun 2001 15:10:09 -0400
Date: Sun, 17 Jun 2001 12:06:45 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jakob ?stergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4 VM & swap question
Message-ID: <20010617120645.E11642@opus.bloom.county>
In-Reply-To: <20010617104836.B11642@opus.bloom.county> <20010617205835.A12767@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010617205835.A12767@unthought.net>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2001 at 08:58:35PM +0200, Jakob ?stergaard wrote:
> On Sun, Jun 17, 2001 at 10:48:36AM -0700, Tom Rini wrote:
> > 'lo all.  I've got a question about swap and RAM requirements in 2.4.  Now,
> > when 2.4.0 was kicked out, the fact that you need swap=2xRAM was mentioned.
> > But what I'm wondering is what exactly are the limits on this.  Right now
> > I've got an x86 box w/ 128ram and currently 256swap.  When I had 128, I'd get
> > low on ram/swap after some time in X, and doing this seems to 'fix' it, in
> > 2.4.4.  However, I've also got 2 PPC boxes, both with 256:256 in 2.4.  One
> > of which never has X up, but lots of other activity, and swap usage seems
> > to be about the same as 2.2.x (right now 'free' says i'm ~40MB into swap,
> > 18day+ uptime).  The other box is a laptop and has X up when it's awake and
> > that too doesn't seem to have any problem.  So what exactly is the real
> > minium swap ammount?
> 
> It completely totally and absolutely depends on the kind of workloads you put
> your system under.

Well, yes. :)  But 2.4.x is much more swap-happy then 2.2.x was.  I haven't 
changed my workload that much but the 256 swap became noticiably needed
recently.

> There is no simple answer.  swap = 2*phys may be reasonable for some desktop
> uses, I don't know.  But there *is* *no* *simple* *answer*.

Yes.  The problem is the requirement has seemingly doubled recently.

> With the amount of work that's gone into just *understanding* why the VM
> behaves as it does (even after the VM rewrite that was done exactly in order to
> come up with a VM we could *understand*), it's beyond me how anyone can even
> begin to think that one can define a set of simple and exact rules for minimum
> or "optimal" (whatever that means) values for swap.

Well, it's also been said that the 'need' for 2xswap was fixed by one of the
probably-not-yet-in-linus'-tree VM patches.  And that it's 'artificial'

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
