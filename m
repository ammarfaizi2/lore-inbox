Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbTJUWjt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 18:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbTJUWjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 18:39:49 -0400
Received: from 24-216-47-96.charter.com ([24.216.47.96]:37255 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S263387AbTJUWjq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 18:39:46 -0400
Date: Tue, 21 Oct 2003 18:39:36 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Zan Lynx <zlynx@acm.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test8 and HIGMEM = segfaults and panics?
Message-ID: <20031021223936.GI2617@rdlg.net>
Mail-Followup-To: Zan Lynx <zlynx@acm.org>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20031021155337.GF2617@rdlg.net> <1066762982.5055.3.camel@localhost.localdomain> <20031021195834.GG2617@rdlg.net> <1066771573.5055.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TKDEsImF70pdVIl+"
Content-Disposition: inline
In-Reply-To: <1066771573.5055.8.camel@localhost.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TKDEsImF70pdVIl+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



I can recompile it and run it for a bit.  What debug options would be
useful for this?

When I had it enabled I had this:

# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=3Dy
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=3Dy
CONFIG_HIGHPTE=3Dy



Thus spake Zan Lynx (zlynx@acm.org):

> On Tue, 2003-10-21 at 13:58, Robert L. Harris wrote:
> > Yup, I've played musical DIMMS as well.  It's currently up running with
> > 1.5G install without the HIGMEM and I've taxed it pretty hard today
> > without issue.
> >=20
> > What kernel are you running on?
> >=20
> > They are registered.
> >=20
>=20
> Kernel 2.6.0-test8.
> It's a Tyan MPX board with 4 512MB sticks of ECC registered 266 DDR.
>=20
> Here's the highmem bit of my config file:
> # CONFIG_NOHIGHMEM is not set
> CONFIG_HIGHMEM4G=3Dy
> # CONFIG_HIGHMEM64G is not set
> CONFIG_HIGHMEM=3Dy
> CONFIG_HIGHPTE=3Dy
>=20
> So, I don't think it's a general bug.
>=20
> --=20
> Zan Lynx <zlynx@acm.org>



:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--TKDEsImF70pdVIl+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/lbWo8+1vMONE2jsRAt2+AKDdqbTMbcrNg5Pz5XgMBcOf276S2ACfVDLG
8ytmOq9e/th2JfGT9H1hEIk=
=503q
-----END PGP SIGNATURE-----

--TKDEsImF70pdVIl+--
