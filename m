Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281532AbRKMF5s>; Tue, 13 Nov 2001 00:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281530AbRKMF5i>; Tue, 13 Nov 2001 00:57:38 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:58249 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281504AbRKMF51>; Tue, 13 Nov 2001 00:57:27 -0500
Date: Mon, 12 Nov 2001 22:56:49 -0700
Message-Id: <200111130556.fAD5unp19024@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: andersen@codepoet.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GPLONLY kernel symbols???
In-Reply-To: <20011112224412.A6606@codepoet.org>
In-Reply-To: <200111130324.fAD3OE916102@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0111122249160.22925-100000@weyl.math.psu.edu>
	<200111130358.fAD3wgb16617@vindaloo.ras.ucalgary.ca>
	<3BF09E44.58D138A6@mandrakesoft.com>
	<200111130437.fAD4b2j17329@vindaloo.ras.ucalgary.ca>
	<3BF0A788.8CCBC91@mandrakesoft.com>
	<200111130500.fAD50Wi17879@vindaloo.ras.ucalgary.ca>
	<3BF0AC47.221B6CD6@mandrakesoft.com>
	<200111130523.fAD5NRK18457@vindaloo.ras.ucalgary.ca>
	<20011112224412.A6606@codepoet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen writes:
> On Mon Nov 12, 2001 at 10:23:27PM -0700, Richard Gooch wrote:
> > 
> > A few days ago I was thinking about this, and I thought how cool it
> > would be to have a reliable utility that could convert between the two
> > coding styles. If I had that (and it was bulletproof) then it could be
> > used with some kind of userfs to give me two views of the kernel: the
> > underlying one "raw" one, to which I'd apply patches and generate them
> > from, and a "sanitised" one, that I would read and edit.
> 
> If you look in scripts/Lindent you will see it calls:
>     indent -kr -i8 -ts8 -sob -l80 -ss -bs -psl
> 
> The GNU indent utility has tons of options to accomodate every
> sort of perverse coding style.  I imagine some time with the
> indent man page will produce a working solution for you in short
> order,

I'll look at this. Later. Right now I'm focussing on getting the new
devfs core up to snuff.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
