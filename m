Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSHBPJY>; Fri, 2 Aug 2002 11:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315200AbSHBPJY>; Fri, 2 Aug 2002 11:09:24 -0400
Received: from ns.suse.de ([213.95.15.193]:59143 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315198AbSHBPJW>;
	Fri, 2 Aug 2002 11:09:22 -0400
Date: Fri, 2 Aug 2002 17:12:52 +0200
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.30-dj1 (sort of)
Message-ID: <20020802171252.M25761@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change of technique this time, as I found a way to work with BitKeeper
that I'm comfortable with. On the upside, syncing gets easier for me,
on the downside, I'm still experimenting, so some bits might be a bit
bumpy, with maybe 1-2 files there that shouldn't be etc..

Chances are this won't even boot for many people (if any at all).
There's something nasty in my tree right now which makes it
fail to find init(1).  I wasn't going to put up a .30-dj for this
reason until I tracked it down, but a few people asked for
something to sync against, or wanted to see where my tree currently
stood (and didn't want to use bk), so just before I disappear
for a week, I've put this up.  So consider it a 'useful only
if you plan to send dave anything' patch for now.

There's still truckloads in my pending patches folder that need
going through, but things like the init(1) problem need tracking
down before I move onto those.

Back in a week..

        -- Davej


As usual,..

Patch against 2.5.30 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Merged patch archive: http://www.codemonkey.org.uk/patches/merged/
BitKeeper tree at http://linux-dj.bkbits.net

2.5.30-dj1
o   Merge bits from 2.4.19 release candidates.
o   Backout the buggy dcache list_ conversion.
o   Remove some more bogus bits Christoph Hellwig found.
o   Remove lots of other bogus bits found during the cvs->bk transition.
o   Fix mask calculation in x86-64 MTRR driver.     (Me)
o   Fix up incorrect C in cpufreq macros.       (Neil Booth)
o   Add missing identification of Intel CPUs.       (Patrick Mochel)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
