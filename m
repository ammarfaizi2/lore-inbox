Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262655AbVCDIzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbVCDIzZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 03:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbVCDIzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 03:55:25 -0500
Received: from fire.osdl.org ([65.172.181.4]:57537 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262655AbVCDIzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 03:55:16 -0500
Date: Fri, 4 Mar 2005 00:54:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050304005450.05a2bd0c.akpm@osdl.org>
In-Reply-To: <1109924470.4032.105.camel@tglx.tec.linutronix.de>
References: <20050302205826.523b9144.davem@davemloft.net>
	<4226C235.1070609@pobox.com>
	<20050303080459.GA29235@kroah.com>
	<4226CA7E.4090905@pobox.com>
	<Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	<422751C1.7030607@pobox.com>
	<20050303181122.GB12103@kroah.com>
	<20050303151752.00527ae7.akpm@osdl.org>
	<20050303234523.GS8880@opteron.random>
	<20050303160330.5db86db7.akpm@osdl.org>
	<20050304025746.GD26085@tolot.miese-zwerge.org>
	<20050303213005.59a30ae6.akpm@osdl.org>
	<1109924470.4032.105.camel@tglx.tec.linutronix.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, 2005-03-03 at 21:30 -0800, Andrew Morton wrote:
> > You cannot have it both ways.  Either the kernel needs testers, or it is
> > "stable".  See how these are opposites?
> 
> I don't see a contradiction.

There is a *direct* contradition, but it's not important.

> I don't see that the releases are stable. They are defined stable by
> proclamation. 

If they were stable we'd release the darn things!  *obviously* -rc kernels
are expected to still have problems.

-rc just means "please start testing", not "deploy me on your corporate
database server".

People are smart enough to know that -rc3 will be less buggy than -rc1.

And if they're worried about bugs then why are they running -rc's at all?

> This 2.6.x.y tree will change nothing as long as the underlying problem
> is not solved.

What underlying problem?  The fact that -rc1 comes a bit too early?  Spare
me, that's just a nothing.  Anyone who is testing -rc kernels knows the
score.

That being said, yes, I agree that we should use 2.4-style -pre and -rc. 
But changing the names of things won't change anything.

> > It won't help that at all.  None of these proposals will increase testing
> > of tip-of-tree.  In fact the 2.6.x proposal may decrease that level of
> > that testing, although probably not much.
> > There is no complete answer to all of this, because there are competing
> > needs.  It's a question of balance.
> 
> A clearly defined switch from -preX to -rc will give the avarage user a
> clear sign where he might jump in and test. 

The average user has learnt "rc1 == pre1".  I don't expect that it matters
much at all.
