Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263850AbUFDNxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUFDNxb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 09:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265782AbUFDNxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 09:53:31 -0400
Received: from hosted-by.rockingstone.nl ([213.206.77.161]:11221 "EHLO
	web1.rockingstone.nl") by vger.kernel.org with ESMTP
	id S263850AbUFDNx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 09:53:28 -0400
Date: Fri, 4 Jun 2004 15:53:26 +0200
From: Rick Jansen <rick@rockingstone.nl>
To: Daniel Egger <de@axiros.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DriveReady SeekComplete Error
Message-ID: <20040604135326.GD1684@web1.rockingstone.nl>
References: <20040604075448.GK18885@web1.rockingstone.nl> <200406040943.i549h2aG000175@81-2-122-30.bradfords.org.uk> <20040604095409.GL18885@web1.rockingstone.nl> <E0E7D4BA-B62C-11D8-B781-000A958E35DC@axiros.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <E0E7D4BA-B62C-11D8-B781-000A958E35DC@axiros.com>
User-Agent: Mutt/1.4.2.1i
X-Sysadmin-was-here: Rick Jansen (Rockingstone IT)
X-PGP-Key: http://www.rockingstone.nl/rick/pubkey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 04, 2004 at 03:41:27PM +0200, Daniel Egger wrote:
> This is usually also a bad sign, escpecially if the size is caused
> by the Error Log Structure areas.
>=20
> Please send the info of smartctl -v <device>. This should give a
> good indication of whether this is a kernel or a drive problem
> because it will show some of the internal status of the drive.
>=20
> Servus,
>       Daniel

I don't think -v is the option you mean:

smartctl version 5.30 Copyright (C) 2002-4 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=3D=3D=3D=3D=3D=3D=3D> INVALID ARGUMENT TO -v: /dev/hda <=3D=3D=3D=3D=3D=3D=
=3D=20
=3D=3D=3D=3D=3D=3D=3D> VALID ARGUMENTS ARE:
	help
	9,halfminutes
	9,minutes
	9,seconds
	9,temp
	192,emergencyretractcyclect
	193,loadunload
	194,10xCelsius
	194,unknown
	198,offlinescanuncsectorct
	200,writeerrorcount
	201,detectedtacount
	220,temp
	N,raw8
	N,raw16
	N,raw48
<=3D=3D=3D=3D=3D=3D=3D

Use smartctl -h to get a usage summary


--=20
Looking for books? Try http://www.megabooksearch.com
The Linux on 64-Bit platforms Wiki: http://www.linux64.net
PGP Public Key: http://www.rockingstone.nl/rick/pubkey.asc

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAwH7WQEtQzfDcRKoRAhn6AJ4w8HPgGSzGeCXq32ukeZDWZpDq9wCgiVh9
eRgw6VVEOex1PewqbB49dYc=
=LswQ
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
