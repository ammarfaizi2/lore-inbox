Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267072AbTAZXnX>; Sun, 26 Jan 2003 18:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267079AbTAZXnX>; Sun, 26 Jan 2003 18:43:23 -0500
Received: from B5784.pppool.de ([213.7.87.132]:15251 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S267072AbTAZXnV>; Sun, 26 Jan 2003 18:43:21 -0500
Subject: Re: any brand recomendation for a linux laptop ?
From: Daniel Egger <degger@fhm.edu>
To: Gianni Tedesco <gianni@ecsc.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1043427661.28761.16.camel@lemsip>
References: <200301161100.45552.Nicolas.Turro@sophia.inria.fr>
	 <20030116104154.GL25246@pegasys.ws> <3E26BE43.6000406@walrond.org>
	 <20030116144045.GC30736@work.bitmover.com>
	 <20030116153727.GA27441@lug-owl.de>  <1042733652.18213.35.camel@sonja>
	 <1042820273.8935.2.camel@lemsip>  <1042886952.24291.15.camel@sonja>
	 <1043427661.28761.16.camel@lemsip>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7ir16DAleeI1r+UhsA1l"
Organization: 
Message-Id: <1043623577.22621.14.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 27 Jan 2003 00:26:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7ir16DAleeI1r+UhsA1l
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Fre, 2003-01-24 um 18.01 schrieb Gianni Tedesco:

> heh, i cant even compile 2.5 due to old binutils in yd2.3 :P

Get a decent distribution. :)

> > What CPU does it have (post /proc/cpuinfo).
> cpu             : 7455, altivec supported
> clock           : 667MHz
> revision        : 2.1 (pvr 8001 0201)
> bogomips        : 665.19
> machine         : PowerBook3,4
> motherboard     : PowerBook3,4 MacRISC2 MacRISC Power Macintosh
> detected as     : 73 (PowerBook Titanium III)
> pmac flags      : 00000003
> L2 cache        : 256K unified
> memory          : 512MB
> pmac-generation : NewWorld

2.4.20-benh1 doesn't know about this version of the cpu.

> > What clocks does it support according to /proc/cpufreq?
>           minimum CPU frequency  -  maximum CPU frequency  -  policy
> CPU  0       667000 kHz (100 %)  -     667000 kHz (100 %)  -  powersave

Strange. Either the kernel couldn't find the allowed frequencies for
scaling or the cpu doesn't support it.

> I appear to get nothing like this, if i pull my power out with a full
> battery the PMU says I have 152 mins of battery power (which seems about
> right).

152 is nothing....

> The whole of the laptop is warm, esp. around the CPU which is hot to the
> touch all the time, even when the CPU is idling.

This is not normal. Since the kernel doesn't know either the usable
frequencies, your version of the cpu and no doze mode is available
for this type, your energy savings are almost nil at the moment and this
should definitely be rectified. I cannot imagine Apple built a CPU into
a PowerBook which doesn't support some kind of throttling, because it
would kill their statement under their OS, too.

Unfortunately I'll have a whole bunch of nasty tests the following week
and thus cannot check back with the manuals at the moment; feel free to
send me a reminder in a week or so.

--=20
Servus,
       Daniel

--=-7ir16DAleeI1r+UhsA1l
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+NG6Zchlzsq9KoIYRAg2FAKCqKpd/qhmtWt+5O9p3cV6YAs2OxgCeMkNs
7egKVFnjirkzrSNVewz3VGE=
=t+CH
-----END PGP SIGNATURE-----

--=-7ir16DAleeI1r+UhsA1l--

