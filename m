Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265300AbUAJSRJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 13:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265301AbUAJSRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 13:17:09 -0500
Received: from wblv-238-222.telkomadsl.co.za ([165.165.238.222]:56199 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265300AbUAJSRE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 13:17:04 -0500
Subject: Re: Q re /proc/bus/i2c
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: John Lash <jlash@speakeasy.net>
Cc: gene.heskett@verizon.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040110095911.7b99d40c.jlash@speakeasy.net>
References: <200401100117.42252.gene.heskett@verizon.net>
	 <3FFF59A0.2080503@clanhk.org> <200401100754.47752.gene.heskett@verizon.net>
	 <20040110095911.7b99d40c.jlash@speakeasy.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fUCoDA+WJwZBMbXnb1Kp"
Message-Id: <1073758800.9096.12.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 10 Jan 2004 20:20:00 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fUCoDA+WJwZBMbXnb1Kp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-01-10 at 17:59, John Lash wrote:
> In a 2.6.x kernel, the sensors information is kept in sysfs. I haven't ac=
tually
> tried installing lmsensors on my 2.6 system, but if I look in:
> 	/sys/bus/i2c/devices/0-002d/
> I can see files for all of the sensors on my system.=20
>=20
> Check below in your last mail where it is complaining about "Algorithm:
> Unavailable from sysfs".=20
>=20

Right, needs sysfs mounted.  You should (after creating /sys) add
the following to /etc/fstab:

--
none	/sys	sysfs	defaults	0 0
--


--=20
Martin Schlemmer

--=-fUCoDA+WJwZBMbXnb1Kp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAAEJPqburzKaJYLYRAgdmAJ9a4ZbCa9qKnOIhOxPr+wzHFDJdGACdH76t
sSKF3VhfT072F+36JOYN3R8=
=qYec
-----END PGP SIGNATURE-----

--=-fUCoDA+WJwZBMbXnb1Kp--

