Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315267AbSGYPGN>; Thu, 25 Jul 2002 11:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315370AbSGYPGM>; Thu, 25 Jul 2002 11:06:12 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:40392 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S315267AbSGYPGM>;
	Thu, 25 Jul 2002 11:06:12 -0400
Date: Thu, 25 Jul 2002 17:08:50 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Brad Hards <bhards@bigpond.net.au>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       linuxconsole-dev@lists.sourceforge.net
Subject: Re: [cset] Add the EVIOCSABS ioctl for X people.
Message-ID: <20020725170850.A24176@ucw.cz>
References: <20020725083716.A20717@ucw.cz> <20020725161132.A22767@ucw.cz> <20020725163816.A23988@ucw.cz> <200207260047.20953.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200207260047.20953.bhards@bigpond.net.au>; from bhards@bigpond.net.au on Fri, Jul 26, 2002 at 12:47:20AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 12:47:20AM +1000, Brad Hards wrote:

> > ChangeSet@1.448, 2002-07-25 16:36:05+02:00, vojtech@twilight.ucw.cz
> >   Add EVIOCSABS() ioctl to change the abs* informative
> >   values on input devices. This is something the X peoople
> >   really wanted.

> Grr. I was just working on modifying this ioctl() to return
> something better than int[5], which is pretty ugly.
> 
> How about something along these lines (I have the rest of it - its
> just trivial changes to evdev.c)?

No problem. Send me a patch that does it for both the EVIOSGABS and
EVIOCSABS and I'll take it. You can either just do it in evdev.c, or
change every driver to use the struct.

> I could live with curr, min and max instead of *_value, but it
> would be nicer if it was a bit more descriptive.

You can make it current, minimum, and maximum, if you wish.  I'm a
minimalist when it comes to naming, and I don't really think "_value" is
bringing much information here. All of them are values after all.

-- 
Vojtech Pavlik
SuSE Labs
