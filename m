Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280330AbRJaRZw>; Wed, 31 Oct 2001 12:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280333AbRJaRZp>; Wed, 31 Oct 2001 12:25:45 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:37648 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S280334AbRJaRZA>; Wed, 31 Oct 2001 12:25:00 -0500
Date: Wed, 31 Oct 2001 12:19:47 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Ookhoi <ookhoi@ookhoi.xs4all.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.12 cannot find root device on raid
In-Reply-To: <20011025215743.B24475@humilis>
Message-ID: <Pine.LNX.3.96.1011031121713.24635H-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2001, Ookhoi wrote:

> > In article <15319.38517.663820.504760@notabene.cse.unsw.edu.au>,
> > Neil Brown <neilb@cse.unsw.edu.au> wrote:
> > | On Tuesday October 23, davidsen@prodigy.com wrote:

> > | Odd ... I use lines just like that. e.g.:
> > |    append="md=0,/dev/hda1,/dev/hde1,/dev/hdg1"
> > | 
> > | and it works just fine.  What do you get in the way of error messages?
> > 
> > None - the system simply exits the BIOS, reads the first drive once and
> > cold boots. The drive is okay, I can read both copies of the mirror end
> > to end without error after booting from floppy. Lilo claims it writes to
> > the md0 device, but boot fails.
> 
> I always let lilo write to the first and the second disk itself, and I
> do not use any kernel parameters for sw raid. Is writing to the disks
> instead of writing to /dev/md0 the wrong way? It works for me.

Tried that as well, with -b, still doesn't like to boot. It may well be
the system, which is seriously strange in config. I have some other
systems I'd love to install RAID, but the Redhat (mandated by management)
install won't do RAID unless graphical install. Unless that's fixed/added
in 7.2 which I haven't tried. These systems don't do graphical...

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

