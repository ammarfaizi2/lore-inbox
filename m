Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317653AbSGOVeh>; Mon, 15 Jul 2002 17:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317657AbSGOVeg>; Mon, 15 Jul 2002 17:34:36 -0400
Received: from 217-13-24-22.dd.nextgentel.com ([217.13.24.22]:3503 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S317653AbSGOVed>;
	Mon, 15 Jul 2002 17:34:33 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jlnance@intrex.net, linux-kernel@vger.kernel.org
Subject: Re: BKL removal
References: <E17SIHK-00078r-00@the-village.bc.nu>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 15 Jul 2002 22:53:53 +0200
In-Reply-To: <E17SIHK-00078r-00@the-village.bc.nu>
Message-ID: <m3it3gg1b2.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > On Tue, Jul 09, 2002 at 11:21:25PM +0100, Alan Cox wrote:
> > > 
> > > There are lots of them hiding 8)
> > 
> > Just out of curisoty.  If I remember correctly SMP came to Linux when
> > Caldera hired you to make it work.  Did you invent the BKL?
> 
> Caldera bought the hardware, rather than hiring me. Having said that at
> the time the dual P90 board + processors was not exactly cheap. The board
> btw is alive and well and currently owned by Dave Jones.
> 
> As far as the locking goes I invented the big kernel lock, but the basis of
> that is all taken directly from "Unix systems for modern architectures"
> by Schimmel which is required reading for anyone who cares about caches,
> SMP and locking. 
> 
> 	I'd prefer the trees to be separate for testing purposes: it 
> 	doens't	make much sense to have SMP support as a normal kernel 
> 	feature when most people won't have SMP anyway"
> 			-- Linus Torvalds
> 

That takes Linux even one step closer to the big commercial world, we
now have a statement to quialify for membership into the same club as
Mr. Gates' "Who needs more than 640kb anyway?" and Olsen's (Digital?)
"There will only be a handfull of computers in the nation". :)

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
