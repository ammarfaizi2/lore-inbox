Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262154AbREPXtw>; Wed, 16 May 2001 19:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262153AbREPXtm>; Wed, 16 May 2001 19:49:42 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:38816 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262148AbREPXtc>; Wed, 16 May 2001 19:49:32 -0400
Date: Wed, 16 May 2001 17:49:28 -0600
Message-Id: <200105162349.f4GNnSJ13049@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <3B0310A4.87138FB5@transmeta.com>
In-Reply-To: <200105152141.f4FLff300686@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.05.10105160921220.23225-100000@callisto.of.borg>
	<200105161822.f4GIMo509185@vindaloo.ras.ucalgary.ca>
	<3B02D6AB.E381D317@transmeta.com>
	<200105162001.f4GK18X10128@vindaloo.ras.ucalgary.ca>
	<3B02DD79.7B840A5B@transmeta.com>
	<200105162054.f4GKsaF10834@vindaloo.ras.ucalgary.ca>
	<3B02F2EC.F189923@transmeta.com>
	<20010517001155.H806@nightmaster.csn.tu-chemnitz.de>
	<3B02FBA6.86969BDE@transmeta.com>
	<200105162303.f4GN3n212178@vindaloo.ras.ucalgary.ca>
	<3B030C76.40BB4558@transmeta.com>
	<200105162337.f4GNb0j12743@vindaloo.ras.ucalgary.ca>
	<3B030F86.EDA45D1A@transmeta.com>
	<200105162341.f4GNfvT12861@vindaloo.ras.ucalgary.ca>
	<3B0310A4.87138FB5@transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc: list trimmed because I figure people are getting tired of us:-]
H. Peter Anvin writes:
> Richard Gooch wrote:
> > 
> > H. Peter Anvin writes:
> > > Richard Gooch wrote:
> > > >
> > > > Erm, let's start again. My central point is that you can use devfs
> > > > names to reliably figure out what kind of device a FD is, as a cleaner
> > > > alternative to comparing major numbers. Therefore, I'm challenging the
> > > > notion that you need to reserve magic major numbers in order to
> > > > distinguish devices.
> > >
> > > Noone in this tree has made that claim.  Everyone agree it's
> > > butt-ugly.  However, your solution is by and large just as
> > > butt-ugly.
> > 
> > So you'd prefer some kind of capability list?

OK. How do you figure on dealing with the problem of multiple
high-level drivers talking to the same device? How does sr.o "know"
that this is also a CD-RW? How does sg.o "know" that this is also a
tape?

Where does the responsibility lie for figuring out the capabilities?

Further, which device node/fs/driver exports the capability list?

And what about locking between drivers?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
