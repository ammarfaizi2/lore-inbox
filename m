Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314702AbSGHIiM>; Mon, 8 Jul 2002 04:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314077AbSGHIiL>; Mon, 8 Jul 2002 04:38:11 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:17112 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314702AbSGHIiL>;
	Mon, 8 Jul 2002 04:38:11 -0400
Date: Mon, 8 Jul 2002 04:40:49 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux 2.5.25 (and LVM)
In-Reply-To: <20020708084315.GA1387@fib011235813.fsnet.co.uk>
Message-ID: <Pine.GSO.4.21.0207080435160.26134-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jul 2002, Joe Thornber wrote:

> On Sat, Jul 06, 2002 at 03:54:12PM +0200, Matthias Andree wrote:
> > On Fri, 05 Jul 2002, Linus Torvalds wrote:
> > 
> > > More merges all over the map - ppc, scsi, USB, kbuild, input drivers etc.
> > 
> > Did the LVM guys (are you listening?) tell anything if they were about
> > to go fix the current 2.5 LVM breakage? Or does EVMS work on 2.5 instead?
> 
> I'll say this yet again:
> 
> Heinz Mauelshagen is maintaining LVM1.0.x on 2.4 kernels.  This is for
> bug fixes only, no new features will be added.
> 
> Alasdair Kergon, Patrick Caulfield and myself are working on the more
> generic device-mapper driver for both 2.4/2.5.  Initially we have
> concentrated on 2.4, this driver is now very stable IMO (I would
> certainly trust my data to it in preference to LVM1).
> 
> I will post a URL to the 2.5 patch at some point this week.
> 
> There is no intention to maintain the broken design that is LVM1 in
> the 2.5 series - we do not have the spare resources to waste.

All right.  So how about removing it from the tree?  It's broken; it
won't be fixed; it's abandoned by maintainers (and $DEITY witness,
there is a lot of very good reasons for that); there's nobody who
would be able and willing to pick it.  What's the point of keeping
the damn thing in the tree?

Could you (or Heinz) submit the patch removing it from 2.5?

