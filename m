Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbTDEVc1 (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 16:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbTDEVc0 (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 16:32:26 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:46352
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262663AbTDEVcZ (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 16:32:25 -0500
Date: Sat, 5 Apr 2003 13:39:13 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Stephan van Hienen <kernel@ddx.a2000.nu>
cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: onboard ICH4 seen as ICH3 (ultra100 controller onboard)
 (2.4.20/2.4.21-pre7)
In-Reply-To: <Pine.LNX.4.53.0304052324360.16674@ddx.a2000.nu>
Message-ID: <Pine.LNX.4.10.10304051337470.29290-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


NO, since they all use the same timings there is no problem.
Intel never made an Ultra 133, and all the timings from PIIX forward build
on each other.

There is no bug, except in your BIOS maybe.

Cheers,

On Sat, 5 Apr 2003, Stephan van Hienen wrote:

> On Sat, 5 Apr 2003, Mark Hahn wrote:
> 
> > > > > I don't think it is doing U100 :
> > > >
> > > > why?  25 MB/s is exactly what you should expect from a disk
> > > > which has around 15 GB/platter density.  the transfer mode
> > > > doesn't matter, as long as it's 10-20% faster than the transfer
> > > > rate of the disk's outer tracks.
> > >
> > > because it is the same disk (WD1800BB (180GB)) only difference is the
> > > controller...
> >
> > is the 80-pin cable validly configured and properly detected?
> > or did you cover this already?
> 
> all disks and cables are the same
> (i have 15 of these disks in this server)
> only difference are the controllers
> 
> and since the kernel is giving me incorrect info at boottime
> (ICH3 (instead of what is really there (ICH4))
> i really think this is an kernel problem
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

