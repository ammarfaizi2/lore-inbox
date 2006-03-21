Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWCURaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWCURaU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWCURaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:30:19 -0500
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:3022 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932314AbWCURaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:30:16 -0500
Message-ID: <442037D2.7060109@comcast.net>
Date: Tue, 21 Mar 2006 12:28:50 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: David Vrabel <dvrabel@cantab.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Lifetime of flash memory
References: <44203179.3090606@comcast.net> <44203468.9060806@cantab.net>
In-Reply-To: <44203468.9060806@cantab.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



David Vrabel wrote:
> John Richard Moser wrote:
>> The question I have is, is this really significant?  I have heard quoted
>> that flash memory typically handles something like 3x10^18 writes;
> 
> That's like, uh, 13 orders of magnitudes out...
> 

Yeah I did more searching, it looks like that was a mass overstatement.
 There was one company that did claim to have developed flash memory
with that size (I think it was 3.8x10^18) but it looks like typical
drives are 1.0x10^6 with an on-chip wear-leveling algorithm.  Assuming
the drive is like 256 megs with 64k blocks, that's still 129 years at
one write per second.

Bigger drives of course level over larger area and lifetime increases
linearly.  My 512M drive should last 260 years in that scheme; a 4 gig
iPod Nano would last 2080 years; and a 30GiB flash-based hard disk in a
Samsung laptop on a single control chip doing the wear leveling over
multiple NAND chips would last 15600 years.

In theory anyway.  And assuming one write on one block per one second on
average for the duration.  (obviously the iPod nano sustains many times
less than that and will last hundreds of thousands of years in normal
usage).


> David Vrabel
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                                     -- Evil alien overlord from Blasto
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRCA30As1xW0HCTEFAQIELQ//TjtHD2EIh+DphWoe10MyAwt/MsWjdJEL
UWir35umv6gta6tnv4cI92PquSMAzyqeGcEe5l1Yhi9nGTe5jWqiiwxg8tVfaecq
Lf04pt53N9nVYR+lGd7DxDEq3ZCYeQKcE1hY3pnP3IHEnayfEHGl6zb8rTWEeKxm
o6miFUQoxVOXqcTHD8bLLJAJcTBsLn1IO6gAS9/WA4tvTYo4471E0m+ORY7WgFYK
/3fpq5a+PgbKkcTjRJdODaxhAROIjElwkTCPtjr/3wpjelOl1BpuTRzl8HxpAmEN
9Ybnophs6SnLeccE2WIW6PNC/cjgkyiZigOLE0EWBflJaM5ij9ZeW7Ju/FSxjhYK
e2YB6SrREFJ4Gs4eXOvzPy658JE+kbr1OtO3TIfJFykGY2tTsBvtKPvWGdFx2IJt
Znp+4vNcOtCO8Wd7uoMv+Sewk7AmqSpB5VPt64UZqGudM94Z3YDkdnUM7FjLkeng
ank4DFmzjKln2etmDo+25orQbSbPxR8UNRuWJCjOS0NTNN57fiMyIsqsSFFcuqsO
Ud8fwqvsrSLhXs1xzSxsWMvcZm/RsAgvOPAp+oajCjLVEvP2alRoLtu/yGmRgwEk
e2+Sa1zrAh2qZv2az0JLVr3gWfjRoKcn39QkF9rmiNpmr3Rf6Jx8PYjF1jYN2UDt
3j34unpH2gM=
=sTVH
-----END PGP SIGNATURE-----
