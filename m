Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266978AbTBPO1P>; Sun, 16 Feb 2003 09:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267007AbTBPO1P>; Sun, 16 Feb 2003 09:27:15 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:15488 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266978AbTBPO1O>;
	Sun, 16 Feb 2003 09:27:14 -0500
Date: Sun, 16 Feb 2003 14:49:41 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: cpufreq on athlon4
Message-ID: <20030216144941.GA4459@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20030215221236.GA210@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030215221236.GA210@elf.ucw.cz>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2003 at 11:12:37PM +0100, Pavel Machek wrote:

 > Documentation/cpufreq should probably be renamed to Doc*/cpufreq.txt.

agreed.
 
 > powernow:  cpuid: 0x761 fsb: 100        maxFID: 0xc     startvid: 0xc
 > powernow:    FID: 0x10 (3.0x [300MHz])  VID: 0xc (1.400V)
 > powernow:    FID: 0x4 (5.0x [500MHz])   VID: 0xc (1.400V)
 > powernow:    FID: 0x6 (6.0x [600MHz])   VID: 0xc (1.400V)
 > powernow:    FID: 0x8 (7.0x [700MHz])   VID: 0xc (1.400V)
 > powernow:    FID: 0xc (9.0x [900MHz])   VID: 0xc (1.400V)
 > 
 > First it claims it can scale voltage, then I see I can only use
 > 1.4V. Too bad for me (and my batteries ;-)...

Some laptops have *really* crap PST tables. For the majority, they are
quite sane.  I'm collecting model names/numbers to feed back to AMD
so they can go beat up vendors.

Its likely at some point I'll implement a way to override using
the BIOS table too.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
