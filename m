Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287171AbRL2Ji2>; Sat, 29 Dec 2001 04:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287173AbRL2JiS>; Sat, 29 Dec 2001 04:38:18 -0500
Received: from dsl-213-023-043-128.arcor-ip.net ([213.23.43.128]:29712 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287171AbRL2JiB>;
	Sat, 29 Dec 2001 04:38:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>, Legacy Fishtank <garzik@havoc.gtf.org>
Subject: Re: State of the new config & build system
Date: Sat, 29 Dec 2001 10:40:33 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Keith Owens <kaos@ocs.com.au>, Mike Castle <dalgoda@ix.netcom.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011229042139.GC14067@thune.mrc-home.com> <20011229024143.A11696@havoc.gtf.org> <3C2D7B2B.C1362850@zip.com.au>
In-Reply-To: <3C2D7B2B.C1362850@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16KFyl-0000DL-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 29, 2001 09:13 am, Andrew Morton wrote:
> Legacy Fishtank wrote:
> > 
> > On Sat, Dec 29, 2001 at 03:44:10PM +1100, Keith Owens wrote:
> > > What Mr. Fishtank seems to overlook is that kbuild 2.5 is far more
> > > flexible and accurate than 2.4, including features that lots of people
> > > want, like separate source and object trees.
> > 
> > I don't see the masses, or, well, anybody on lkml, clamoring for this.
> 
> Clamour.

Clamour.

Broke my tree yesterday, rm -rf was the fastest/easiest way out.

Immediately after make -j2 bzImage, make bzImage seems to rebuild about half 
the tree.

Many incidents of time-wasting breakage over the last couple of years for me.

> Keith says it speeds up builds where only a small number of files
> have changed.  For me, that's the common case.

Ooh, yes!

> I'd like to hear more from Keith on where this 100% actually occurs,
> but if he says it's fixable in a (give him four) week timeframe,
> I believe him.

He said something about reloading dependencies on each compile.

--
Daniel
