Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbVAaLQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVAaLQW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 06:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVAaLQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 06:16:22 -0500
Received: from 13.2-host.augustakom.net ([80.81.2.13]:18597 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S261856AbVAaLQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 06:16:17 -0500
Date: Mon, 31 Jan 2005 12:16:16 +0100
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: "Kiniger, Karl (GE Healthcare)" <karl.kiniger@med.ge.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How peek at tcp socket data w/o reading it
Message-ID: <20050131121616.1d35c69a@phoebee>
In-Reply-To: <20050131104532.GA3208@wszip-kinigka.euro.med.ge.com>
References: <20050131104532.GA3208@wszip-kinigka.euro.med.ge.com>
X-Mailer: Sylpheed-Claws 0.9.12cvs53 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=Signature_Mon__31_Jan_2005_12_16_16_+0100_HxHGgpsm_yobO0yw;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Mon__31_Jan_2005_12_16_16_+0100_HxHGgpsm_yobO0yw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 31 Jan 2005 11:45:32 +0100
"Kiniger, Karl (GE Healthcare)" <karl.kiniger@med.ge.com> bubbled:

> Hi,
>=20
> hack wanted:
>=20
> is it possible to peek a few bytes from a tcp socket which is
> ready to read without actually reading the data? (or some
> means to push already read data back similar to ungetc)

ret =3D recv(fd, buf, len, MSG_PEEK);


--=20
MyExcuse:
telnet: Unable to connect to remote host: Connection refused

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature_Mon__31_Jan_2005_12_16_16_+0100_HxHGgpsm_yobO0yw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFB/hOAmjLYGS7fcG0RAkFbAKCuVqxPQyQ+Nr/a3jrE5p48w6mbSgCgqzE9
zL1msg1nvAyW7vh2IXlKrSQ=
=/3zu
-----END PGP SIGNATURE-----

--Signature_Mon__31_Jan_2005_12_16_16_+0100_HxHGgpsm_yobO0yw--
