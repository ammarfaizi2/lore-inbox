Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131216AbRABX3r>; Tue, 2 Jan 2001 18:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131133AbRABX32>; Tue, 2 Jan 2001 18:29:28 -0500
Received: from anime.net ([63.172.78.150]:22285 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S131081AbRABX30>;
	Tue, 2 Jan 2001 18:29:26 -0500
Date: Tue, 2 Jan 2001 14:56:26 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: David Woodhouse <dwmw2@infradead.org>,
        Hakan Lennestal <hakanl@cdt.luth.se>,
        Andre Hedrick <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Chipsets, DVD-RAM, and timeouts.... 
In-Reply-To: <Pine.LNX.4.10.10101021444010.1037-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0101021450320.15782-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2001, Linus Torvalds wrote:
> On Tue, 2 Jan 2001, Dan Hollis wrote:
> > Too bad Maxtor is still broken with hpt366...
> > Also, using CDROM on hpt366 is recipe for disaster...
> Does the Maxtor and/or CDROM problems have anything to do with udma66? Ie
> if you can test, can you please check whether it's ok when they are added
> to the blacklists (or if udma66 is just disabled by default)?

Its maxtor with dma-anything on hpt366, whether it's "classic dma", udma33
or udma66.

It's harder, but you can even lock the system using pio mode on hpt366
with cdrom... evil.

Andre has told me that the hpt366 timing is just plain wrong for CDROM
devices, and timing with maxtors is off enough to cause problems.

In the end, I gave up on hpt366 and bought a pdc20262 instead... works
fine with udma maxtors and cdroms...

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
