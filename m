Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262080AbREPUTj>; Wed, 16 May 2001 16:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262079AbREPUTT>; Wed, 16 May 2001 16:19:19 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:54284 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262071AbREPUTO>; Wed, 16 May 2001 16:19:14 -0400
Date: Wed, 16 May 2001 13:18:31 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: "H. Peter Anvin" <hpa@transmeta.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <200105162001.f4GK18X10128@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.21.0105161316310.7695-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 May 2001, Richard Gooch wrote:
> > 
> > This is still a really bad idea.  You don't want to tie this kind of
> > things to the name.
> 
> Why do you think it's a bad idea?

Well, one reason names are bad is that they don't always exist.

If you only have the fd (remember that unix notion of using <stdin> and
<stdout>), you'd have no clue where the thing came from. So something else
than the name is certainly a good idea for some of these issues.

That said, I still think the real problem is rampant use of ioctl's, which
are a bad idea in the first place. Magic numbers are always bad, and are a
sign of bad design.

		Linus

