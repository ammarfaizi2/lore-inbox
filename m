Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315204AbSFDQrL>; Tue, 4 Jun 2002 12:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315192AbSFDQrK>; Tue, 4 Jun 2002 12:47:10 -0400
Received: from dsl093-058-082.blt1.dsl.speakeasy.net ([66.93.58.82]:60399 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S315198AbSFDQrI>; Tue, 4 Jun 2002 12:47:08 -0400
Date: Tue, 4 Jun 2002 00:05:33 -0400 (EDT)
From: Donald Becker <becker@scyld.com>
X-X-Sender: <becker@presario>
To: <nick@snowman.net>
cc: <linux-net@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Loosing packets with Dlink DFE-580TX and SMC 9462TX
In-Reply-To: <Pine.LNX.4.21.0206031956150.8643-100000@ns>
Message-ID: <Pine.LNX.4.33.0206032355460.1329-100000@presario>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2002 nick@snowman.net wrote:
> On 3 Jun 2002, Marcus Sundberg wrote:
> > running at gigabit speed. The original testing was done using
> > 100Mbit hubs, so my guess would be that the 83820 chips (and/or
> > driver) doesn't handle collisions too well (which I don't have a
> > problem with, as afaik GE is always switched).
> There are at least some gigabit ethernet hubs on the market.  How badly
> does it handle collisions?

Huh?
Packet Engines used to sell FDRs -- "Full Duplex Repeaters", but (as the
name implies) FDRs were not collision based.  I don't know of any Gb
Ethernet collision-based repeaters.

Any collision-based operations will take place at 10 or 100Mbps.  Anyone
still using a repeater obviously doesn't need performance.

...
> > 0.17, but some more testing showed that the ns83820 actually works
> > just fine during this test when using just crossover cables and

You might compare against my ns820.c driver.  (Note: It was initially
released before the ns83820.c driver was written, although the ns83820.c
driver was the one put into the kernel.)


-- 
Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

