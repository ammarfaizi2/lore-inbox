Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266998AbTBXNSU>; Mon, 24 Feb 2003 08:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267013AbTBXNST>; Mon, 24 Feb 2003 08:18:19 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:36335 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S266998AbTBXNST>; Mon, 24 Feb 2003 08:18:19 -0500
Subject: Re: Question on scsi disk driver
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: vijaysrinath@lycos.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <AFIFLLKIMJDOIDAA@mailcity.com>
References: <AFIFLLKIMJDOIDAA@mailcity.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ljZFbqeLbMufTHr6bSz3"
Organization: 
Message-Id: <1046093306.1709.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 24 Feb 2003 14:28:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ljZFbqeLbMufTHr6bSz3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-02-24 at 13:58, vijay srinath wrote:
> hello all,
>=20
> 	Iam running Linux Kernel 2.4.9. I have a disk array with a more than 128=
 luns. Since the maximum number of disk luns that sd driver can see is 128,=
 i expected to see atleast 128. But i noticed that i was not able to access=
 any lun at all.
> 	I investigated further and saw that sd_init() in sd.c was returning a fa=
ilure. This was because the code where memory is alloc'd for 'hd_struct' st=
ructures was failing. The code snippet is below

if you are running a RHL kernel you need to upgrade to the latest
erratum kernel (2.4.18-24.x.y) which has support for 256 scsi disks.


--=-ljZFbqeLbMufTHr6bSz3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+Wh36xULwo51rQBIRAt8EAJwODGhW7iow13YOky20tFPlleRFewCfRqOG
0bz/W0wnsXUqCiHN/DU6jXY=
=aJAr
-----END PGP SIGNATURE-----

--=-ljZFbqeLbMufTHr6bSz3--
