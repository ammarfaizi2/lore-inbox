Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262087AbREPUpc>; Wed, 16 May 2001 16:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262089AbREPUpM>; Wed, 16 May 2001 16:45:12 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:928 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262087AbREPUpF>; Wed, 16 May 2001 16:45:05 -0400
Date: Wed, 16 May 2001 14:44:56 -0600
Message-Id: <200105162044.f4GKium10720@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "H. Peter Anvin" <hpa@transmeta.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.21.0105161316310.7695-100000@penguin.transmeta.com>
In-Reply-To: <200105162001.f4GK18X10128@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.21.0105161316310.7695-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> 
> On Wed, 16 May 2001, Richard Gooch wrote:
> > > 
> > > This is still a really bad idea.  You don't want to tie this kind of
> > > things to the name.
> > 
> > Why do you think it's a bad idea?
> 
> Well, one reason names are bad is that they don't always exist.
> 
> If you only have the fd (remember that unix notion of using <stdin>
> and <stdout>), you'd have no clue where the thing came from. So
> something else than the name is certainly a good idea for some of
> these issues.

But, as I described in my original message, you use /proc/self/fd to
find where the fd came from. Or are you saying that you can't rely on
having /proc available?

Or do you have other reasons not to like the scheme I described? One
of the reasons I like it is because it requires no new kernel code.

> That said, I still think the real problem is rampant use of ioctl's,
> which are a bad idea in the first place. Magic numbers are always
> bad, and are a sign of bad design.

No argument from me.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
