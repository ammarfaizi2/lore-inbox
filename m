Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286868AbRLWLiS>; Sun, 23 Dec 2001 06:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286873AbRLWLiH>; Sun, 23 Dec 2001 06:38:07 -0500
Received: from smtpsrv1.isis.unc.edu ([152.2.1.138]:33746 "EHLO
	smtpsrv1.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S286868AbRLWLhz>; Sun, 23 Dec 2001 06:37:55 -0500
Date: Sun, 23 Dec 2001 06:37:33 -0500
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17] net/network.o(.text.lock+0x1a88): undefined reference to `local symbols...
Message-ID: <20011223113733.GA26429@opeth.ath.cx>
In-Reply-To: <Pine.LNX.4.33.0112231226260.1032-100000@doom.bastun.net> <23624.1009106899@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <23624.1009106899@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.24i
From: Dan Chen <crimsun@email.unc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 23, 2001 at 10:28:19PM +1100, Keith Owens wrote:
> AFAICT dmfe.c is hotplug aware, it has the required probe and remove
> pci_driver functions.  But dmfe_remove_one is defined as __exit instead
> of __devexit, it should probably be changed to __devexit and change
>         remove: dmfe_remove_one
> to
>         remove:         __devexit_p(dmfe_remove_one)
>=20
> The dmfe maintainer and/or Jeff Garzik needs to decide.

This is one of the hunks I submitted and is in .17-rc2 but was
removed (along with a bunch of incorrect ones I did, oops) in
-final.

--=20
Dan Chen                 crimsun@email.unc.edu
GPG key:   www.unc.edu/~crimsun/pubkey.gpg.asc

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8JcH9MwVVFhIHlU4RApTgAJ4qNlvKgYJmoPPmXocAu1EgONyGjwCfZiL2
lauj/mZXs6AWbJU7xRu4KVo=
=LYCy
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
