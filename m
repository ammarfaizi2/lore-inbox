Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262822AbSIUUYu>; Sat, 21 Sep 2002 16:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262888AbSIUUYu>; Sat, 21 Sep 2002 16:24:50 -0400
Received: from h24-68-71-10.vc.shawcable.net ([24.68.71.10]:41988 "EHLO
	kruhftwerk.dyndns.org") by vger.kernel.org with ESMTP
	id <S262822AbSIUUYt>; Sat, 21 Sep 2002 16:24:49 -0400
Date: Sat, 21 Sep 2002 13:29:57 -0700
From: Burton Samograd <kruhft@kruhft.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] fix .text.exit error in tdfxfb.c
Message-ID: <20020921202957.GQ22811@kruhft.dyndns.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.NEB.4.44.0209212214010.10334-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6yHiY5vv/BiPjcMt"
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0209212214010.10334-100000@mimas.fachschaften.tu-muenchen.de>
X-GPG-key: http://kruhftwerk.dyndns.org/kruhft.pubkey.asc
X-Operating-System: Linux kruhft.dyndns.org 2.4.19-gentoo-r9 
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6yHiY5vv/BiPjcMt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2002 at 10:17:36PM +0200, Adrian Bunk wrote:
> Hi James,
>=20
> Burton Samograd reported a .text.exit error at the final linking in
> 2.5.37. The problem is that tdfxfb_remove is __devexit but the pointer to
> the function didn't use __devexit_p. The following patch fixes it:
>=20

Thanks james, that fixed the build...now lets see if it runs :)

burton
--6yHiY5vv/BiPjcMt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9jNbFLq/0KC7fYbURAoWdAJ9cqcDspPBIQtIwW4fG6unmcfLZvACcDXNH
YSm8woqwyd4gAkzGwtk0UoI=
=RXmP
-----END PGP SIGNATURE-----

--6yHiY5vv/BiPjcMt--
