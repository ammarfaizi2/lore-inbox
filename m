Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135494AbRD3QSR>; Mon, 30 Apr 2001 12:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135498AbRD3QSH>; Mon, 30 Apr 2001 12:18:07 -0400
Received: from mail1.bna.bellsouth.net ([205.152.150.13]:18847 "EHLO
	mail1.bna.bellsouth.net") by vger.kernel.org with ESMTP
	id <S135494AbRD3QRx>; Mon, 30 Apr 2001 12:17:53 -0400
From: volodya@mindspring.com
Date: Mon, 30 Apr 2001 12:17:14 -0400 (EDT)
Reply-To: volodya@mindspring.com
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Anton Altaparmakov <aia21@cam.ac.uk>, John Stoffel <stoffel@casc.com>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.3.1, aka "I stick my neck out a mile..."
In-Reply-To: <20010430040304.A5839@thyrsus.com>
Message-ID: <Pine.LNX.4.20.0104301216300.901-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Apr 2001, Eric S. Raymond wrote:

> Anton Altaparmakov <aia21@cam.ac.uk>:
> > >I tried whitespace, but the default Tkinter font isn't fixed-width.  How
> > >do you do invisible text?
> > 
> > Text colour = background colour -> invisible
> 
> Well, duh.  Unfortunately, it doesn't seem to have occured to the dozen or
> so people who suggested this that:
> 
> (a) Background color can vary depending on how Tk's X resources are set, and
> 
> (b) Tk doesn't give me, AFAIK, any way to query either that background color
>     or those resources.

button .x
.x cget -background

                 Vladimir Dergachev


> 
> Fer cripes' sake.  If it were that easy I'd have *done* it already, people!
> 
> Anyway my attempts to set a foreground color on an inactive button widget 
> failed.  I don't know why.  Tk is full of weird little corners like that.
> 
> What I've done is just disabled inactive help buttons without trying to
> hack the text or color. That makes them all the same width, though the 
> legend "Help" does show up in gray on the inacive ones.
> -- 
> 		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
> 
> "The state calls its own violence `law', but that of the individual `crime'"
> 	-- Max Stirner
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

