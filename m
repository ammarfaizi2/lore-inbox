Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262120AbREPXEW>; Wed, 16 May 2001 19:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262122AbREPXEM>; Wed, 16 May 2001 19:04:12 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:22688 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262120AbREPXD6>; Wed, 16 May 2001 19:03:58 -0400
Date: Wed, 16 May 2001 17:03:49 -0600
Message-Id: <200105162303.f4GN3n212178@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <3B02FBA6.86969BDE@transmeta.com>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
> Ingo Oeser wrote:
> > 
> > We do this already with ide-scsi. A device is visible as /dev/hda
> > and /dev/sda at the same time. Or think IDE-CDRW: /dev/hda,
> > /dev/sr0 and /dev/sg0.
> > 
> > All at the same time.
> > 
> 
> ... and if you don't know about this funny aliasing, you get screwed. 
> This is BAD DESIGN, once again.

We have this aliasing anyway. sg and sr are just one example. If you
care about conflicts, then make sure the drivers lock each other out.
It's got nothing to do with the mechanism to find out whether
something can behave like a CD-ROM or not.

> > Sorry, I don't see your point here :-(
> 
> That seems to be a common theme with you.

C'mon, Peter. No need for that.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
