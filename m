Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132457AbRADKSI>; Thu, 4 Jan 2001 05:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132487AbRADKR6>; Thu, 4 Jan 2001 05:17:58 -0500
Received: from hermes.mixx.net ([212.84.196.2]:2571 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S132457AbRADKRq>;
	Thu, 4 Jan 2001 05:17:46 -0500
Message-ID: <3A544D1D.81AD9838@innominate.de>
Date: Thu, 04 Jan 2001 11:14:53 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-prerelease i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
In-Reply-To: <Pine.LNX.4.30.0101031847120.11227-100000@springhead.px.uk.com> <3A544925.B9BF4241@idb.hist.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> 
> [...]
> > > Being able to shut down by hitting the power switch is a little luxury
> > > for which I've been willing to invest more than a year of my life to
> > > attain.  Clueless newbies don't know why it should be any other way, and
> > > it's essential for embedded devices.
> >
> > Clueless newbies (and slightly less clueless less newbie) type people
> > don't think that they should HAVE to. My two interests are coping with
> > particularly pedantic people who don't want there computer to hastle them
> > about what they should or shouldn't do, and slightly embedded systems
> > (e.g. set top box/web browsery thing that you want to be able to turn off
> > like a TV but it should still be able to have a writeable disc for config
> > and stuff you download/cache etc).
> 
> Nothing wrong with a filesystem (or apps) that can handle being powered
> down.
> But I prefer to handle this kind of users with a power switch that
> merely
> acts as a "shutdown button"  instead of actually killing power.
> The os will then run the equivalent of "shutdown -h now"

And you give your customer clear instructions that they are not under
any circumstances to unplug the device without turning it off first? 
And when they do it anyway you void their warranty?

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
