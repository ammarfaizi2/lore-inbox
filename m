Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWFBGT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWFBGT5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 02:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWFBGT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 02:19:57 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:53938 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751199AbWFBGT4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 02:19:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pV5Nx3hPXpsy8+CPLxzKcTMzrD+VbX+a5TNymJ9yBKfX9b4XJaYpceOS9L9JwykFvnrCYyM8uz+QqrEqUGRNlekwrtGsjLvL6CxWuYB8ajhAvhfN5vUCimFFdGkp+lL+1EJKzLEw/bIbyOjrxNKrS/FdOppy0ljKAfXff7mGnY4=
Message-ID: <21d7e9970606012319s292759bbm6c046f09d6bf5826@mail.gmail.com>
Date: Fri, 2 Jun 2006 16:19:55 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "=?ISO-8859-1?Q?Ville_Syrj=E4l=E4?=" <syrjala@sci.fi>
Subject: Re: OpenGL-based framebuffer concepts
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <pan.2006.06.02.04.34.36.227639@sci.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605302314.25957.dhazelton@enter.net>
	 <9e4733910605302116s5a47f5a3kf0f941980ff17e8@mail.gmail.com>
	 <200605310026.01610.dhazelton@enter.net>
	 <9e4733910605302139t4f10766ap86f78e50ee62f102@mail.gmail.com>
	 <20060601092807.GA7111@localhost.localdomain>
	 <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com>
	 <21d7e9970606011815y226ebb86ob42ec0421072cf07@mail.gmail.com>
	 <pan.2006.06.02.04.34.36.227639@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> Without specifying a design here are a few requirements I would have:
> >>
> >> 1) The kernel subsystem should be agnostic of the display server. The
> >> solution should not be X specific. Any display system should be able
> >> to use it, SDL, Y Windows, Fresco, etc...
> >
> > of course, but that doesn't mean it can't re-use X's code, they are
> > the best drivers we have. you forget everytime that the kernel fbdev
> > drivers aren't even close, I mean not by a long long way apart from
> > maybe radeon.
>
> matroxfb is clearly better than the X driver. atyfb too IMO.

Okay maybe matroxfb, but if atyfb is the mach64, it really isn't as
good, the last few times I tried it, it just made my LCD bloom, X
worked, mach64 is probably the most complex thing as there must be at
least 15 variations on the theme.... mach64 isn't a chip family so
much as a chip tribe... I've since burned my mach64 as a sacrifice....

Dave.
>
> --
> Ville Syrjälä
> syrjala@sci.fi
> http://www.sci.fi/~syrjala/
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
