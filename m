Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262186AbTCMHDK>; Thu, 13 Mar 2003 02:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262187AbTCMHDK>; Thu, 13 Mar 2003 02:03:10 -0500
Received: from 101.24.177.216.inaddr.g4.Net ([216.177.24.101]:3214 "EHLO
	sparrow.stearns.org") by vger.kernel.org with ESMTP
	id <S262186AbTCMHDI>; Thu, 13 Mar 2003 02:03:08 -0500
Date: Thu, 13 Mar 2003 02:13:45 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: wstearns@sparrow
Reply-To: "M. Soltysiak" <msoltysiak@hotmail.com>
To: ML-linux-kernel <linux-kernel@vger.kernel.org>
cc: "M. Soltysiak" <msoltysiak@hotmail.com>,
       William Stearns <wstearns@pobox.com>
Subject: Re: Linux BUG: Memory Leak
In-Reply-To: <Pine.LNX.4.44.0303120213370.3104-100000@sparrow>
Message-ID: <Pine.LNX.4.44.0303130209400.3104-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	(Response sent to me, bounced back to the list where brighter 
minds may be able to offer useful suggestions)


> Please don't start the post with a negative tone; focus on a
problem in software rather than > on insulting the people from whom you
want.

Sorry.  And, no, I'm not insulting people.  But I do encourage good
programming practices.  Don't you? :)

>you tell us what kernel version you're using, what modules are
loaded,

Sorry.  I forgot--2.4.20.  Modules: ne2000 network driver, pci; via-rhine,
pci; emu10k1, pci; usbcore, uhci, usb mouse; all iptables modules--all of
them.

>want to mention what Linux distribution you're using.

Sorry.  Slackware 8.1.  Won't help.

>kernel yourself.

I compiled the kernel myself.  Memory leak located in kernel.

> Does the system pass a night's worth of memtest86 successfully?

Kernel memory leak.

>If we can rule out hardware, that narrows the problem space down
some.

cards: emu10k1, via-rhine, pci; ne2000, pci; usb standard, intel.  Via
chipset, unknown - on another computer right now.  but that's *not* the
problem.

> Again, it sounds like you're taking an insulting tone. :-)

I am sorry.  I'm usually direct.  I will try to look for the bug this
weekend, but i have a few things to do.  Sigh.

> "Acts dead" - what does that mean? Sluggish?

Dead.  It's a DOSS over the system.  All I did was install this game,
hoping to play it, after a few weaks.  Anyway, the systems installs,
X11-KDE running (140 Megs total by X11 and KDE); Linux installs it, then
it gets slower and slower, etc.  Finally dead.  Even the interrupts
die--only keyboards, usb mouse; but the network still works (slowly)).

>seconds, then returns to normal? Swapping madly? For how long?

Swap space will become full.  Then the duel-1Ghz with 1 MByte system will
die - hardware -- except network - interrupts die.

>lockup, no keys do anything? Does the caps lock key change the
state of the caps lock led? Do the caps/scroll/numlock lights flash on and
off without keypresses? Does anything show up in the logs on next boot?
Can you kill X11 with Ctrl-Alt-Backspace? Can you reboot the box with
Ctrl-Alt-Del? Does Sysrq-S force disk activity? Can you ssh in from

>another box when it "acts dead"?

Interrupts are dead on the keyboard and mouse, except for the harddisk and
network.

> What are the last few lines from "vmstat 1" when the system
freezes?

Ah, i did not use that.  not on my box now.  sorry.  but the ram is 0
free, system is working, but interrupts are crippled.

> Can you make the problem occur with fewer programs, say, just
with Mozilla, or just with > Unreal?

Yes.  Xine - movie player.  I watch a few movies (not completely) and
Linux keeps using memory until it acts dead.  In other words, I watch Lord
of the Rings: Two Towers.  Then the system will play the movie slower,
slower, until the frames' speed record becomes about 5 to 10 fps.  Then i
will just stand still - frozen - and some hardware interrupts (keyboard,
usb-mouse) will not respond.

 >show up? Minutes, hours, days?

This occurs in about 2 hours or less.  Not time-dependent, sort of like
Stationary states in quantum mechanics.

> If you'd prefer, feel free.

I will try.  Fibre optics and school do take time.

>You do remember that the people from whom you're asking help
have day jobs too, right? >*grin*

Yea.  Why are you working on Linux again?

Don't get offended to anything. I respect those who write for Linux.  But
I do believe, that If one will write open source software as major as
linux, one should not write software if they're not serious -- that is,
good at relative, but-free programming -- toward it.  Just a thought.

M.C.S


________________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE*


