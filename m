Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267944AbTBVW4r>; Sat, 22 Feb 2003 17:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267948AbTBVW4r>; Sat, 22 Feb 2003 17:56:47 -0500
Received: from mx2.it.wmich.edu ([141.218.1.94]:39080 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id <S267944AbTBVW4p> convert rfc822-to-8bit;
	Sat, 22 Feb 2003 17:56:45 -0500
Reply-To: <camber@yakko.cs.wmich.edu>
From: "Edward Killips" <camber@yakko.cs.wmich.edu>
To: "Toplica Tanaskovic" <toptan@EUnet.yu>,
       "Dave Jones" <davej@codemonkey.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: AGP backport from 2.5 to 2.4.21-pre4
Date: Sat, 22 Feb 2003 18:07:46 -0500
Message-ID: <JJEJKAPBMJAOOFPKFDFKKEKACEAA.camber@yakko.cs.wmich.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <200302220716.54218.toptan@EUnet.yu>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The apeture is now set correctly. The ATI 4.2.0-2.5.1 drivers don't work but I 
think that is a dri problem. Everything works fine with the vesa drivers using XFree86 4.2.99.

- -Edward Killips

- -----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Toplica
Tanaskovic
Sent: Saturday, February 22, 2003 1:21 AM
To: Dave Jones
Cc: linux-kernel@vger.kernel.org
Subject: Re: AGP backport from 2.5 to 2.4.21-pre4


Dana petak 21. februar 2003. 14:40 napisali ste:

>
> Yes. via-kt400.c was unnecessary (well, it was useful as a standalone
> whilst I was developing it) , which was why it was later merged into
> via-agp.c in 2.5.60. There were also a bunch of other fixes merged
> there, so if you based your backport on an earlier version, I suggest
> you grab those changes.
>
	Done, also fixed warnings from previous patch, and what is most important 
fixed page locking, no more segmantation faults when unloading drm module.

All test for previous patch passed for this one too, except i've now tested it 
with GA-7VRX (KT333) too.

BTW code is backported from 2.5.62.

- -- 
Pozdrav,
Tanaskovic Toplica



-----BEGIN PGP SIGNATURE-----
Version: PGP 8.0

iQA/AwUBPlgCwXg7wzlNS3haEQIa+wCgghCr47gdTARzeQ60vLYypWZQPuMAn2S0
Wndxm6BEpA0t8o23iL6SaLz8
=sQHD
-----END PGP SIGNATURE-----

