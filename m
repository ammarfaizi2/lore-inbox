Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268067AbRHJNoq>; Fri, 10 Aug 2001 09:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268071AbRHJNog>; Fri, 10 Aug 2001 09:44:36 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:59811 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S268067AbRHJNo2>; Fri, 10 Aug 2001 09:44:28 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200108101344.PAA12963@sunrise.pg.gda.pl>
Subject: Re: Linux 2.4.7-ac10
To: scott1021@mediaone.net
Date: Fri, 10 Aug 2001 15:44:12 +0200 (MET DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108100740050.10858-100000@tweety.localdomain> from "Scott M. Hoffman" at Aug 10, 2001 07:43:57 AM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Scott M. Hoffman wrote:"
> On Fri, 10 Aug 2001 at 07:41 +0200 Andrzej Krzysztofowicz wrote:
> 
> > >
> > > On Fri, 10 Aug 2001 at 00:35 +0100 Alan Cox wrote:
> > >
> > > > > > o Merge DRM for XFree 4.1.x (XFree86 and others)
> > > > > Can I still use my RH7.1 box with X-4.0.3 and ATI DRI?
> > > >
> > > > The -ac tree lets you build either 4.0 or 4.1 DRM - its a config option -
> > > > pick 4.0
> > > > -
> > >
> > >  I'm confused?  I'm unable to select the 4.1 option without first
> > > selecting the original DRM option.  Does selecting the 4.1 DRM turn off
> > > the 4.0 code?  Or is this why glxinfo segfaults for me now?
> >
> > Try the patch I've just send with subject "[PATCH] double DRM - fixes"
> >
> > Andrzej
> >
> 
> Okay,
>   So from /usr/src/linux I did 'patch -p1 < /yourpatch' , which did not
> have any errors, but there is still only one way to get the DRM 4.1 option in
> menuconfig (by first selecting the older DRM option).

No, this is not option for "older" DRM but for DRM at all.
The second option is a switch: whether you want new or old DRM driver.

>   Linus' pre8 patch fixes it, but then I was unable to get the ext3 patch
> to apply cleanly, so I'd rather not go that route until there's another
> ext3 patch.

It seems to me it does not contain the old DRM at all.


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
