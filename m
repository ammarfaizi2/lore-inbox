Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTEDWkr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 18:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbTEDWkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 18:40:47 -0400
Received: from munk.apl.washington.edu ([128.95.96.184]:53640 "EHLO
	munk.apl.washington.edu") by vger.kernel.org with ESMTP
	id S261823AbTEDWkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 18:40:46 -0400
Date: Sun, 4 May 2003 16:10:11 -0700 (PDT)
From: Brian Dushaw <dushaw@apl.washington.edu>
To: linux-kernel@vger.kernel.org
Subject: Albatron KM18G PRO/RedHat 9.0 - disk errors and system seizures...
Message-ID: <Pine.LNX.4.44.0305041543440.8546-100000@munk.apl.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linuxers,
    I have a new KM18G PRO motherboard from Albatron, an nforce2 system.
I've put together a generic system with 2X512MB Kingston HyperX memory
sticks, 80 GB Maxtor drive, LG GMA-4020B DVD drive, athlon 2500XP+ (barton).  
I also have USB devices: Epson C80 printer, Linksys wireless ethernet v2.5, 
and a compactflash reader.  I am trying to use the nvidia graphics drivers, 
which seem to work o.k.  A plain-jane system (apologies to Jane) - no 
overclocking, etc.
    I've installed RedHat 9.0 three times now - going on the fourth.  Most
recently I upgraded the kernel with the RedHat update, to similar effect.  The
problem seems to be two fold:  system lockups and disk errors.  The
system lockups happen irregularly.  The disk errors seem to do things like
corrupt the shared libraries (e.g., "bad magic" something, so the libraries
are not recognized as ELF anymore).  In one case, I was upgrading the RedHat 
glibc package when the upgrade crashed; then I was in big trouble.  Things are
very unstable, although everything seems to install o.k..
    Nothing much appears in the logs - dmesg or /var/log/messages.
    Possible theories:  the nforce IDE driver is unstable, the two memory
sticks in "twin bank" configuration don't cut the mustard, flakey motherboard,
motherboard bios settings that linux has trouble with (PnP, ACPI/APIC, MPS
Version Control (set to 1.4)), Memory timings (set to a conservative Optimal,
By SPD), anything else?  I don't think I have an overheating problem.

    Anybody have ideas on what to try?  I got the nforce2 for performance; I
had not realized that the linux support for it was so tenuous...

    One other note:  I do have Windows2K on the system as well.  I did have
a certain amount of trouble installing it, but I figured that was normal.  
Windows 2K seems to be by-and-large stable.

Thx!

Brian Dushaw

(I am not subscribed; please cc me directly, thx.)

