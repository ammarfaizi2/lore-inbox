Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129234AbRBNRbf>; Wed, 14 Feb 2001 12:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129678AbRBNRbZ>; Wed, 14 Feb 2001 12:31:25 -0500
Received: from fep04.swip.net ([130.244.199.132]:2022 "EHLO fep04-svc.swip.net")
	by vger.kernel.org with ESMTP id <S129234AbRBNRbR>;
	Wed, 14 Feb 2001 12:31:17 -0500
Message-ID: <3A8A8AAC.C04F8C2@linux.nu>
Date: Wed, 14 Feb 2001 14:39:56 +0100
From: Arvid Ericsson <aquid@linux.nu>
X-Mailer: Mozilla 4.5 [sv] (Win95; I)
X-Accept-Language: en-GB,sv,fr
MIME-Version: 1.0
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: Memory performance significantly improved w/ 2.4.1ac11
In-Reply-To: <Pine.LNX.4.10.10102141026080.12204-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn skrev:
> first, are you sure your clock is write?  the changes appear
> to be tiny ~2 MB/s, and might be explained by the fact that
> 2.2 and 2.4 have different implementations of gettimeofday.

The change I was happy about was the one between 2.4.0ac10 and
2.4.1ac11. I think that it's a good thing that a few percent more memory
bandwidth appears from nowhere... Well, but that's just me I guess.

> (I'm assuming you're using gtod (second_wall.c) rather than
> a times-based measure.  the latter will be far less accurate.)

*Scratching my head* I have no idea of what your're talking about.
Sorry. Im using stream_whatever.cpp and whatever might be in it.

> 
> are you also aware that more modern compilers (2.95.2, I think)
> have more specific CPU tunings than just -mpentium?

I just used the suggested optimizations.
 
> 
> by "cycle length = 2", do you mean "tCAS latency = 2"?

Not quite sure, that the BIOS says "sdram cycle length=2" is all I know.

> finally (and don't take offense), those are astonishingly low
> Stream scores.  it's been a while since I ran Stream on a p5-class
> machine, but jeeze!  my dirt-cheap duron/600/kt133/pc133 sustains
> 600 MB/s!

Oh-well, I guess I just have a even dirt-cheaper machine than you. I
haven't got any idea of how machines similar to mine perform. 

/Arvid

