Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314365AbSDROti>; Thu, 18 Apr 2002 10:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314368AbSDROth>; Thu, 18 Apr 2002 10:49:37 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:41095 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S314365AbSDROtg>; Thu, 18 Apr 2002 10:49:36 -0400
Date: Thu, 18 Apr 2002 08:49:21 -0600
Message-Id: <200204181449.g3IEnLE12555@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Andreas Dilger <adilger@clusterfs.com>,
        linux-kernel@vger.kernel.org
Subject: Re: RAID superblock confusion
In-Reply-To: <15550.11818.429509.22486@notabene.cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown writes:
> On Wednesday April 17, mfedyk@matchmail.com wrote:
> > On Thu, Apr 18, 2002 at 11:54:13AM +1000, Neil Brown wrote:
> > > On Saturday April 13, rgooch@ras.ucalgary.ca wrote:
> > > > If there was only a "do as I say, regardless" mode, I would be happy.
> > > > This programmer-knows-best attitude smacks of M$.
> > > 
> > > mdadm will do as you say, reguardless - if you ask it to.  Have you
> > > tried mdadm?
> > >    http://www.cse.unsw.edu.au/~neilb/source/mdadm/
> > 
> > Niel, do you plan to merge mdadm into the raidtools package?  It sounds like
> > it belongs there.
> 
> No.
> If distributions want to distribute mdadm together with the stuff from
> raidtools, then that is up to them.
> But from a development perspective, I don't see any value in making a
> single source distribution.

But from a user perspective, it's a pain the in ass to have to
download yet another package to do what raidtools do, just do it
properly. And having multiple packages doing nearly the same thing is
really confusing. Users won't know which one to pick.

<rant>
Every wanker out there wants to write their own cool tool, and since
sound and graphics are both l33t, why not do both at once? The result
is that we have (to name one example) a plethora of audio mixer
control tools.
Since I'm not in the "in crowd", and I just want a tool that lets me
frob the mixer, I wasted lots of time downloading many different
tools, reading the README's and compiling ones that didn't depend on
some bloated library (glibc, KDE or Gnome). Then waste more time
finding out which ones actually worked properly.
If resources were pooled, rather than all this ego stroking, we might
have something that (most importantly) works, is lightweight and is
usable for everyone, not just the users of the One True Desktop[R].
</rant>

Please let's just have one set of MD utilities.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
