Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314380AbSESMZr>; Sun, 19 May 2002 08:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314389AbSESMZq>; Sun, 19 May 2002 08:25:46 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:30929 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S314380AbSESMZn>;
	Sun, 19 May 2002 08:25:43 -0400
Date: Sun, 19 May 2002 14:25:43 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200205191225.OAA25457@harpo.it.uu.se>
To: steffl@bigfoot.com
Subject: Re: lost interrupt hell - Plea for Help
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 May 2002 00:14:42 -0700, Erik Steffl wrote:
>> Yeah, the spurious interrupt does seem to be an AMD apic problem, but the lost
>> interrupt (on ripping audio) seems to be a VIA chipset problem, as people
>> with KT266 chipsets are having boot problems / audio rip problems regardless
>> of the processor type. Lucky me, I get both ;)
>
>  doesn't anybody know what the problem is? while it was reported quite
>a few times there was no helpful response to the problem (positive
>(fix)or negative (it's unlikely to be fixed).

As the person who added AMD K7 local APIC support to the kernel, I
consider the _real_ problem to be the lack of adequate documentation.
AMD has almost no documentation on the K7's machine-specific features,
and VIA similarly don't seem keen on documenting their chipsets.

If someone were to find AMD K7 documentation at the level of Intel's
IA32 Volume 3 manual (245272-006), and AMD K7 errata docs at the level
of Intel's PIII (244453-nn) and P4 (249199-nn) specification updates,
then I'd be happy to look at the K7 spurious interrupt problem.

Without documentation it's just guesswork, and I don't have time for that.

/Mikael
