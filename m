Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbSJ0RCR>; Sun, 27 Oct 2002 12:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262472AbSJ0RCR>; Sun, 27 Oct 2002 12:02:17 -0500
Received: from franka.aracnet.com ([216.99.193.44]:14737 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262469AbSJ0RCQ>; Sun, 27 Oct 2002 12:02:16 -0500
Message-Id: <5.1.1.6.0.20021027084740.0209cb70@pop.aracnet.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Sun, 27 Oct 2002 09:08:38 -0800
To: linux-kernel@vger.kernel.org
From: Arthur Aldridge <aj@yasashi.net>
Subject: RE: Problem with ACPI on Abit KT7,HPT370
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



   I'm running a KT7-Raid with bios A9.

   After rebuilding my kernel yesterday (2.4.19-gentoo-r9) with
ACPI I ran into this same issue. I noted that at that time the
devices attached to the HPT370 were reporting at DMA 2.
I realized I'd turned the IDE cables around.

   After fixing that the system worked fine. Early this morning I
decided to move the DVD drive to a different system and replaced
it with an older Samsung CD-ROM and I haven't been able to boot
since. The only change besides the CD-ROM is that my bios
setting were reset and perhaps I don't have exactly the same
settings. Alt-SysRq+b responds, and if I disable the HPT370 the
system boots without issue. I've tried disconnecting the CD-ROM
and disabling DMA at boot, none of which is working.....

I suppose I'll just go back with the HPT370 disabled and compile
a non-acpi kernel to see if it starts working again but this is baffle
the bejesus out of me.

 >Dominik Geisel (dominik_at_geisel.info) Wrote:
 >
 >I tried 2.4.10-ac10 with your config and played around with all possible
 >BIOS settings...the problem persists.
 >Also, I am now quite sure it broke with BIOS version 3R.

 >>On Mon, Oct 08, 2001 at 10:35:42PM +0200, Dominik Thinay wrote:
 >> with kernel 2.4.11-pre3-xfs + i2c CVS-patch + lmsensors it works fine 
on my
 >> system (Abit Bios KT7_49B0)
 >> CONFIG_PM=y
 >> CONFIG_ACPI=y
 >> CONFIG_ACPI_DEBUG=y
 >> CONFIG_ACPI_BUSMGR=y
 >> CONFIG_ACPI_SYS=y
 >> CONFIG_ACPI_CPU=y
 >> CONFIG_ACPI_BUTTON=y
 >>
 >> I remember disabled sth in the bios ...but i have forget ... :(




--
Arthur Aldridge
Sun Certified Solaris Admin
aj@yasashi.net

