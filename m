Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281735AbRLBSDQ>; Sun, 2 Dec 2001 13:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284265AbRLBSDG>; Sun, 2 Dec 2001 13:03:06 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:62398 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281678AbRLBSCw>; Sun, 2 Dec 2001 13:02:52 -0500
Date: Sun, 2 Dec 2001 11:02:44 -0700
Message-Id: <200112021802.fB2I2iE10476@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: viro@math.psu.edu (Alexander Viro),
        pierre.rousselet@wanadoo.fr (Pierre Rousselet),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        kaos@ocs.com.au (Keith Owens), linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre5 not easy to boot with devfs
In-Reply-To: <E16AaCR-0003wy-00@the-village.bc.nu>
In-Reply-To: <Pine.GSO.4.21.0112021150310.12801-100000@binet.math.psu.edu>
	<E16AaCR-0003wy-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > > Here is the final (i hope) verdict of my devfs testbox :
> > > 
> > > 2.4.16 with devfsd-1.3.18/1.3.20 : OK
> > > 2.4.17-pre1         "            : Broken
> > > 2.5.1-pre1          "            : OK
> 
> Sounds like the new devfs code should be backed out of 2.4 until
> fixed in 2.5

Hey! It's a pre-patch. There's time before 2.4.17-rc is released.
Having it in a pre-patch is the only way to get decent testing,
unfortunately. Not enough people bother downloading extra patches.
All known issues were resolved before the merge.

And 2.5 isn't going to get a lot of testing until the breakage caused
by the bio changes is fixed. At the moment, I can't even test it
myself.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
