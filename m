Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277918AbRKDVCr>; Sun, 4 Nov 2001 16:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278829AbRKDVCh>; Sun, 4 Nov 2001 16:02:37 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:19651 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S277918AbRKDVCW>; Sun, 4 Nov 2001 16:02:22 -0500
Date: Sun, 4 Nov 2001 16:01:54 -0500 (EST)
From: Chris Meadors <clubneon@hereintown.net>
To: Tom Sightler <ttsig@tuxyturvy.com>
cc: Andrew Morton <akpm@zip.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 3c556 basicly not working.
In-Reply-To: <008201c16537$e0176200$3a01a8c0@zeusinc.com>
Message-ID: <Pine.LNX.4.40.0111041547110.139-100000@yas.clubneon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Nov 2001, Tom Sightler wrote:

> I experienced some similar problems when I first received my Dell Latitude
> C810 which has the same card.  In my case the card worked fine after
> upgrading to the latest BIOS from Dell.

This machine also has Win2k on it.  I was trying to get IBM to help me
with this a little, as I was seeing some funky stuff even in Windows.  The
latest BIOS upgrade did help a little.

In Windows the card does work.  But before when I was shutting down the
machine wasn't turning all the way off.  The back light on the screen was
staying on.  Now the backlight turns off, but I still don't think it
shutsdown properly, because Windows won't restart properly, it just hangs.
I have to hold the powerbutton to get it to shut down, when I hit the
powerbutton again it won't POST, unless I unplug the AC adaptor first.

Actually when booting from Windows to Linux, even Linux hangs on the first
boot.  Right when it tries to load the ACPI kernel driver.  Linux seems to
shutdown properly and start backup (actually this is the first machine
I've seen power off with ACPI instead of APM in the kernel).

> Interestingly, the card has a similar problem in Windows ME in that it's
> won't initialize properly on first boot, but if I remove and reinstall the
> driver it comes right up.
>
> I think the problem is that the BIOS fails to initialize the PCI bridge
> properly, but this is a total guess.
>
> Anyway, my suggestion would be to verify that you have the most current BIOS
> for your system, and select any options at all that would indicate a legacy
> system.  Also, another stupid suggestion is to try ACPI in the kernel, a
> friend of mine insist that his card started working after he simply compiled
> in ACPI, he thinks the bridge was brought up in standby mode and somehow
> ACPI fixed this (I'm skeptical, but it is just a suggestion).

There are really no legacy options in the BIOS.  I have turned off the
legacy floppy support because there is no floppy controller in this
machine.  I've turned on the serial port because I need it sometimes.

And as I stated above I do have ACPI in the kernel.  I know the hangs on
loading ACPI are related to the card because I could reboot between
Windows and Linux all day without a hang before I installed this card.  I
tried removing the card and the laptop does work properly without it.  So
it would also be my guess that there is something wrong with the BIOS.

But the card works in Windows, and Linux can shutdown properly, so what
ever the problem is it can be worked around it seems.

Anway, I'll keep watching IBM for BIOS updates, and work as much as I can
with Andrew to see if anything can be worked out.

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

