Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132204AbRADJ7C>; Thu, 4 Jan 2001 04:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132295AbRADJ6w>; Thu, 4 Jan 2001 04:58:52 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:6159 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S132204AbRADJ6g>; Thu, 4 Jan 2001 04:58:36 -0500
Message-ID: <3A544925.B9BF4241@idb.hist.no>
Date: Thu, 04 Jan 2001 10:57:57 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test13-pre3 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
In-Reply-To: <Pine.LNX.4.30.0101031847120.11227-100000@springhead.px.uk.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
> > Being able to shut down by hitting the power switch is a little luxury
> > for which I've been willing to invest more than a year of my life to
> > attain.  Clueless newbies don't know why it should be any other way, and
> > it's essential for embedded devices.
> 
> Clueless newbies (and slightly less clueless less newbie) type people
> don't think that they should HAVE to. My two interests are coping with
> particularly pedantic people who don't want there computer to hastle them
> about what they should or shouldn't do, and slightly embedded systems
> (e.g. set top box/web browsery thing that you want to be able to turn off
> like a TV but it should still be able to have a writeable disc for config
> and stuff you download/cache etc).

Nothing wrong with a filesystem (or apps) that can handle being powered
down.
But I prefer to handle this kind of users with a power switch that
merely
acts as a "shutdown button"  instead of actually killing power.
The os will then run the equivalent of "shutdown -h now" 
You may not have this luxury on an ordinary pc, but you do if you design
embedded
devices.  You will then be free to use existing GPL software that
not necessarily handle a power failure well.

Helge Hafting
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
