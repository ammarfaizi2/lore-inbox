Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbTATHO1>; Mon, 20 Jan 2003 02:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261368AbTATHO1>; Mon, 20 Jan 2003 02:14:27 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:10509 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S261330AbTATHO0>;
	Mon, 20 Jan 2003 02:14:26 -0500
Date: Mon, 20 Jan 2003 08:23:29 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: CD Changer
Message-ID: <20030120072329.GI30184@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <002c01c2c001$f36db9f0$0a01a8c0@aaprilhome>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lqaZmxkhekPBfBzr"
Content-Disposition: inline
In-Reply-To: <002c01c2c001$f36db9f0$0a01a8c0@aaprilhome>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
x-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
x-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lqaZmxkhekPBfBzr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-01-19 16:30:12 -0500, Alexandre April <alexandre.april@sympati=
co.ca>
wrote in message <002c01c2c001$f36db9f0$0a01a8c0@aaprilhome>:
> 	I need to be able to export all 4 of my CDR-251 4x4 CD Changer
> using NFS or SAMBA. I found some way to do it but never been able to
> accomplish it, cause of older kernel. I'm running on a 2.4.18-14 kernel.

I used to use a 7way CD-Changer (a SCSI model) over years. It's quite
simple, no patches requited. I simply had to switch on "Scan all LUNs"
in kernel's config. Then, all four slots appear as separate devices so
you can mount them all (in parallel) and share them (by NFS/SMB/...).
However, because there's actually only one CD drive inside the box,
persormance suck mountains is you access two (or more) CDs at a time,
because they're constantly swapped...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet!
   Shell Script APT-Proxy: http://lug-owl.de/~jbglaw/software/ap2/

--lqaZmxkhekPBfBzr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+K6PxHb1edYOZ4bsRAmLlAJ9CGx26vJe45FUSqE8qrtqGplwxJwCgjvm/
yfkr2FDDCurWmZ0u2vWEXzU=
=vZPM
-----END PGP SIGNATURE-----

--lqaZmxkhekPBfBzr--
