Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVAGR0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVAGR0M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 12:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVAGR0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 12:26:11 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:41604 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261357AbVAGRZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 12:25:03 -0500
Message-ID: <41DEC5F1.9070205@comcast.net>
Date: Fri, 07 Jan 2005 12:25:05 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: znmeb@cesmail.net
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: starting with 2.7
References: <1697129508.20050102210332@dns.toxicfilms.tv>	 <41DD9968.7070004@comcast.net>	 <1105045853.17176.273.camel@localhost.localdomain> <1105115671.12371.38.camel@DreamGate>
In-Reply-To: <1105115671.12371.38.camel@DreamGate>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



M. Edward Borasky wrote:
| On Thu, 2005-01-06 at 21:29 +0000, Alan Cox wrote:
|
|>On Iau, 2005-01-06 at 20:02, John Richard Moser wrote:
|>
|>>experiments have no place in production; if your "stable" mainline
|>>branch is going to continuously add and remove features and go through
|>>wild API and functionality changes, nobody is going to want to use it.
|>>Mozilla doesn't support IE's broken crap "because IE is a moving
|>>target."  Unpredictable API changes and changes to the deep inner
|>
|>IE hasn't moved in years. The inventiveness of the bad web page authors
|>might be unbounded 8)
|>
|>
|>>workings of the kernel will make the kernel "a moving target."  If
|>>that's the route you take, it will become too difficult for people to
|>>develope for linux.
|>
|>Its also impossible to do development if none of the changes you make
|>get into the kernel for stability reasons ever. Its a double edged
|>sword. For most end users it is about distribution kernels not the base.
|
|
| There are two classes of "end users". There are true end users who get
| their Linux from a distributor, and there are the distributors. And
| there are two classes of distributors, for-profit and not-for-profit.
| Somehow the Linux kernel has managed to meet enough of the needs of
| enough of these folks that GNU/Linux is one of the top three desktop
| operating systems in the world. I'm not sure where it ranks among
| servers, but surely it's competitive with Windows on Intel-based
| servers, if not with the "native" UNIX derivatives on other hardware.
|

Uh.

Businesses, institutions like schools and libraries, home users, those
aren't the same.  They all have needs.

For example, a POS that flops and crashes every 5 hours is going to be
bad for a business; a home user can do it without losing billions of
dollars a year.

| I use Red Hat (mix of 8.0, 9.0 and RHEL) at work and Gentoo at home. I
| recently migrated all my home systems to Gentoo's version of 2.6.10, did
| the devfs-udev, oss-alsa, 2.4 headers-2.6 headers, and ntpl migration.
| As far as Gentoo is concerned, this is a stable, production
| environment.
|

Bull.  Shit.

Try /join #hardened-gentoo and ask about how stable 2.6 is once.  The
hardened team has been having a hard time because 2.6 keeps changing.

I was told that gentoo-dev-sources and hardened-dev-sources will become
gentoo-sources and hardened-sources when they're considered stable.
They're still -dev.  What does this tell you?

<@tseng> stable? sometimes
<@tseng> production, nope.

| I had a few glitches; it's not something I'd expect someone without
| extensive system programming experience to pull off, even with Gentoo's
| well-written HowTos. As far as *I'm* concerned, it is a stable
| production environment.

That's you.

| I would recommend it to my friends (knowing that
| I could bail them out if they messed it up :). I would recommend it to
| businesses (knowing that I could earn big bucks to bail them out when
| they messed it up. :).
|

I wouldn't recommend it to businesses, because a fuck-up means they lose
money.  You ever see a production server go down?  You can totally wipe
out a business that way.  If a glitch trashes the filesystem, you might
as well stop trying.  Unless of course you can ship your off-site
backups back on-site and restore the whole damn thing to working order
within 3 days.  Better hope the kernel you were using when it was
working is in the backups.

| Given all that, what about 2.6 and 2.7? Here's where I break away from
| the mainstream -- big-time. I'd like to see 2.6 live forever as the
| "stable general purpose kernel of choice for multiple architectures"
| that it is today. And I'd like to see the broad "kernel community" move
| to a 64-bit-only microkernel-based "GNU/Whatever".

Dreamer.

|
| There's just too many hacks, patches, band-aids, etc., in the address
| space on 32-bit architectures. Just about everybody *has* a 64-bit
| address space available, and the performance penalities that drove Linus
| away from microkernels have, to my knowledge, been resolved.
|

What?  I have amd64, nobody else I know does.  My aunt had one taylored
to her needs, but that was from my influence.  The other 2 people I know
who bought new machines got an Athlon and a Sempron.

Linus hates microkernels :o

| Which microkernel? Well ... I'm sure there are people here who are more
| expert than I am. The one that appeals to me the most is the Dresden
| Real-Time Operating System/L4 line, which, in fact, can support Linux
| 2.4 and 2.6 on 32-bit architectures as a "bonus". 64 bit is the future
| -- I expect to have a 64-bit machine operating by summer, although it's
| not clear to me whether it will be AMD64 or PPC64 at this point, and
| it's not clear to me whether the OS will be Gentoo GNU/Linux or
| Macintosh OS X. I'm really intrigued with the thought of a G5
| dual-booted; I've had a lot of fun with Windows/Linux dual-boot machines
| over the years. :)
|
|
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
|

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB3sXvhDd4aOud5P8RAv0DAJ4xjlbhzaNN7N6nu3jM06EEq8QtSwCeOCrh
yTxloXo434xAtQvInE7PNRA=
=oTE1
-----END PGP SIGNATURE-----
