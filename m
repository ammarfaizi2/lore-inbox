Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbVJDHaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbVJDHaJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 03:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVJDHaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 03:30:09 -0400
Received: from wg.technophil.ch ([213.189.149.230]:5808 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S932467AbVJDHaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 03:30:07 -0400
Date: Tue, 4 Oct 2005 09:30:07 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: coywolf@lovecn.org
Cc: Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
Subject: Re: halt: init exits/panic
Message-ID: <20051004073007.GA2032@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	coywolf@lovecn.org, linux-kernel@vger.kernel.org
References: <20050709151227.GM1322@schottelius.org> <2cd57c9005070910091f1051f7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <2cd57c9005070910091f1051f7@mail.gmail.com>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sorry for the delay.

Coywolf Qi Hunt [Sun, Jul 10, 2005 at 01:09:22AM +0800]:
> On 7/9/05, Nico Schottelius <nico-kernel@schottelius.org> wrote:
> > Hello!
> >=20
> > What's the 'correct behaviour' of an init system, if someone wants
> > to shutdown the system?
> >=20
> > I currently do:
> >=20
> > - call reboot(RB_POWER_OFF/RB_AUTOBOOT/RB_HALT_SYSTEM)
> > - _exit(0)
> >=20
> > Is this exit() call wrong? If I do RB_HALT_SYSTEM and _exit(0) after,
> > the kernel panics.
>=20
> What the panic shows?

"Attempted to kill init!"

--> Panic.

Nico


--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ0IvfrOTBMvCUbrlAQLKshAAlMrejTbJHFW8smB9nNINngJlwb7vC0yK
O3YLWvWKV3bfgrVWo0aly0F3yi14D45JtsICXhGy7qH1nFpJ2kO2ytMV1pCNUsE+
AegRzNMOYRrYCO8O0cdja7cRyw5uFzIVhVHrQYVYPqfUrJ2WPZ2xpvkwIcTVbbJf
E3ycYDh9cdtMHgq4t9IjA4RcCHPTdBZRkC/rzfMcD7foLmI+O2yOSWT2+3far0Eu
8JMUFPYXdYG8INSNsiyHj9+hesd/KgbukeMkOGl38XbHh18m6wG4Z6PClywdQSmL
06a9vXF6ecVWS2S/YZZQmM9oGMn/hrxo0HRWkTRU5HFL5PN2DaSonXjaUwEmI7Br
l28Y8hc2L9RNZL4Fu6K1huKOfffWtUbzLOMy3Q6ybZr0za5FvuuqSTvhRKaV83/w
E5ZuvspMxvnyvab0jOLuCLvDkuXYJseNv9KUakmH434T2AI6sSnKsyPYJiOkNn9B
v+TjNBgxt5DnTZoaoOoDE1OGuIUE9P6jkFfpStXfMgXy0hPytvnkFP9r7mbNj+0B
xwhGhXglMidvR38ufu4kUVr4MlhuSU+OwhtC9N8k31+Tpfqur0mOZB1wGpAKv0TX
8090OsP/hS7XfgH/j0CZWwDtbgQ+6qA81agOY/hxz16ws6yRrAipv0F6OdojWqXX
oLpuRVc3OYE=
=+h3f
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
