Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264630AbTARKmB>; Sat, 18 Jan 2003 05:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264631AbTARKmA>; Sat, 18 Jan 2003 05:42:00 -0500
Received: from B57cc.pppool.de ([213.7.87.204]:22408 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S264630AbTARKl7>; Sat, 18 Jan 2003 05:41:59 -0500
Subject: Re: any brand recomendation for a linux laptop ?
From: Daniel Egger <degger@fhm.edu>
To: Gianni Tedesco <gianni@ecsc.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1042820273.8935.2.camel@lemsip>
References: <200301161100.45552.Nicolas.Turro@sophia.inria.fr>
	 <20030116104154.GL25246@pegasys.ws> <3E26BE43.6000406@walrond.org>
	 <20030116144045.GC30736@work.bitmover.com>
	 <20030116153727.GA27441@lug-owl.de>  <1042733652.18213.35.camel@sonja>
	 <1042820273.8935.2.camel@lemsip>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-p1ZWiEoSuyMjxQ6lto19"
Organization: 
Message-Id: <1042886952.24291.15.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 18 Jan 2003 11:49:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-p1ZWiEoSuyMjxQ6lto19
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Fre, 2003-01-17 um 17.17 schrieb Gianni Tedesco:

> I have a G4 667 powerbook titanium III and the battery life is very poor
> (around 2hrs) it gets very hot, I think its a kernel problem. Which
> kernel do you use, could you send me your config off list perhaps?

I'm using 2.4.x and 2.5.x kernels; no special version.=20

A few pointers:
You might want to check /proc/sys/kernel/powersave-nap is "1".
Any suspicious messages on bootlog? (Post if in doubt)

What CPU does it have (post /proc/cpuinfo).
What clocks does it support according to /proc/cpufreq?
What does the pmu say? (see /proc/pmu)
What does the APM emulation say (need to run pmud to get reliable
results)?
Are the infos from the battery accurate? I need to completely empty
the battery without pmud every now and then to make the infos realistic.

Normally Motorola cpus turn of unused units to save power,
you might want to check that your system is really idle;
when running setiathome for instance my notebook also gets
warm and the battery is draining much faster (intersting=20
fact actually, since common belief is that the current drawn
by processor is far less that the sum of all other components).



--=20
Servus,
       Daniel

--=-p1ZWiEoSuyMjxQ6lto19
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+KTEochlzsq9KoIYRAiBUAJ9r3crEOf0OwJCOzhb+3i5MplGKQACgsrNJ
IvicIM5C4tAhXUsyi7hYUhk=
=4RPm
-----END PGP SIGNATURE-----

--=-p1ZWiEoSuyMjxQ6lto19--

