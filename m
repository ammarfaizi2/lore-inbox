Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284730AbRLPRbB>; Sun, 16 Dec 2001 12:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284732AbRLPRaw>; Sun, 16 Dec 2001 12:30:52 -0500
Received: from mustard.heime.net ([194.234.65.222]:24209 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S284730AbRLPRao>; Sun, 16 Dec 2001 12:30:44 -0500
Date: Sun, 16 Dec 2001 18:30:25 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: Repost: Bug in RAID subsys and/or cache handeling
Message-ID: <Pine.LNX.4.30.0112161820120.5493-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

I'm sorry to repost this - I just need some sort of fix, or perhaps try
another OS, like a BSD or something

On my computer, I've set up a 2-disk stripe set (RAID-0). Each disk has
some 120GB disk space, and is pretty fast. Each disk can do some 40 megs
per second disk-to-memory.

However, when reading multiple, large files (3 gigs each) simultanously,
vmstat first shows quite high throughput (~ 40-50 megs per sec). But as I
reach the point where I've filled the cache, speed is reduced to 1-2 megs
per sec.

I'm running 2.4.16 with the latest tux patches plus Andrea's IDE patch.
I'm positive that this is not a tux problem. I've also tried 2.4.17-rc1,
but all I got out of that was some 20-30% slower I/O.

Hardware:

Athlon 1133MHz
1GB RAM (highmem disabled in kernel)
1x20 gig disk for root partition
2x120 gig disks in RAID-0 (chunk size = 4096) for data partition


Please help me out here...

Regards

roy


--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

