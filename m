Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266243AbTBPKlO>; Sun, 16 Feb 2003 05:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266274AbTBPKlO>; Sun, 16 Feb 2003 05:41:14 -0500
Received: from [195.39.17.254] ([195.39.17.254]:7428 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266243AbTBPKlN>;
	Sun, 16 Feb 2003 05:41:13 -0500
Date: Sat, 15 Feb 2003 23:12:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: cpufreq on athlon4
Message-ID: <20030215221236.GA210@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I tried cpufreq on hp omnibook with athlon4 cpu... Its interesting: It
works *in addition* to ACPI throttling. That means I can slow it down
to 4% of top speed.

Documentation/cpufreq should probably be renamed to Doc*/cpufreq.txt.

Kernel says:

powernow: AMD K7 CPU detected.
powernow: PowerNOW! Technology present. Can scale: frequency and
voltage.
powernow: Found PSB header at c00f7ab0
powernow: Table version: 0x12
powernow: Flags: 0x0 (Mobile voltage regulator)
powernow: Settling Time: 100 microseconds.
powernow: Has 14 PST tables. (Only dumping ones relevant to this CPU).
powernow: PST:2 (@c00f7ae4)
powernow:  cpuid: 0x761 fsb: 100        maxFID: 0xc     startvid: 0xc
powernow:    FID: 0x10 (3.0x [300MHz])  VID: 0xc (1.400V)
powernow:    FID: 0x4 (5.0x [500MHz])   VID: 0xc (1.400V)
powernow:    FID: 0x6 (6.0x [600MHz])   VID: 0xc (1.400V)
powernow:    FID: 0x8 (7.0x [700MHz])   VID: 0xc (1.400V)
powernow:    FID: 0xc (9.0x [900MHz])   VID: 0xc (1.400V)

First it claims it can scale voltage, then I see I can only use
1.4V. Too bad for me (and my batteries ;-)...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
