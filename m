Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314392AbSETImK>; Mon, 20 May 2002 04:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314389AbSETImJ>; Mon, 20 May 2002 04:42:09 -0400
Received: from m206-234.dsl.tsoft.com ([198.144.206.234]:16315 "EHLO
	jojda.2y.net") by vger.kernel.org with ESMTP id <S314392AbSETImI>;
	Mon, 20 May 2002 04:42:08 -0400
Message-ID: <3CE8B6E0.CFC6879D@bigfoot.com>
Date: Mon, 20 May 2002 01:42:08 -0700
From: Erik Steffl <steffl@bigfoot.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en, sk, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: lost interrupt hell - Plea for Help
In-Reply-To: <200205191225.OAA25457@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> 
> On Sun, 19 May 2002 00:14:42 -0700, Erik Steffl wrote:
> >> Yeah, the spurious interrupt does seem to be an AMD apic problem, but the lost
> >> interrupt (on ripping audio) seems to be a VIA chipset problem, as people
> >> with KT266 chipsets are having boot problems / audio rip problems regardless
> >> of the processor type. Lucky me, I get both ;)
> >
> >  doesn't anybody know what the problem is? while it was reported quite
> >a few times there was no helpful response to the problem (positive
> >(fix)or negative (it's unlikely to be fixed).
> 
> As the person who added AMD K7 local APIC support to the kernel, I
> consider the _real_ problem to be the lack of adequate documentation.
> AMD has almost no documentation on the K7's machine-specific features,
> and VIA similarly don't seem keen on documenting their chipsets.
> 
> If someone were to find AMD K7 documentation at the level of Intel's
> IA32 Volume 3 manual (245272-006), and AMD K7 errata docs at the level
> of Intel's PIII (244453-nn) and P4 (249199-nn) specification updates,
> then I'd be happy to look at the K7 spurious interrupt problem.

  is the same true for 'lost interrupt' during audio ripping problem? I
mean it is fairly specific command so it might not be so hard to debug.
I have no experience with kernel - is there info available to get me
started in right direction?

	erik
