Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262151AbREPX7M>; Wed, 16 May 2001 19:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262160AbREPX7C>; Wed, 16 May 2001 19:59:02 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:42144 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262151AbREPX66>; Wed, 16 May 2001 19:58:58 -0400
Date: Wed, 16 May 2001 17:58:47 -0600
Message-Id: <200105162358.f4GNwll13400@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: rgooch@ras.ucalgary.ca (Richard Gooch),
        geert@linux-m68k.org (Geert Uytterhoeven),
        ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        torvalds@transmeta.com (Linus Torvalds),
        neilb@cse.unsw.edu.au (Neil Brown),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E150B5B-0004fs-00@the-village.bc.nu>
In-Reply-To: <200105161822.f4GIMo509185@vindaloo.ras.ucalgary.ca>
	<E150B5B-0004fs-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > Argh! What I wrote in text is what I meant to say. The code didn't
> > match. No wonder people seemed to be missing the point. So the line of
> > code I actually meant was:
> > 	if (strcmp (buffer + len - 3, "/cd") != 0) {
> 
> drivers/kitchen/bluetooth/vegerack/cd
> 
> its the cabbage dicer still ..

No, because it violates the standard. Just as we can define a major
number to have a specific meaning, we can define a name in the devfs
namespace to have a specific meaning.

Yes, it's broken if someone writes a cabbage dicer driver and uses
"cd" as the leaf node name for devfs.

Yes, it's broken if someone writes a cabbage dicer driver and uses
the same major as the IDE CD-ROM or SCSI CD-ROM drivers.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
