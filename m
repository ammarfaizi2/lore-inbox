Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <160056-27300>; Sun, 31 Jan 1999 16:56:03 -0500
Received: by vger.rutgers.edu id <157117-27302>; Sun, 31 Jan 1999 16:55:47 -0500
Received: from clavin.efn.org ([206.163.176.10]:51968 "EHLO clavin.efn.org" ident: "root") by vger.rutgers.edu with ESMTP id <160067-27300>; Sun, 31 Jan 1999 16:52:51 -0500
From: Steve VanDevender <stevev@efn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14004.54176.448314.592021@tzadkiel.efn.org>
Date: Sun, 31 Jan 1999 14:05:20 -0800 (PST)
To: linux-kernel@vger.rutgers.edu
Subject: Re: Page coloring HOWTO [ans] 
In-Reply-To: <199901311924.LAA04620@bitmover.com>
References: <199901311924.LAA04620@bitmover.com>
X-Mailer: VM 6.65 under 20.4 "Emerald" XEmacs  Lucid
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Larry McVoy writes:
 > davem@redhat.com (Hey, look where Dave is :-) says:
 > 
 > :    Page coloring, in the sense that we are talking about here,
 > :    is %99 dealing with physically indexed secondary/third-level
 > :    etc. caches.  Virtually indexed secondary/third-level caches
 > :    are dinosaurs 
 > 
 > Are you sure about that? We should come to agreement on terminology.
 > I thought that the HyperSparc was virtually indexed and virtually tagged,
 > with just about everything else being virtually indexed but physically
 > tagged.

Most of the x86 L2 direct-mapped cache systems I've seen would
appear to be physically indexed and physically tagged, if I
understand your terminology correctly.  The processor presents
physical addresses to the L2 cache, and the cache uses some of
the high-order physical address bits to tag cache lines.

I suppose there could have been virtually-indexed caches in the
days when the MMU was almost always external to the CPU, but I'm
not aware of any recent architectures where the processor's
external address bus uses virtual addresses.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
