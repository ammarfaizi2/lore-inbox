Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284963AbRLQB5V>; Sun, 16 Dec 2001 20:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284964AbRLQB5M>; Sun, 16 Dec 2001 20:57:12 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:16782 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S284965AbRLQB44>; Sun, 16 Dec 2001 20:56:56 -0500
Date: Mon, 17 Dec 2001 01:58:45 +0000
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.1-dj1
Message-ID: <20011217015845.A10313@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Judging by the interest the last patch (which wasn't announced so publically)
got, and the supportive emails I recieved, I figure there's enough
interest for me to keep this up at least until Linus is ready to resync.
(plus, Linus seems interested in me keeping this stuff in a ready-to-merge
 state, which is good enough reason as any. 8)

Patch is available from:
http://www.codemonkey.org.uk/patches/2.5/patch-2.5.1-dj1.diff.bz2

On with the changelog..

This syncs up 2.5 right up to 2.4.17rc1.
Merge a few of the more trivial "2.5 material" salvaged from the last -ac tree,
a few fixes from the kernel list, and a few other pending bits..
Some of these fixes haven't found their way back to Marcelo yet, but should
show up in 2.4.17-rc2 / 2.4.18pre1 with any luck.

2.5.1-dj1
o   Resync with 2.5.1
    | drop reiserfs changes. 2.4's look to be more complete.
o   Fix potential sysvfs oops.				(Christoph Hellwig)
o   Loopback driver deadlock fix.			(Andrea Arcangeli)
o   __devexit cleanups in drivers/net/			(Daniel Chen,
    synclink, wdt_pci & via82cxxx_audio 		 John Tapsell)
o   Configure.help updates				(Eric S. Raymond)
o   Make reiserfs compile again.				(Me)
o   bio changes for ide floppy					(Me)
    | handle with care, compiles, but is unfinished.
o   Make x86 identify_cpu() happen earlier			(Me)
    | PPro errata workaround & APIC setup got a little
    | cleaner as a result.
o   Blink keyboard LEDs on panic				(From 2.4.13-ac)
o   Change current->state frobbing to set_current_state()	(From 2.4.13-ac)
o   Add MODULE_LICENSE tags for acpi,md.c,fmvj18x,		(From 2.4.13-ac)
    atyfb & fbmem.

2.5.1pre11-dj2
o   Merge with 2.4.17rc1
o   Activate out of order stores on IDT Winchips.		(From 2.4.13-ac)
o   ICH2 APIC support						(From 2.4.13-ac)
o   Activate Simple boot flag support				(From 2.4.13-ac)
    | was merged in -dj1, but not mentioned.
o   Remove matroxfb PLL debugging message.			(Me)

2.5.1pre11-dj1
o   Merge with 2.4.17pre8
    Drop devfs changes. (Newer version in 2.5)
o   Make ncr53c8xx bio aware.					(Me)

-- 
| Dave Jones.                    http://www.codemonkey.org.uk
| SuSE Labs .
