Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264206AbUFOIdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264206AbUFOIdg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 04:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbUFOIdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 04:33:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36746 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264206AbUFOIdc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 04:33:32 -0400
Subject: Re: Does exec-shield with -fpie  work?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1087286723.3156.35.camel@pc-16.office.scali.no>
References: <1087286723.3156.35.camel@pc-16.office.scali.no>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zVY/TANHX+0QFkajmYqf"
Organization: Red Hat UK
Message-Id: <1087288401.2710.15.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 15 Jun 2004 10:33:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zVY/TANHX+0QFkajmYqf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> te pc-16 ~ 70> !gcc
> gcc -fPIE -fpic -o ./testsc ./testsc.c
>=20

you need to pass -pie as option as well; -fpie for the compiler, -pie for t=
he linker,
eg

gcc -fPIE -pie -o ./testsc ./testsc.c


--=-zVY/TANHX+0QFkajmYqf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAzrRQxULwo51rQBIRAjZRAKCUgRDwBUCVU7T2ifoBKWPNMz0feQCeMgt2
rQtW5f0umgb3wczzGEUhKgo=
=pSYP
-----END PGP SIGNATURE-----

--=-zVY/TANHX+0QFkajmYqf--

