Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131438AbQLLFvQ>; Tue, 12 Dec 2000 00:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131448AbQLLFvG>; Tue, 12 Dec 2000 00:51:06 -0500
Received: from www.wen-online.de ([212.223.88.39]:64772 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131438AbQLLFuz>;
	Tue, 12 Dec 2000 00:50:55 -0500
Date: Tue, 12 Dec 2000 06:20:26 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Steven Cole <elenstev@mesatop.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
In-Reply-To: <00121122173600.03488@localhost.localdomain>
Message-ID: <Pine.Linu.4.10.10012120618320.1164-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2000, Steven Cole wrote:

> On Mon, 11 Dec 2000, Mike Galbraith wrote:
> > On Mon, 11 Dec 2000, Steven Cole wrote:
> > > I have a SMP (dual P-III 733Mhz) machine at work, but it will be
> > > unavailable for testing for a few more days.  I suspect that 2.4.0-test12
> > > will do better than 2.2.18 with 2 CPUs.  I'll know in a few days.
> [snip]
> >
> > I think it's better with -j.  Do it with -jN where N is small enough
> > to keep the box away from swap, and then repeat with N large enough to
> > swap modestly (not too heavily or you're only testing disk MTBF:).
> 
> I've always used make -j2 bzImage for my two processor machine. 
> I like being able to build kernels in a little over two minutes. 
> 
> Simple question here, and risking displaying great ignorance:
> Does it make sense to use make -jN where N is much greater than the 
> number of CPUs?  

If you're testing VM, definitely yes.  Otherwise.. _not_ ;-)

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
