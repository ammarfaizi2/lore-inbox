Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131631AbRCSW3i>; Mon, 19 Mar 2001 17:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131636AbRCSW3S>; Mon, 19 Mar 2001 17:29:18 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:47156 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S131631AbRCSW3P>; Mon, 19 Mar 2001 17:29:15 -0500
Message-Id: <4.3.2.7.2.20010319142441.00b2e9f0@mail.fluent-access.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 19 Mar 2001 14:28:15 -0800
To: Torrey Hoffman <torrey.hoffman@myrio.com>,
        "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>,
        linux-kernel@vger.kernel.org
From: Stephen Satchell <satch@fluent-access.com>
Subject: RE: Linux should better cope with power failure
In-Reply-To: <B65FF72654C9F944A02CF9CC22034CE22E1B40@mail0.myrio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:16 PM 3/19/01 -0800, Torrey Hoffman wrote:
>Yes.  Some of this is your responsibility.  You have several options:
>1. Get a UPS.  That would not have helped your particular problem,
>    but it's a good idea if you care about data integrity.
>2. Use a journaling file system.  These are much more tolerant of
>    abuse.  Reiserfs seems to work for me on embedded systems I am
>    building where the user can (and does) remove the power any time.
>3. Use RAID.  Hard drives are very cheap and software raid is very
>    easy to set up.

Sorry, but you really should have read the ENTIRE thread before 
commenting.  This guy's original complaint was that his USB keyboard locks 
up, and the only way to get it back is to do a very rude restart.  In 
combatting this problem, the guy was observing the "shortcomings" of the 
file system.

To be more to the point of the guy's problem, he should consider using 
software specifically intended for UPS hardware to notify a system when the 
power is going to go, and wire up an appropriate switch to signal his 
system to enter shutdown when his keyboard goes south.  By forcing an 
orderly shutdown, he doesn't see the fsck-ing messages, he gets his USB 
keyboard back, and all is well with the world.

Of course, the other option is to use a regular keyboard instead of a USB 
keyboard, but why point out the really easy solution?  "Hey Doc, it hurts 
when I do this."  "Then don't do it."

Satch

