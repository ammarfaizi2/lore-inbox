Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265682AbSJSVw2>; Sat, 19 Oct 2002 17:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265684AbSJSVw2>; Sat, 19 Oct 2002 17:52:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28946 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265682AbSJSVw2>; Sat, 19 Oct 2002 17:52:28 -0400
Date: Sat, 19 Oct 2002 23:58:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nicolas Pitre <nico@cam.org>
Cc: Greg KH <greg@kroah.com>, pavel@bug.ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: Zaurus support for usbnet.c
Message-ID: <20021019215829.GB28445@atrey.karlin.mff.cuni.cz>
References: <20021019041047.GG12716@kroah.com> <Pine.LNX.4.44.0210191149290.5873-100000@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210191149290.5873-100000@xanadu.home>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Doesn't the usbdnet.c driver support the Zaurus?
> > > 
> > > Both the Zaurus and the iPAQ are using a SA1110 which is already supported 
> > > by usbnet.
> > 
> > Yes, but that's on the client side of USB, right?  Pavel's patch is for
> > the host side, which I think was supported by usbdnet for the Zaurus.
> 
> If both clients i.e. the iPAQ and the Zaurus are actually a SA1110, and if 
> the iPAQ is already supported on both sides, then the Zaurus should work out 
> of the box.

No.

You'd be right if you ran iPAQ's rom on zaurus. But sharp's rom uses
diferent protocol, so this is still needed. Reflashing zaurus is
possibility, but not everyone does that, (cf card needed), and if you
reflash to change protocol (noone does that) your zaurus will be
incompatible with every other zaurus. 

									Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
