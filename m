Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261811AbREPHXx>; Wed, 16 May 2001 03:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261807AbREPHXn>; Wed, 16 May 2001 03:23:43 -0400
Received: from hood.tvd.be ([195.162.196.21]:30709 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S261808AbREPHXc>;
	Wed, 16 May 2001 03:23:32 -0400
Date: Wed, 16 May 2001 09:21:43 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <200105152141.f4FLff300686@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.05.10105160921220.23225-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2001, Richard Gooch wrote:
> Alan Cox writes:
> > > 	len = readlink ("/proc/self/3", buffer, buflen);
> > > 	if (strcmp (buffer + len - 2, "cd") != 0) {
> > > 		fprintf (stderr, "Not a CD-ROM! Bugger off.\n");
> > > 		exit (1);
> > 
> > And on my box cd is the cabbage dicer whoops
> 
> Actually, no, because it's guaranteed that a trailing "/cd" is a
> CD-ROM. That's the standard.

Then  check for `/cd' at the end instead of `cd' :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

