Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129616AbRB0IxV>; Tue, 27 Feb 2001 03:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129618AbRB0IxM>; Tue, 27 Feb 2001 03:53:12 -0500
Received: from mail.sonytel.be ([193.74.243.200]:5009 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S129616AbRB0Iw7>;
	Tue, 27 Feb 2001 03:52:59 -0500
Date: Tue, 27 Feb 2001 09:48:03 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Weinehall <tao@acc.umu.se>
cc: Wakko Warner <wakko@animx.eu.org>, Jonathan Morton <chromi@cyberspace.org>,
        "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>,
        Augustin Vidovic <vido@ldh.org>, Dennis <dennis@etinc.com>,
        jesse@cats-chateau.net, A.J.Scott@casdn.neu.edu,
        linux-kernel@vger.kernel.org
Subject: Re: Linux stifles innovation...
In-Reply-To: <20010223133113.D5465@khan.acc.umu.se>
Message-ID: <Pine.GSO.4.10.10102270941300.2095-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2001, David Weinehall wrote:
> On Fri, Feb 23, 2001 at 07:14:48AM -0500, Wakko Warner wrote:
> > > - Some architectures' ports of the Linux kernel, at least in their current
> > > state (has anyone actually tried to *compile* the PPC kernel since
> > > 2.4.<whatever> besides me?)
> > 
> > Have you tried comiling 2.2.x where x > 13 on an m68k mac or 2.4.x on an
> > m68k mac?  doesn't happen.  The patches I found for 2.2 didn't work, kernel
> > oopsed on loading the network driver.
> 
> Have you submitted patches to Alan (for v2.2.x) or Linus (for v2.4.x)
> to fix this?!

Linux/m68k 2.4.x runs on some platforms. Also note that Linux/m68k is not 100%
merged with Linus/Alan yet. The mac-specific patches in the m68k tree that
weren't merged are on hold until all issues are sorted out[*], cfr. the
linux-m68k list.

Note to Wakko: feel free to join the project! As usual, we can use the
manpower!!

Gr{oetje,eeting}s,

						Geert

[*] This includes, but is not limited to:
      - reports that they work
      - reports that they work after applying patch foo
      - drivers shared with the PPC folks must be sorted out with them first
--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

