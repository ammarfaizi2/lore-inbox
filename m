Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130024AbRADRoi>; Thu, 4 Jan 2001 12:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130281AbRADRo2>; Thu, 4 Jan 2001 12:44:28 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:19379 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S130024AbRADRoP>; Thu, 4 Jan 2001 12:44:15 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Daniel Phillips <phillips@innominate.de>
Cc: Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Date: Thu, 4 Jan 2001 09:43:48 -0800 (PST)
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
In-Reply-To: <3A544D1D.81AD9838@innominate.de>
Message-ID: <Pine.LNX.4.31.0101040942550.10387-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

for crying out loud, even windows tells the users they need to shutdown
first and gripes at them if they pull the plug. what users are you trying
to protect, ones to clueless to even run windows?

David Lang

 On Thu, 4 Jan 2001,
Daniel Phillips wrote:

> Date: Thu, 04 Jan 2001 11:14:53 +0100
> From: Daniel Phillips <phillips@innominate.de>
> To: Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
> Subject: Re: Journaling: Surviving or allowing unclean shutdown?
>
> Helge Hafting wrote:
> >
> > [...]
> > > > Being able to shut down by hitting the power switch is a little luxury
> > > > for which I've been willing to invest more than a year of my life to
> > > > attain.  Clueless newbies don't know why it should be any other way, and
> > > > it's essential for embedded devices.
> > >
> > > Clueless newbies (and slightly less clueless less newbie) type people
> > > don't think that they should HAVE to. My two interests are coping with
> > > particularly pedantic people who don't want there computer to hastle them
> > > about what they should or shouldn't do, and slightly embedded systems
> > > (e.g. set top box/web browsery thing that you want to be able to turn off
> > > like a TV but it should still be able to have a writeable disc for config
> > > and stuff you download/cache etc).
> >
> > Nothing wrong with a filesystem (or apps) that can handle being powered
> > down.
> > But I prefer to handle this kind of users with a power switch that
> > merely
> > acts as a "shutdown button"  instead of actually killing power.
> > The os will then run the equivalent of "shutdown -h now"
>
> And you give your customer clear instructions that they are not under
> any circumstances to unplug the device without turning it off first?
> And when they do it anyway you void their warranty?
>
> --
> Daniel
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
