Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271857AbRIVRUW>; Sat, 22 Sep 2001 13:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271861AbRIVRUM>; Sat, 22 Sep 2001 13:20:12 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:59521 "EHLO softhome.net")
	by vger.kernel.org with ESMTP id <S271857AbRIVRUI>;
	Sat, 22 Sep 2001 13:20:08 -0400
From: "John L. Males" <jlmales@softhome.net>
Organization: Toronto, Ontario, Canada
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sat, 22 Sep 2001 13:20:27 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re[03]: Linux Kernel 2.2.20-pre10 Initial Impressions
Reply-to: jlmales@softhome.net
CC: linux-kernel@vger.kernel.org
Message-ID: <3BAC901B.4963.5A1874@localhost>
In-Reply-To: <3BA7D82D.21744.63CF95@localhost> from "John L. Males" at Sep 18, 2001 11:26:37 PM
In-Reply-To: <E15kpkm-0003dx-00@the-village.bc.nu>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Alan,


Subject:        	Re: Linux Kernel 2.2.20-pre10 Initial Impressions
To:             	jlmales@softhome.net
Date sent:      	Sat, 22 Sep 2001 17:35:44 +0100 (BST)
Copies to:      	linux-kernel@vger.kernel.org
From:           	Alan Cox <alan@lxorguk.ukuu.org.uk>

> > Ok, I finially had a chance to compile the 2.2.20-pre10 Kernel
> > and run it though some basic paces.  I need to do more specific A
> > vs b (against the 2.2.19 Kernel), but it seems there are some
> > performance issues.  It is seems especially obvious with Netscape
> > 4.78.  I also had a odd Xfree error, that may have had some
> > relationship to the performance issue.  I have to say at this
> > point the issue seems selective and not a general one, but I need
> > to do a bit more
> > checking.  I cannot forsee this checking happening until this
> > weekend.
> 
> There are to all intents no VM changes of any kind between 2.2.19
> and 2.2.20pre10, so it would be interesting to compare configure
> options and see what else might be different


Understood, but I actually took my 2.2.19 .config and ran "make
oldconfig", then "make xconfig" making no changes, just saved it
based on prior experience, then the usual "make dep bzImage modules
modules_install install" etc, you know that drill all too well.  I
seem to recall there was one new item while oldconfig was running. 
Cannot rememeber what it was.  I do remember replying to make it a
module.

I am likely to do the benchmark tonight to get hard numbers on the
difference I sense.  I am a QA/Testing Specialist, so I am all to
aware of the importance of keeping the variables all the same.  My
initial background was with assembler back in the real core
memory/keypunch days where I disassembled and heavily modified the
OS, compiler, assembler, system utilities and wrote a new way to load
the OS, compilers, etc from scratch to a new disk.  Ony advising you
so you have a sense of my mindset and level of understanding.  Not
current with intimate x86 details or assembler, but will someday now
that "falt" memory is back! :))

I will let you know what I find.  If in meantime you feel there are
other things needed or for me to check please let me know and I will
be most happy to assist.


Regards,

John L. Males
Willowdale, Ontario
Canada
22 September 2001 13:20
mailto:jlmales@softhome.net

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 6.5.8 for non-commercial use 
<http://www.pgp.com>

iQA/AwUBO6zWZOAqzTDdanI2EQLOpgCfZblo3fb0aiCHWdPJFGAo7AtocHcAoNb0
bxJs+70lRt/chENPA3UAq2RO
=ZlsF
-----END PGP SIGNATURE-----



"Boooomer ... Boom Boom, how are you Boom Boom" Boomer 1985 - February/2000
