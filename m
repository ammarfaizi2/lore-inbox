Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319284AbSHGTgl>; Wed, 7 Aug 2002 15:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319285AbSHGTgl>; Wed, 7 Aug 2002 15:36:41 -0400
Received: from [195.39.17.254] ([195.39.17.254]:18560 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S319284AbSHGTgk>;
	Wed, 7 Aug 2002 15:36:40 -0400
Date: Sat, 3 Aug 2002 03:40:19 +0000
From: Pavel Machek <pavel@suse.cz>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: David Lang <david.lang@digitalinsight.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6] The List, pass #2
Message-ID: <20020803034019.A140@toy.ucw.cz>
References: <Pine.LNX.4.44.0207311500210.1038-100000@dlang.diginsite.com> <3D49006C.12ABC6FC@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3D49006C.12ABC6FC@aitel.hist.no>; from helgehaf@aitel.hist.no on Thu, Aug 01, 2002 at 11:33:33AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > o Remove all hardwired drivers from kernel
> > >
> > > I really hope this means drivers MAY be used as modules, not MUST. There
> > > is some overhead in doing things as modules, and added complexity usually
> > > means "harder to debug." Particularly with modules where there can be
> > > corner conditions and races on [un]load.
> > 
> > Bill,
> >   Several people (IIRC including Alan Cox) would like to make many of the
> > modules (network cards and scsi drivers for example) mandatory, requiring
> > use of an initrd (or it's replacement) on all boot setups.
> 
> As far as I know, they plan on doing things like 
> disk partition detection outside the kernel, i.e. in
> a userspace program.  That clearly require
> a initrd (or similiar) for anybody with root
> on a partitioned disk.
> 
> Lots of other bootup initialization, like DHCP,
> might move to userspace as well.  This gives a smaller
> and safer kernel.

Why *safer*? Partition (,DHCP,..) code is ran once at boot. It is hard for
it to harm security.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

