Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265255AbUBENlJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 08:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbUBENlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 08:41:09 -0500
Received: from mout1.freenet.de ([194.97.50.132]:14736 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S265255AbUBENk6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 08:40:58 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Claudio Martins <ctpm@rnl.ist.utl.pt>
Subject: Re: psmouse.c, throwing 3 bytes away
Date: Thu, 5 Feb 2004 14:40:14 +0100
User-Agent: KMail/1.6
References: <200402041820.39742.wnelsonjr@comcast.net> <200402050454.44936.ctpm@rnl.ist.utl.pt>
In-Reply-To: <200402050454.44936.ctpm@rnl.ist.utl.pt>
Cc: kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200402051440.16116.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I saw the same messages since 2.6.2-rc2 (I didn't try any other 2.6.2
prerelease). 2.6.1 didn't do that.

On Thursday 05 February 2004 05:54, you wrote:
> 
> On Thursday 05 February 2004 02:20, Walt Nelson wrote:
> > My mouse has been acting wired occationally, not all the time. I receive
> > the following error in the syslog. This has been happening since 2.6.2-RC3.
> > I am currently using 2.6.2. Are these related?
> >
> > Feb  4 13:56:02 gumby kernel: psmouse.c: Wheel Mouse at
> > isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.
> >
> > The following occurs when starting KDE/X.
> > Feb  4 18:05:11 gumby kernel: atkbd.c: Unknown key released (translated set
> > 2, code 0x7a on isa0060/serio0).
> > Feb  4 18:05:11 gumby kernel: atkbd.c: This is an XFree86 bug. It shouldn't
> > access hardware directly.
> > Feb  4 18:05:11 gumby kernel: atkbd.c: Unknown key released (translated set
> > 2, code 0x7a on isa0060/serio0).
> > Feb  4 18:05:11 gumby kernel: atkbd.c: This is an XFree86 bug. It shouldn't
> > access hardware directly.
> >
> 
> 
>   I saw the same here yesterday, using a logitech wheel mouse:
> 
> Feb  4 18:19:46 vega kernel: psmouse.c: Wheel Mouse at isa0060/serio1/input0 
> lost synchronization, throwing 2 bytes away.
> 
>   Before this happened the mouse in X just went nuts with random clicks in 
> many windows, but after that it's been ok up to now.
> 
>   FYI the mouse is detected as: 
> 
> Feb  4 08:57:42 vega kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
> Feb  4 08:57:42 vega kernel: input: PS2++ Logitech Wheel Mouse on 
> isa0060/serio1
> 
>   The motherboard is an Intel 440BX2 with a PII-350 running kernel 2.6.2.

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAIke+FGK1OIvVOP4RAsB6AKCVznga6Q1Uo7nfSIn1LfzpYgYlFACeJYgv
8BeJSlNeI2vFlQVegtMLiyE=
=wdjy
-----END PGP SIGNATURE-----
