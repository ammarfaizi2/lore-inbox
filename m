Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282979AbRLIEs7>; Sat, 8 Dec 2001 23:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282990AbRLIEst>; Sat, 8 Dec 2001 23:48:49 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:19858 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S282979AbRLIEso>; Sat, 8 Dec 2001 23:48:44 -0500
Date: Sat, 8 Dec 2001 21:48:37 -0700
Message-Id: <200112090448.fB94mbP05763@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Rene Rebe <rene.rebe@gmx.net>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@lists.sourceforge.net>
Subject: Re: devfs unable to handle permission: 2.4.17-pre[4,5] 
 /ALSA-0.9.0beta[9,10]
In-Reply-To: <Pine.LNX.4.33.0112090447290.13049-100000@serv>
In-Reply-To: <200112090308.fB938N504764@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.33.0112090447290.13049-100000@serv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel writes:
> Hi,
> 
> On Sat, 8 Dec 2001, Richard Gooch wrote:
> 
> > > devfs_mk_dir returns an error now, so the driver won't be able to
> > > make new dev nodes available. So far it was legal to manually create
> > > a directory under devfs, now it's suddenly an error.
> >
> > It was always an error, you just got away with it.
> 
> Sorry, but this is bullshit. You even included an example script
> with this "error" (Documentation/filesystems/devfs/rc.devfs). You
> suddenly change the behaviour of devfs during a stable release in a
> noncompatible way.  Distributions and their users that followed
> _your_ advice are suddenly fucked up, that's irresponsible. How do
> you think devfs should be ever taken seriously?

Oh, the "tar kludge". That script has been obsolete for over a year
and a half. I should have removed it ages ago. I really should get
around to doing that one day.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
