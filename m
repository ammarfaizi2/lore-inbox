Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288773AbSAELkn>; Sat, 5 Jan 2002 06:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288775AbSAELkd>; Sat, 5 Jan 2002 06:40:33 -0500
Received: from unicef.org.yu ([194.247.200.148]:28435 "EHLO unicef.org.yu")
	by vger.kernel.org with ESMTP id <S288773AbSAELkU>;
	Sat, 5 Jan 2002 06:40:20 -0500
Date: Sat, 5 Jan 2002 12:40:15 +0100 (CET)
From: Davidovac Zoran <zdavid@unicef.org.yu>
To: "Gabor Z. Papp" <gzp@myhost.mynet>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: X and console paralell
In-Reply-To: <20020105080009.GI22314@gzp2.gzp>
Message-ID: <Pine.LNX.4.33.0201051223590.4256-100000@unicef.org.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 5 Jan 2002, Gabor Z. Papp wrote:

> * Mark Vojkovich <mvojkovich@nvidia.com>:
>
> | > Plugging extra USB keyboard and mouse would solve the
> | > problem, and I would be able to run X and console
> | > simultanously?
> |
> |    No, both the console and X need a VT.  As far as I can tell
> | Linux only lets you have one VT active at any time.  You can
> | have a different mouse and keyboard used by the console and
> | by X (in theory at least), but I don't think that solves the
> | mutual exclusivity of VTs.
> |
> |    Some people may have kernel hacks to allow this sort of
> | thing, but I haven't been keeping track of this stuff.  It's
> | not an area that I've been involved in.
>
> Any idea? Basically I would like to run 2 monitor, one for X
> and one for console paralell, with 1 keyboard/mouse.
> Switching between them like with one monitor, but when no
> work on the one, I would like to keep the signal on the
> unused monitor, eg I would like to see the (not blank) screen.


That's partly true.
In old P1 PC I have SVGA and Hercules card with Xfree 3.3.6
svga on tty1-tty10
hercules on tty12-tty22

you can have two consoles simultanious and are working,
you also can have for example top on hercules and
be in X's at the same time, but when you go to active console
on hercules you lose X on svga.
The best what can be done you can have X on hercules
and X on svga, but is totally unuseable.

With Xfree 4 none of this is not useable :(
you can have two consoles like top on hercules and working on swga
but if you "turn X on" you can have top on hercules
but when you go to X you got blank screen on hercules.

It is X fault (works with Xfree 3.3.6- but not with 4+)


probably the best solution is VT terminal atached to
serial or usb on serial convertor.
or cheap 386+ on lan :(

regards,

Zoran

