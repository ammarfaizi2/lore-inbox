Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131657AbRCSXHJ>; Mon, 19 Mar 2001 18:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131659AbRCSXHA>; Mon, 19 Mar 2001 18:07:00 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:14602
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131657AbRCSXGu>; Mon, 19 Mar 2001 18:06:50 -0500
Date: Mon, 19 Mar 2001 15:05:32 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Stephen Satchell <satch@fluent-access.com>
cc: Torrey Hoffman <torrey.hoffman@myrio.com>,
        "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>,
        linux-kernel@vger.kernel.org
Subject: RE: Linux should better cope with power failure
In-Reply-To: <4.3.2.7.2.20010319142441.00b2e9f0@mail.fluent-access.com>
Message-ID: <Pine.LNX.4.10.10103191457270.24490-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Guy,

I wrote APCUPSD beginning back in 95/96 for this reason.
American Power Conversion is now friendly to Linux.

http://www.linux-ide.org/apcupsd.html

Cheers,

On Mon, 19 Mar 2001, Stephen Satchell wrote:

> At 01:16 PM 3/19/01 -0800, Torrey Hoffman wrote:
> >Yes.  Some of this is your responsibility.  You have several options:
> >1. Get a UPS.  That would not have helped your particular problem,
> >    but it's a good idea if you care about data integrity.
> >2. Use a journaling file system.  These are much more tolerant of
> >    abuse.  Reiserfs seems to work for me on embedded systems I am
> >    building where the user can (and does) remove the power any time.
> >3. Use RAID.  Hard drives are very cheap and software raid is very
> >    easy to set up.
> 
> Sorry, but you really should have read the ENTIRE thread before 
> commenting.  This guy's original complaint was that his USB keyboard locks 
> up, and the only way to get it back is to do a very rude restart.  In 
> combatting this problem, the guy was observing the "shortcomings" of the 
> file system.
> 
> To be more to the point of the guy's problem, he should consider using 
> software specifically intended for UPS hardware to notify a system when the 
> power is going to go, and wire up an appropriate switch to signal his 
> system to enter shutdown when his keyboard goes south.  By forcing an 
> orderly shutdown, he doesn't see the fsck-ing messages, he gets his USB 
> keyboard back, and all is well with the world.
> 
> Of course, the other option is to use a regular keyboard instead of a USB 
> keyboard, but why point out the really easy solution?  "Hey Doc, it hurts 
> when I do this."  "Then don't do it."
> 
> Satch
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

