Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267774AbTAXQvk>; Fri, 24 Jan 2003 11:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267776AbTAXQvk>; Fri, 24 Jan 2003 11:51:40 -0500
Received: from host213-121-111-56.in-addr.btopenworld.com ([213.121.111.56]:2236
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S267774AbTAXQvf>; Fri, 24 Jan 2003 11:51:35 -0500
Subject: Re: any brand recomendation for a linux laptop ?
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: Daniel Egger <degger@fhm.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1042886952.24291.15.camel@sonja>
References: <200301161100.45552.Nicolas.Turro@sophia.inria.fr>
	<20030116104154.GL25246@pegasys.ws> <3E26BE43.6000406@walrond.org>
	<20030116144045.GC30736@work.bitmover.com>
	<20030116153727.GA27441@lug-owl.de>  <1042733652.18213.35.camel@sonja>
	<1042820273.8935.2.camel@lemsip>  <1042886952.24291.15.camel@sonja>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-a82tW3fl3Koz6D21Y3kq"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 24 Jan 2003 17:01:00 +0000
Message-Id: <1043427661.28761.16.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-a82tW3fl3Koz6D21Y3kq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-01-18 at 10:49, Daniel Egger wrote:
> I'm using 2.4.x and 2.5.x kernels; no special version.=20

heh, i cant even compile 2.5 due to old binutils in yd2.3 :P

> A few pointers:
> You might want to check /proc/sys/kernel/powersave-nap is "1".

it is

> Any suspicious messages on bootlog? (Post if in doubt)

nothing

> What CPU does it have (post /proc/cpuinfo).
cpu             : 7455, altivec supported
clock           : 667MHz
revision        : 2.1 (pvr 8001 0201)
bogomips        : 665.19
machine         : PowerBook3,4
motherboard     : PowerBook3,4 MacRISC2 MacRISC Power Macintosh
detected as     : 73 (PowerBook Titanium III)
pmac flags      : 00000003
L2 cache        : 256K unified
memory          : 512MB
pmac-generation : NewWorld

> What clocks does it support according to /proc/cpufreq?
          minimum CPU frequency  -  maximum CPU frequency  -  policy
CPU  0       667000 kHz (100 %)  -     667000 kHz (100 %)  -  powersave

> What does the pmu say? (see /proc/pmu)
PMU driver version     : 2
PMU firmware version   : 0c
AC Power               : 1
Battery count          : 1

> What does the APM emulation say (need to run pmud to get reliable
> results)?
0.5 1.1 0x00 0x01 0x00 0x01 98% -1 min

> Are the infos from the battery accurate? I need to completely empty
> the battery without pmud every now and then to make the infos realistic.

Yeah, i run pmud (@(#)$Id: pmud.c,v 1.1.1.1 2001/12/07 11:31:46
sleemburg Exp $) and battery info appears fine.

> Normally Motorola cpus turn of unused units to save power,
> you might want to check that your system is really idle;
> when running setiathome for instance my notebook also gets
> warm and the battery is draining much faster (intersting=20
> fact actually, since common belief is that the current drawn
> by processor is far less that the sum of all other components).

I appear to get nothing like this, if i pull my power out with a full
battery the PMU says I have 152 mins of battery power (which seems about
right). I even ran the battery completely flat and recharged it as
suggested when I first got the laptop.

The whole of the laptop is warm, esp. around the CPU which is hot to the
touch all the time, even when the CPU is idling.

?!?!

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-a82tW3fl3Koz6D21Y3kq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+MXFMkbV2aYZGvn0RApUQAJ0U5+rJQ4Ny0glViBkTbiI7yy1JNwCcDbqu
m3GrM7rq3nqFHj3lSk4Pr+Q=
=Z15k
-----END PGP SIGNATURE-----

--=-a82tW3fl3Koz6D21Y3kq--

