Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132177AbRBKLHa>; Sun, 11 Feb 2001 06:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132258AbRBKLHT>; Sun, 11 Feb 2001 06:07:19 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:2826 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S132177AbRBKLHJ>; Sun, 11 Feb 2001 06:07:09 -0500
Date: Sun, 11 Feb 2001 12:06:14 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Hacksaw <hacksaw@hacksaw.org>,
        Tom Eastep <teastep@seattlefirewall.dyndns.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Major Clock Drift
Message-ID: <20010211120614.E23048@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.30.0102040908320.877-100000@wookie.seattlefirewall.dyndns.org> <200102041804.f14I4br22433@habitrail.home.fools-errant.com> <3A7EA9B3.3507DC8D@uow.edu.au>, <3A7EA9B3.3507DC8D@uow.edu.au>; <20010210225851.G7877@bug.ucw.cz> <3A8671FF.C390FDCC@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A8671FF.C390FDCC@uow.edu.au>; from andrewm@uow.edu.au on Sun, Feb 11, 2001 at 10:05:35PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > >I've discovered that heavy use of vesafb can be a major source of clock
> > > > >drift on my system, especially if I don't specify "ypan" or "ywrap". On my
> > > >
> > > > This is extremely interesting. What version of ntp are you using?
> > >
> > > Is vesafb one of the drivers which blocks interrupts for (many) tens
> > > of milliseconds?
> > 
> > Vesafb is happy to block interrupts for half a second.
> 
> And has this been observed to cause clock drift?

YEs. I've seen time running 3 times slower. Just do cat /etc/termcap
with loaded PCI bus. Yesterday I lost 20 minutes during 2 hours -- I
have been using USB (load PCI) and framebuffer.
								Pavel
-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
