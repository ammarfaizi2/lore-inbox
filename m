Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131985AbRBDPug>; Sun, 4 Feb 2001 10:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131987AbRBDPu0>; Sun, 4 Feb 2001 10:50:26 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:14721 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131985AbRBDPuL>; Sun, 4 Feb 2001 10:50:11 -0500
Date: Sun, 4 Feb 2001 15:42:26 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Ben Ford <ben@kalifornia.com>
cc: David Woodhouse <dwmw2@infradead.org>, Russell King <rmk@arm.linux.org.uk>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Pavel Machek <pavel@suse.cz>, andrew.grover@intel.com,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Better battery info/status files
In-Reply-To: <3A7D6C66.749318E1@kalifornia.com>
Message-ID: <Pine.SOL.4.21.0102041540300.14562-100000@green.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Feb 2001, Ben Ford wrote:

> David Woodhouse wrote:
> 
> > On Sun, 4 Feb 2001, James Sutherland wrote:
> >
> > > For the end-user, the ability to see readings in other units would be
> > > useful - how many people on this list work in litres/metres/kilometres,
> > > and how many in gallons/feet/miles? Probably enough in both groups that
> > > neither could count as universal...
> >
> > Yeah. We can have this as part of the locale settings, changable by
> > echoing the desired locale string to /proc/sys/kernel/lc_all.
> >
> > -
> 
> Just an idea, . .  but isn't this something better done in userland?
> 
> (ben@Deacon)-(06:49am Sun Feb  4)-(ben)
> $ date  +%s
> 981298161
> (ben@Deacon)-(06:49am Sun Feb  4)-(ben)
> $ date  +%c
> Sun Feb  4 06:49:24 2001

That's what I'd do, anyway - /dev/pieceofstring would return the length of
said piece of string in some units, explicityly stated. (e.g. "5m" or
"15ft").

"uname -s" ("how long's a piece of string on this system") would then
convert the length into feet, metres or fathoms, depending on what the
user prefers.


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
