Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267866AbTBKSRO>; Tue, 11 Feb 2003 13:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267887AbTBKSRN>; Tue, 11 Feb 2003 13:17:13 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:38019 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267866AbTBKSRK>;
	Tue, 11 Feb 2003 13:17:10 -0500
Date: Tue, 11 Feb 2003 18:22:56 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.60-dj2
Message-ID: <20030211182256.GA28903@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Been a while since I did a -dj, but I've accumulated a bunch
of driver stuff (which shouldn't crossover too much with what
Andrew is doing in -mm) that could use some extra testing,
so here's what I've been up to of late..

ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/2.5.60/

(Thanks to Steven Cole for noticing the agp problems before I
 even got a chance to write the changelog 8-)

2.5.60-dj2
- Fix up modules versioning (Kai)
- Throw out some stale agpgart bits that broke the compile.


2.5.60-dj1
- cpufreq updates.
  - Athlon/Duron powernow cpufreq support.
    Handle with care. Only known bug is that the top speed
	isn't usable.
  - Updates various core parts, and other cpufreq drivers.
- AGPGART updates
  VIA KT400 support.
  Updated VIA AGP2.0 GART tables (PLE133 and others).
  Various cleanups.
- VIA C3 Nehemiah support.
  Compiles as i686/c3-2, works around L2 cache size errata.
- Watchdog fixes
  sc1200wdt PNP API conversion (Adam Belay)
- Lots of other leftovers from older -dj patches
  This stuff needs sorting, and some bits throwing out.
  There's lots of 2.4 forward port stuff here, and more
  pending.
- Latest from Linus' bk tree.
  (Just there to help me stay in sync)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
