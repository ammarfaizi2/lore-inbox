Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261598AbREOVmi>; Tue, 15 May 2001 17:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261599AbREOVm2>; Tue, 15 May 2001 17:42:28 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:29340 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S261598AbREOVmS>; Tue, 15 May 2001 17:42:18 -0400
Date: Tue, 15 May 2001 15:41:41 -0600
Message-Id: <200105152141.f4FLff300686@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        torvalds@transmeta.com (Linus Torvalds),
        neilb@cse.unsw.edu.au (Neil Brown),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E14zl9b-0002x9-00@the-village.bc.nu>
In-Reply-To: <200105151931.f4FJVL830847@vindaloo.ras.ucalgary.ca>
	<E14zl9b-0002x9-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > 	len = readlink ("/proc/self/3", buffer, buflen);
> > 	if (strcmp (buffer + len - 2, "cd") != 0) {
> > 		fprintf (stderr, "Not a CD-ROM! Bugger off.\n");
> > 		exit (1);
> 
> And on my box cd is the cabbage dicer whoops

Actually, no, because it's guaranteed that a trailing "/cd" is a
CD-ROM. That's the standard.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
