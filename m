Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129189AbRBFUYB>; Tue, 6 Feb 2001 15:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129219AbRBFUXw>; Tue, 6 Feb 2001 15:23:52 -0500
Received: from chiara.elte.hu ([157.181.150.200]:43530 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129189AbRBFUXi>;
	Tue, 6 Feb 2001 15:23:38 -0500
Date: Tue, 6 Feb 2001 21:22:55 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Ben LaHaise <bcrl@redhat.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.30.0102061450590.15204-100000@today.toronto.redhat.com>
Message-ID: <Pine.LNX.4.30.0102062120390.9776-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Feb 2001, Ben LaHaise wrote:

> Sure.  General parameters will be as follows (since I think we both have
> access to these machines):
>
> 	- 4xXeon, 4GB memory, 3GB to be used for the ramdisk (enough for a
> 	  base install plus data files.
> 	- data to/from the ram block device must be copied within the ram
> 	  block driver.
> 	- the filesystem used must be ext2.  optimisations to ext2 for
> 	  tweaks to the interface are permitted & encouraged.
>
> The main item I'm interested in is read (page cache cold)/synchronous
> write performance for blocks from 256 bytes to 16MB in powers of two,
> much like what I've done in testing the aio patches that shows where
> improvement in latency is needed. Including a few other items on disk
> like the timings of find/make -s dep/bonnie/dbench is probably to show
> changes in throughput. Sound fair?

yep, sounds fair.

	Ingo


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
