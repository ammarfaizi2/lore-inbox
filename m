Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281172AbRKEOyF>; Mon, 5 Nov 2001 09:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281171AbRKEOxt>; Mon, 5 Nov 2001 09:53:49 -0500
Received: from [195.228.174.203] ([195.228.174.203]:6665 "EHLO trinity")
	by vger.kernel.org with ESMTP id <S281173AbRKEOxf>;
	Mon, 5 Nov 2001 09:53:35 -0500
Date: Mon, 5 Nov 2001 15:51:38 +0100
From: Szabolcs Gyurko <szgyurko@mail.inno.hu>
To: linux-kernel@vger.kernel.org
Subject: drivers/net/fealnx.c error
Message-ID: <20011105155137.B28689@morpheus>
Reply-To: szgyurko@mail.inno.hu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

there are an error in the 2.4.13 (i think the newest) kernel at the=20
drivers/net/fealnx.c file at the 1818 line. The original line:

static struct pci_device_id fealnx_pci_tbl[] =3D __devinitdata {

and the fixed line:

static struct pci_device_id fealnx_pci_tbl[] __devinitdata =3D {


I didn't make a patch of it, so please fix it.


Bye.

--=20
    -- If vegetable oil is made of vegetables, what is baby oil made of? --
--
Szabolcs Gyurko
szgyurko@mail.inno.hu
----------------------------------------------------------------------------
PGP-KEY:         http://raidder.development.inno.hu/~raidder/raidder.gpg
PGP-FINGERPRINT: 5099 0850 CF6D EFBF A574  5930 E8DA 51AA DF87 2D24


--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE75qd56NpRqt+HLSQRAh8uAJ0f2aA67zoScSbs3AVrpU5cnN36wQCgpcmf
ppqQQrCqERStFalGjwEUZmc=
=zwZC
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
