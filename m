Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130272AbQK1Ejt>; Mon, 27 Nov 2000 23:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130337AbQK1Eji>; Mon, 27 Nov 2000 23:39:38 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:25104 "EHLO
        thalia.fm.intel.com") by vger.kernel.org with ESMTP
        id <S130272AbQK1Ej2>; Mon, 27 Nov 2000 23:39:28 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDD86@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Albert D. Cahalan'" <acahalan@cs.uml.edu>, hpa@zytor.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: KERNEL BUG: console not working in linux
Date: Mon, 27 Nov 2000 20:09:10 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
        charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been taking some holidays and haven't followed
all of this thread closely, but:

> From: Albert D. Cahalan [mailto:acahalan@cs.uml.edu]
> 
> H. Peter Anvin writes:
> > [Albert Cahalan]
> >> [Alan Cox]
> 
> >>>> 1) Why did they disable my videocard ?
> >>>
> >>> Because your machine is not properly PC compatible
> >>
> >> The same can be said of systems that don't support the
> >> standard keyboard controller for A20 control.

Just curious: Are you (Alan?) saying this ("standard") based on the
unpublished IBM PC specs (well, it was when I needed it around
1990; don't know about now ???).  Or do you have a copy
of it?  They were mighty hard to come by, and I was working
on a contract for IBM at the time (not at Intel).

> > Yes, it can.  Unfortunately, some "legacy-free" PCs apparently
> > are starting to take the tack that the KBC is legacy.  Therefore,
> > the use of port 92h is mandatory on those systems.
> 
> Not just embedded systems?

Right.  Not just embedded systems.

> > Port 92h dates back to at the very least the IBM PS/2.
> > 
> > Either way, the video card of the original poster is broken in more
> > ways than that.  Ports 0x00-0xFF are reserved for the motherboard
> > chipset and have been since the original IBM PC.
> 
> His video card is the motherboard. He has built-in video.
> So the port is being used by his motherboard chipset.
> -

~Randy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
