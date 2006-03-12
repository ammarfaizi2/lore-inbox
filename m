Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWCLNMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWCLNMK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 08:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWCLNMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 08:12:10 -0500
Received: from h41n1c1o1031.bredband.skanova.com ([213.65.32.41]:46034 "EHLO
	nexon.borjesson.homedns.org") by vger.kernel.org with ESMTP
	id S1750732AbWCLNMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 08:12:09 -0500
Date: Sun, 12 Mar 2006 14:12:07 +0100
From: Patrick =?utf-8?Q?B=C3=B6rjesson?= <psycho@rift.ath.cx>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: PROBLEM: kernel BUG at mm/rmap.c:486 - kernel 2.6.15-r1
Message-ID: <20060312131207.GB17615@nexon>
References: <20060312000621.GA8911@nexon> <1142154323.2882.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
In-Reply-To: <1142154323.2882.12.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2006-03-12 10:05, Arjan van de Ven uttered these thoughts:
> On Sun, 2006-03-12 at 01:06 +0100, Patrick =3D?utf-8?Q?B=3DF6rjesson?=3D
> wrote:
> > > Just to let you know, I've had the same problem on x86-64. It's an
> > > incredibly rare fault here and I've not been able to reproduce it.
> > > However, I cannot help but notice that all of the reporters so far
> > > have been running the binary NVIDIA driver, including myself.
> > >=20
> > > I would not be surprised if running without the NVIDIA driver
> > > eliminated the problem.
> >=20
> > Not running either with the NVIDIA driver or with x86-64 on the machine
> > I'm getting this on, but I get it fairly often (as in: today I've
> > probably gotten it at least 5-10 times). It seems it's pretty bound by
> > either high CPU or disk usage, since I've always gotten it while
> > compiling stuff so far. Although my system doesn't hard lock if I get
> > this error; I can at least run most commands and ssh into it.
>=20
>=20
> just to rule the last issue out: this machine survives memtest86 ?

I'm sorry to have wasted your time; no, it didn't =3D\=20
Didn't think to run it before since the mem-stick in the machine is
pretty new (not more than 2 months).=20

Sorry again,
Patrick B=C3=B6rjesson

--=20
/  ()  The ASCII Ribbon Campaign - against HTML Email
\  /\   and proprietary formats.

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFEFB4nzbh2ByF5Kl0RArG2AKC2NQUosLgA5NrPLNFD0wN3I3833QCgis1b
NKT51smBZdKpcwI5ePmPnJc=
=KZGC
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
