Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWGLQEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWGLQEX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWGLQEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:04:23 -0400
Received: from mta05.mail.t-online.hu ([195.228.240.88]:51432 "EHLO
	mta05.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S1751437AbWGLQEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:04:22 -0400
Subject: Re: Fix prctl privilege escalation (CVE-2006-2451)
From: Gabor MICSKO <gmicsko@szintezis.hu>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1152702720.14173.9.camel@localhost>
References: <1152702720.14173.9.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Ksm7o9i7L3uMS2oSA8uz"
Date: Wed, 12 Jul 2006 18:04:18 +0200
Message-Id: <1152720258.4457.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ksm7o9i7L3uMS2oSA8uz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Already fixed since 07/06/2006:

http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/linux-2.6.17.y.git;a=
=3Dcommit;h=3D0af184bb9f80edfbb94de46cb52e9592e5a547b0
http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/linux-2.6.17.y.git;a=
=3Dcommitdiff;h=3D0af184bb9f80edfbb94de46cb52e9592e5a547b0;hp=3D52cbb7b7899=
4ea3799f1bbb8c03bce1e2f72a271

On Wed, 2006-07-12 at 13:12 +0200, Marcel Holtmann wrote:
> Hi Linus,
>=20
> attached is the fix with full explanation for CVE-2006-2451. It fixes a
> possible privilege escalation through the prctl() system call.
>=20
> I also put Michael Kerrisk on CC, because the manual page of prctl()
> needs adjustment. The value 2 for the PR_SET_DUMPABLE flag is no longer
> valid after this patch. The only way to get root-owned core dumps is
> through /proc/sys/fs/suid_dumpable and the manual page should reflect
> that.
>=20
> Regards
>=20
> Marcel

--=20
Micsk=C3=B3 G=C3=A1bor
HP APS, AIS, ASE
Szint=C3=A9zis ZRt.
H-9023 Gy=C5=91r, Tihanyi =C3=81. u. 2.
Tel: +36 96 502 216
Fax: +36 96 318 658
E-mail: gmicsko@szintezis.hu

--=-Ksm7o9i7L3uMS2oSA8uz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEtR2Co75Oas+VX1ARAkAaAJ98YdFM8P+ZgDvCii0YqKICsCDdjQCcDoC/
uKDorLBSMg6gJcEbyMmO10o=
=iHVy
-----END PGP SIGNATURE-----

--=-Ksm7o9i7L3uMS2oSA8uz--

