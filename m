Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267885AbTBKRah>; Tue, 11 Feb 2003 12:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267887AbTBKRah>; Tue, 11 Feb 2003 12:30:37 -0500
Received: from donna.siteprotect.com ([64.41.120.44]:37039 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S267885AbTBKRaf>; Tue, 11 Feb 2003 12:30:35 -0500
Date: Tue, 11 Feb 2003 12:40:26 -0500 (EST)
From: John Clemens <john@deater.net>
X-X-Sender: john@pianoman.cluster.toy
To: Pavel Machek <pavel@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: Mouse/Keyboard hangs..
In-Reply-To: <20030210172239.GE443@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0302111212200.32155-100000@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pavel..

On Mon, 10 Feb 2003, Pavel Machek wrote:

> Hi!
...
> Strange.. I have something very similar on hp omnibook xe3 here,
> except that:

The XE3 is approximately the same model.  Is yours AMD or Intel based? I
seem to remember there was even an AMD-based "omnibook xe3" that was the
exact same laptop rebranded...  but there were also P3 ones.  To give you
an idea of how close they were, I flashed my bios with (appearently) the
wrong bios, and my machine thought it was an omnibook xe3 for a long time
;) (until it went if for service and they flashed it back)

full specs for mine: http://www.deateer.net/john/PavilionN5430.html

> 1) I do not think it responds to the net when hung

I haven't tried in a loooooong time.  I'll have to try if/when it happens
again.  It's just easier to big-red-switch it, since ext2 and ext3 are soo
good about powerdowns :)

> 2) it *allways* recovers after power button

I'd say mine does about 80% of the time.

> 3) it seems to only happen in 2.5.X here, maybe it has something to do
> with ACPI?

I've seen it in both 2.4 and 2.5.. but it seems to happen more frequently
in 2.5.  I've tried to booting with "acpi=off, pci=noacpi" and it still
happens :(.. Or were you suggesting it has something to do with the
hardware/firmware that implements ACPI?

FWIW, on the HP user support forums for pavilions, people were
complaining about "mouse locking up" under windows...and those were cured
with an updated synaptics driver.  however, they never mentioned a
keyboard lock, and I -know- I've seen errors when nothing's even touching
the mouse.. ie, on the console, without GPM running.

> > The behavior is a little different recently though with the 2.5 series.
> > Now, sometimes when it comes back, i get the character i was typing
> > repeated (as if a key was stuck) until i hit another key.  This change
> > could be related to the new i8042 changes in 2.5, I'm not sure.
>
> Mine remembers up to few keystrokes I was typing...

Mine does too..but repeats the last one occasionally.

john.c

