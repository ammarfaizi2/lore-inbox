Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267643AbRHJMol>; Fri, 10 Aug 2001 08:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267651AbRHJMob>; Fri, 10 Aug 2001 08:44:31 -0400
Received: from nic-163-c160-146.mn.mediaone.net ([24.163.160.146]:1416 "EHLO
	tweety.localdomain") by vger.kernel.org with ESMTP
	id <S267643AbRHJMoO>; Fri, 10 Aug 2001 08:44:14 -0400
Date: Fri, 10 Aug 2001 07:43:57 -0500 (CDT)
From: "Scott M. Hoffman" <scott1021@mediaone.net>
X-X-Sender: <scott@tweety.localdomain>
Reply-To: <scott1021@mediaone.net>
To: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.7-ac10
In-Reply-To: <200108100541.HAA00896@kufel.dom>
Message-ID: <Pine.LNX.4.33.0108100740050.10858-100000@tweety.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2001 at 07:41 +0200 Andrzej Krzysztofowicz wrote:

> >
> > On Fri, 10 Aug 2001 at 00:35 +0100 Alan Cox wrote:
> >
> > > > > o Merge DRM for XFree 4.1.x (XFree86 and others)
> > > > Can I still use my RH7.1 box with X-4.0.3 and ATI DRI?
> > >
> > > The -ac tree lets you build either 4.0 or 4.1 DRM - its a config option -
> > > pick 4.0
> > > -
> >
> >  I'm confused?  I'm unable to select the 4.1 option without first
> > selecting the original DRM option.  Does selecting the 4.1 DRM turn off
> > the 4.0 code?  Or is this why glxinfo segfaults for me now?
>
> Try the patch I've just send with subject "[PATCH] double DRM - fixes"
>
> Andrzej
>

Okay,
  So from /usr/src/linux I did 'patch -p1 < /yourpatch' , which did not
have any errors, but there is still only one way to get the DRM 4.1 option in
menuconfig (by first selecting the older DRM option).
  Linus' pre8 patch fixes it, but then I was unable to get the ext3 patch
to apply cleanly, so I'd rather not go that route until there's another
ext3 patch.


Thanks,
Scott Hoffman


