Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261158AbREUMDy>; Mon, 21 May 2001 08:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261159AbREUMDo>; Mon, 21 May 2001 08:03:44 -0400
Received: from lenka.ph.ipex.cz ([212.71.128.11]:30280 "EHLO lenka.ph.ipex.cz")
	by vger.kernel.org with ESMTP id <S261158AbREUMDe>;
	Mon, 21 May 2001 08:03:34 -0400
Date: Mon, 21 May 2001 14:04:43 +0200
From: Robert Vojta <vojta@ipex.cz>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3c905C-TX [Fast Etherlink] problem ...
Message-ID: <20010521140443.C8397@ipex.cz>
In-Reply-To: <20010521090946.D769@ipex.cz> <3B08C15E.264AE074@uow.edu.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Content-Disposition: inline
In-Reply-To: <3B08C15E.264AE074@uow.edu.au>
User-Agent: Mutt/1.3.18i
X-Telephone: +420 603 167 911
X-Company: IPEX, s.r.o.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This is a `transamit reclaim' error.  It is almost always
> caused by this host being in half-duplex mode, and another
> host on the network being in full-duplex mode.

Hi,
  I tried to force this to be in fullduplex mode by options=3D0x204 (0x200 =
+ 0x4)
and it works fine now. Please, can you send me some points to the documenta=
tion
where I can read more info about 'transamit reclaim' error and why this
happens, etc ...

Best regards,
  .R.V.

--=20
   _
  |-|  __      Robert Vojta <vojta-at-ipex.cz>          -=3D Oo.oO =3D-
  |=3D| [Ll]     IPEX, s.r.o.
  "^" =3D=3D=3D=3D`o

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjsJBFoACgkQInNB3KDLeVOFDgCdHijQCOfcyL6h2kf/uAgC+SVi
bmAAnj4AG1mcWttfs/WrCgQ8i1c8E39c
=p5mz
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
