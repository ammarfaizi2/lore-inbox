Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319267AbSIFRtN>; Fri, 6 Sep 2002 13:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319270AbSIFRtM>; Fri, 6 Sep 2002 13:49:12 -0400
Received: from 62-190-218-30.pdu.pipex.net ([62.190.218.30]:52484 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S319267AbSIFRtM>; Fri, 6 Sep 2002 13:49:12 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209061800.g86I0CO9004896@darkstar.example.net>
Subject: Re: ide drive dying?
To: Billy.Harvey@thrillseeker.net (Billy Harvey)
Date: Fri, 6 Sep 2002 19:00:11 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <1031328893.16365.243.camel@rhino> from "Billy Harvey" at Sep 06, 2002 12:14:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 2002-09-06 at 11:42, Mike Dresser wrote:
> > On 6 Sep 2002, Alan Cox wrote:
> > 
> > > On Fri, 2002-09-06 at 16:26, Mike Dresser wrote:
> > > > eBAY, and buy yourself a new drive.  You can pickup 80 gig drives for
> > > > around 80 bucks nowadays.  I used to recommend Maxtors, until they said
> > > > they're cutting their warranty to one year from three.  I don't know what
> > > > to use anymore.
> > >
> > > At current drive density and reliabilities - raid. Software raid setups
> > > are so cheap there is little point not running RAID on IDE nowdays
> > >
> > Well, I was looking more on the side of the Windows PC's here at the
> > office, it's a bit expensive to start running raid on those.
> > 
> > Mike
> 
> Well, I haven't examined this empirically, but as the quantity of disk
> drives in an organization continues increasing, so does the probability
> of disk failure, any one of which can mean lost time/money, etc.  Drive
> reliability is likely not increasing at the same rate that density is,
> so the likelihood of lost data is probably increasing.  Since LAN speeds
> continue to increase, it might start making sense now in clusters of
> more than a few machines to make each machine less reliant on its own
> disk storage (to the point of not at all other than big swap space) and
> use the LAN more.  On the LAN put the money into a quality shared
> resource - a heavy duty UPS'd, etc. RAID system.  Especially if a RAID
> system is as easy to build/maintain/use as Alan alludes to (don't know -
> never built one).

A RAID array isn't a universal solution to all disk related problems, though, is it?  I mean, we were talking about buggy firmware earlier on in this thread - if a drive which is part of an array returns corrupted data, without acknowledging it, then you'll read corrupted data from the RAID array.  Also, an array of unreliable drives doesn't make a reliable array.

Now that the Smart Suite S.M.A.R.T. applications are unmaintained, would there be any chance of implementing S.M.A.R.T. in to the kernel IDE code?  I know the IDE code is already a nightmare, but it would be a nice feature.  S.M.A.R.T. is terribly under used at the moment - most people don't even know what it is.  Infact, I could be wrong, but isn't a subset of S.M.A.R.T. implemented on modern SCSI disks, too?

Monitoring of any kind is always a nice feature to have...

John.
