Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310619AbSCPUgx>; Sat, 16 Mar 2002 15:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310602AbSCPUgm>; Sat, 16 Mar 2002 15:36:42 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:15301 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S310598AbSCPUg1>; Sat, 16 Mar 2002 15:36:27 -0500
Date: Sat, 16 Mar 2002 13:36:21 -0700
Message-Id: <200203162036.g2GKaL513580@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <yodaiken@fsmlabs.com>, Andi Kleen <ak@suse.de>,
        Paul Mackerras <paulus@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <Pine.LNX.4.33.0203161203050.31971-100000@penguin.transmeta.com>
In-Reply-To: <20020316125711.B20436@hq.fsmlabs.com>
	<Pine.LNX.4.33.0203161203050.31971-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> Instead of large pages, you should be asking for larger and wider TLB's
> (for example, nothign says that a TLB entry has to be a single page:
> people already do the kind of "super-entries", where one TLB entry
> actually contains data for 4 or 8 aligned pages, so you get the _effect_
> of a 32kB page that really is 8 consecutive 4kB pages).
> 
> Such a "wide" TLB entry has all the advantages of small pages (no
> memory fragmentation, backwards compatibility etc), while still
> being able to load 64kB worth of translations in one go.

These are contiguous physical pages, or just logical (virtual) pages?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
