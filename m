Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319079AbSIDGaK>; Wed, 4 Sep 2002 02:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319080AbSIDGaK>; Wed, 4 Sep 2002 02:30:10 -0400
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:27950 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S319079AbSIDGaJ>;
	Wed, 4 Sep 2002 02:30:09 -0400
Date: Wed, 4 Sep 2002 08:34:37 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __func__ in 2.5.33?
Message-ID: <20020904083436.A26538@jaquet.dk>
References: <20020903225229.A24108@jaquet.dk> <3D752E38.EF352F48@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D752E38.EF352F48@zip.com.au>; from akpm@zip.com.au on Tue, Sep 03, 2002 at 02:48:40PM -0700
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2002 at 02:48:40PM -0700, Andrew Morton wrote:
> The parenthesised (__func__) is there to force you to not try to
> perform this string pasting.  Support for __FUNCTION__ pasting is
> being phased out of gcc.
>=20
> You need:
>=20
> #define func_enter() sx_dprintk (SX_DEBUG_FLOW, "sx: enter %s\n", __FUNCT=
ION__)

Ah, OK. I apparently missed the part about the pasting part
being phased out, alongside missing Paul Larson's patch.

Thanks to both of you,
  Rasmus

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9dal8lZJASZ6eJs4RAkRUAJ94D9rCMc2L1N8YSGX8+xYhDUE3bQCeJUd9
5QZjpAfsmC9GzOaja5TiU4Y=
=x0c9
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
