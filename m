Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129115AbRCWCue>; Thu, 22 Mar 2001 21:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129624AbRCWCuY>; Thu, 22 Mar 2001 21:50:24 -0500
Received: from stanis.onastick.net ([207.96.1.49]:8709 "EHLO
	stanis.onastick.net") by vger.kernel.org with ESMTP
	id <S129115AbRCWCuM>; Thu, 22 Mar 2001 21:50:12 -0500
Date: Thu, 22 Mar 2001 21:49:20 -0500
From: Disconnect <lkml@sigkill.net>
To: linux-kernel@vger.kernel.org
Subject: thunderbird 1.2G + kk266 + 2.4.x oops and crash
Message-ID: <20010322214920.B24336@sigkill.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Long and short is I have a new mobo/cpu/ram (see below) that runs great
under Win98 and passes memtest86 (3 extended runs as pc133/cas2, 3
standard runs as pc100/cas3) but oops's almost immediately under Linux
2.4.x (2.4.2 and 2.4.1 at the least.)

With a few rare exceptions (usually kupdated) all of the oops's are in
kswapd (I can manually decode the call stack/etc if someone lets me know
which info they need and confirms for me real quick how to get all the
info out.  I do have the system.map on another machine, so just a
pointer/url/etc is cool.)

I have tried a couple of kernel builds, with no change.  HD access doesn't
seem to affect it (at least, e2fsck on a 10 gig partition doesn't bomb)
but doing actual work does.  (Work like, say, booting w/o init=/bin/sh ;)
..)

Hardware list:
1.2G AMD Thunderbird
Iwill kk266 (not ide-raid) mobo, via apollo kt133a - specs url below)
2 256M pc133/cas2 amd-approved dimms
new amd-approved power supply (bios and windows list voltages/cooling as
reasonable)
bunch of pci cards that don't seem to affect things either way (only one I
haven't pulled is voodoo3, since there is no onboard video)

Mobo is jumpered to 100mhz FSB (which is correct for the chip) and
multiplier/voltage/etc is set to 'auto'.

Things tried:
memtest86, passed
win98, runs fine
set speed down (1150 and 1100), no change
set ide to paranoid (noautotune, no dma, no blockmode, etc), no change
bang head on wall, no change


Full mobo specs:
http://www.iwillusa.com/products/spec.asp?ModelName=KK266&SupportID=

Any help much appreciated.

---
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1 [www.ebb.org/ungeek]
GIT/CC/CM/AT d--(-)@ s+:-- a-->? C++++$ ULBS*++++$ P+>+++ L++++>+++++ 
E--- W+++ N+@ o+>$ K? w--->+++++ O- M V-- PS+() PE Y+@ PGP++() t 5--- 
X-- R tv+@ b++++>$ DI++++ D++(+++) G++ e* h(-)* r++ y++
------END GEEK CODE BLOCK------
