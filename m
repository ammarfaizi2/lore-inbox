Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129092AbRBDQTv>; Sun, 4 Feb 2001 11:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131892AbRBDQTk>; Sun, 4 Feb 2001 11:19:40 -0500
Received: from [203.169.151.222] ([203.169.151.222]:32781 "EHLO
	main.coppice.org") by vger.kernel.org with ESMTP id <S129092AbRBDQT2>;
	Sun, 4 Feb 2001 11:19:28 -0500
Message-ID: <3A7D8116.CA16340B@coppice.org>
Date: Mon, 05 Feb 2001 00:19:34 +0800
From: Steve Underwood <steveu@coppice.org>
Organization: Me? Organised?
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en, zh-TW
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Better battery info/status files
In-Reply-To: <Pine.SOL.4.21.0102041540300.14562-100000@green.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Sutherland wrote:
> 
> On Sun, 4 Feb 2001, Ben Ford wrote:
> 
> > David Woodhouse wrote:
> >
> > > On Sun, 4 Feb 2001, James Sutherland wrote:
> > >
> > > > For the end-user, the ability to see readings in other units would be
> > > > useful - how many people on this list work in litres/metres/kilometres,
> > > > and how many in gallons/feet/miles? Probably enough in both groups that
> > > > neither could count as universal...
> > >
> > > Yeah. We can have this as part of the locale settings, changable by
> > > echoing the desired locale string to /proc/sys/kernel/lc_all.
> > >
> > > -
> >
> > Just an idea, . .  but isn't this something better done in userland?
> >
> > (ben@Deacon)-(06:49am Sun Feb  4)-(ben)
> > $ date  +%s
> > 981298161
> > (ben@Deacon)-(06:49am Sun Feb  4)-(ben)
> > $ date  +%c
> > Sun Feb  4 06:49:24 2001
> 
> That's what I'd do, anyway - /dev/pieceofstring would return the length of
> said piece of string in some units, explicityly stated. (e.g. "5m" or
> "15ft").
> 
> "uname -s" ("how long's a piece of string on this system") would then
> convert the length into feet, metres or fathoms, depending on what the
> user prefers.
> 
> James.

Don't get carried away. In the present context we are only talking about
time and electrical measurements. Whilst most of the human race can't
read the English labels in /proc, they all use the same measurements for
electrical units and time (unless the time exceeds 24 hours, where dates
get a bit screwed up). In this case even the US in in line with the rest
of humanity............. or would you like to be able to express battery
capacity in BTUs?

Regards,
Steve
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
