Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVARWzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVARWzv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 17:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVARWzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 17:55:51 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:26320 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S261461AbVARWzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 17:55:40 -0500
Subject: [ANNOUNCEMENT] Collision regression test suite released
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-security-module@wirex.com" <linux-security-module@wirex.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ak9sIbunSFLYOcDu62h7"
Date: Tue, 18 Jan 2005 23:55:08 +0100
Message-Id: <1106088908.3832.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ak9sIbunSFLYOcDu62h7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Past days I wrote about a regression test suite which i used to explain
why a grsecurity-like security improvement could be good for mainline
inclusion, and also, that at least the 50% of the faults it shows on
Vanilla sources could be solved without major blocking issues (aka big
deals, whatever else).

I've released the code, so, everybody could mess it up and send me
patches with fixes, enhancements, extra features or better source
comments ;)

The source code is available at
http://cvs.tuxedo-es.org/cgi-bin/viewcvs.cgi/collision-rts/.

An example results log dumped by it when running on a default Vanilla
kernel (no security patches, etc) can be found at:
http://cvs.tuxedo-es.org/cgi-bin/viewcvs.cgi/collision-rts/results/vanilla-=
2.6-default.log?rev=3D1.1.1.1&view=3Dlog


In the forthcoming days i will try to add more tests to it, mainly
related with capabilities and such, for SELinux and LSM testing.
Also, maybe an ExecShield specific test (see [1] and [2]) and possibly a
few other tests related with BSD Jails.

I would like to have feedback about it, but it's main goal is to show
that there are still some security "faults" that affect users of Vanilla
sources that can be solved without a lot of pain and could represent a
start for those who want better security worked on many time before me
and have been ignored or just left working alone and independently.

The suite has some tests related with "toolchain" hardening, but most
stuff is kernel-related.

Hopefully it will be useful, so, enjoy.

References:
[1]: http://212.130.50.194/papers/attack/ExploitingFedora.txt
[2]: http://phrack.org/phrack/56/p56-0x05
[3]: http://phrack.org/phrack/58/p58-0x04

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org> [1024D/6F2B2DEC]
[2048g/9AE91A22] Hardened Debian head developer & project manager

--=-ak9sIbunSFLYOcDu62h7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB7ZPMDcEopW8rLewRApj/AKDIc55cuHWhJP2SFO6LDMxdJOk9KgCg16BC
v5OQrznq2zapGBKy+ZC8Mfc=
=iXSL
-----END PGP SIGNATURE-----

--=-ak9sIbunSFLYOcDu62h7--

