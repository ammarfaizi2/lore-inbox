Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267410AbTBLOfS>; Wed, 12 Feb 2003 09:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267412AbTBLOfR>; Wed, 12 Feb 2003 09:35:17 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:20234 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267410AbTBLOfN>; Wed, 12 Feb 2003 09:35:13 -0500
Date: Wed, 12 Feb 2003 15:45:00 +0100
From: Pavel Machek <pavel@suse.cz>
To: John Clemens <john@deater.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mouse/Keyboard hangs..
Message-ID: <20030212144500.GI13327@atrey.karlin.mff.cuni.cz>
References: <20030210172239.GE443@elf.ucw.cz> <Pine.LNX.4.44.0302111212200.32155-100000@pianoman.cluster.toy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302111212200.32155-100000@pianoman.cluster.toy>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Strange.. I have something very similar on hp omnibook xe3 here,
> > except that:
> 
> The XE3 is approximately the same model.  Is yours AMD or Intel based? I
> seem to remember there was even an AMD-based "omnibook xe3" that was
> > the

Mine is "AMD-based".

> > 2) it *allways* recovers after power button
> 
> I'd say mine does about 80% of the time.
> 
> > 3) it seems to only happen in 2.5.X here, maybe it has something to do
> > with ACPI?
> 
> I've seen it in both 2.4 and 2.5.. but it seems to happen more frequently
> in 2.5.  I've tried to booting with "acpi=off, pci=noacpi" and it still
> happens :(.. Or were you suggesting it has something to do with the
> hardware/firmware that implements ACPI?

Actually, it *probably* also happened in 2.4 with apm, but it always
recovered automagically within second or so -- so it was "damn that
machine is unresponsive" not "keyboard failed again, time for power
button".
 

> FWIW, on the HP user support forums for pavilions, people were
> complaining about "mouse locking up" under windows...and those were cured
> with an updated synaptics driver.  however, they never mentioned a
> keyboard lock, and I -know- I've seen errors when nothing's even touching
> the mouse.. ie, on the console, without GPM running.

Same here. But I also see it happening while *only* using mouse.

> > Mine remembers up to few keystrokes I was typing...
> 
> Mine does too..but repeats the last one occasionally.

Yes, it can buffer only so-many keys and if the last one it *can*
remember is press, you get an autorepeat.
							Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
