Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318925AbSG1IFH>; Sun, 28 Jul 2002 04:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318929AbSG1IFH>; Sun, 28 Jul 2002 04:05:07 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:12463 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318925AbSG1IFF>;
	Sun, 28 Jul 2002 04:05:05 -0400
Date: Sun, 28 Jul 2002 10:08:12 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Brad Hards <bhards@bigpond.net.au>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       linuxconsole-dev@lists.sourceforge.net
Subject: Re: [cset] Add the EVIOCSABS ioctl for X people.
Message-ID: <20020728100812.A12268@ucw.cz>
References: <20020725083716.A20717@ucw.cz> <200207260047.20953.bhards@bigpond.net.au> <20020725170850.A24176@ucw.cz> <200207281732.53842.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200207281732.53842.bhards@bigpond.net.au>; from bhards@bigpond.net.au on Sun, Jul 28, 2002 at 05:32:53PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 05:32:53PM +1000, Brad Hards wrote:

> On Fri, 26 Jul 2002 01:08, Vojtech Pavlik wrote:
> > On Fri, Jul 26, 2002 at 12:47:20AM +1000, Brad Hards wrote:
> > No problem. Send me a patch that does it for both the EVIOSGABS and
> > EVIOCSABS and I'll take it. You can either just do it in evdev.c, or
> > change every driver to use the struct.
> I am just doing the evdev.c (ie the ABI) at this stage. I may look at the
> internal representation later.
> Patch against 2.5.29. Looks OK?

Yes.

> > > I could live with curr, min and max instead of *_value, but it
> > > would be nicer if it was a bit more descriptive.
> >
> > You can make it current, minimum, and maximum, if you wish.  I'm a
> > minimalist when it comes to naming, and I don't really think "_value" is
> > bringing much information here. All of them are values after all.
> "current" is a bad idea. I used curr_value.

How about just "value" then?

> Also, it is nice if you can retain the attributions (so I can get some
> ego satisfaction, and so people know who to blame). This is generally
> done by maintainers - any chance you can do this too?

I'm stil fighting with BK to use something else than my e-mail address
in the changesets. So far I've always put the author of the patch into
the BK comment at least, but still haven't found how to change the cset
author.

If you find out, please tell me. Or anybody else.

Thanks.

-- 
Vojtech Pavlik
SuSE Labs
