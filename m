Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbVJPLUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbVJPLUN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 07:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVJPLUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 07:20:13 -0400
Received: from wg.technophil.ch ([213.189.149.230]:60581 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1751204AbVJPLUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 07:20:11 -0400
Date: Sun, 16 Oct 2005 13:19:54 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Nico Schottelius <nico-kernel@schottelius.org>,
       Christian Kujau <evil@g-house.de>, LKML <linux-kernel@vger.kernel.org>,
       Daniel Aubry <kernel-obri@chaostreff.ch>
Subject: Re: Some problems with 2.6.13.4
Message-ID: <20051016111954.GU12774@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Christian Kujau <evil@g-house.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Daniel Aubry <kernel-obri@chaostreff.ch>
References: <20051015122131.GG8609@schottelius.org> <43511AB1.3010608@g-house.de> <20051015154048.GK8609@schottelius.org> <20051015200245.GM12774@schottelius.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZsW/usBbx2ObC9TW"
Content-Disposition: inline
In-Reply-To: <20051015200245.GM12774@schottelius.org>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZsW/usBbx2ObC9TW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

After some heavy compile hours, here are the results:

- 2.6.13.1 and 2.6.13.2 behave the same way with the same config.

For reference I now published the configs [0]. 2.6.12.5 was the config
source, all others where generated using make oldconfig.

Perhaps there's a somehow heavy configuration mistake in it?

Btw, Daniel Aubry fixed his keyboard problem with disabling usb keyboard su=
pport
in the bios (is this really the right way?).

Nico

[0]: http://creme.schottelius.org/~nico/temp/kb-configs/

Nico Schottelius [Sat, Oct 15, 2005 at 10:02:45PM +0200]:
> I was a little bit wrong:
>=20
> 2.6.13.3 and 2.6.13.4 freeze both on the ibm tp 600, but first
> after "Freeing unused kernel memory: 96k"
>=20
> There is no output from init (neither "cinit-0.2: Booting from ..."
> nor "INIT:" (sys-v-init)), so this is not an init problem.
>=20
> Could we somehow debug this differently or do I have to install
> 2.6.13.2 and 2.6.13.1, too? It would take simply hours until it is
> finished here.
>=20
> Nico
>=20
> Nico Schottelius [Sat, Oct 15, 2005 at 05:40:48PM +0200]:
> > Christian Kujau [Sat, Oct 15, 2005 at 05:05:21PM +0200]:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: RIPEMD160
> > >=20
> > > Nico Schottelius schrieb:
> > > > The kernel configurations are used from the versions before, with r=
unning
> > > > make oldconfig before.
> > >=20
> > > so, these machines were running fine with 2.6.13.3 or .2 and stopped
> > > working with 2.6.13.4? if yes, then perhaps you can narrow it down to=
 one
> > > of the changes in patch-2.6.13.3-4.gz or patch-2.6.13.2-3.gz
> > >=20
> > > (from http://www.kernel.org/pub/linux/kernel/v2.6/incr/)
> >=20
> > Sorry, I sent the message before inserting this info:
> >=20
> > - ibm tp runs with 2.6.12.5
> > - dell latitude runs with 2.6.10
> >=20
> > I personally have access to the ibm tp and I'll test 2.6.13.3 in some h=
ours
> > (which it nees to compile it).
> >=20
> > I'll report more info than. Perhaps Daniel Aubry can test on his dell, =
too.
> >=20
> > Nico
> >=20
> > --=20
> > Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
> > Open Source nutures open minds and free, creative developers.
>=20
>=20
>=20
> --=20
> Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
> Open Source nutures open minds and free, creative developers.



--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--ZsW/usBbx2ObC9TW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ1I3WbOTBMvCUbrlAQJ3Uw/+O69R/csrLhgabpfU9axbTKusiA5beuO6
T67Lw/hWnm+m5fEm+t0bFd+F47YQWtbC0VxURxIboBO/rKVtaAtN9w2QEnU81jd7
ZGOEkQTpvsTWQ+IOq2Cr8AF1LvNoy+7IQWdRwIt0twIbJTpDnFr4KUQEG1A3I7Ja
8bWWAU/b9ZQvmW09ydJZarHEExa+9RJvRNLm0QIh/bxhYo4PneyTOAxtaXX/GHJr
fVvD8exiYblhZlC0bQUxV2EDXG7tJ1YVqdeqDChJmbET0LdzbkzmmuYAV2g5o6c1
Y61JWCbTdymqXO59tcw0EmNnCuKbmTcJoEgndT3j4exKcJ4en7wwh+Uxgj4WG0hy
wbbq3+63hz/FTvTJ/1M+AZN/pL0/saSt0fefPZScxFcqIAnls7ANX0l0Ug46fPyA
7TqztR4cTQFK4RIwpJeHcNqECp7w5/dCE/3d0vNjKIT1VI8xzbGxP9itHZq1oAly
FxOCWKqvNIWsaLNJcJ7K+RGdkgrLme/G8uOIov+v4qa1DtFWmiStxVE8vTBdaLfn
EVKJYe8ZAqsJ6MIac5PY+7sHBGC/f7LzJRv1bEnYvdKJ/qYp4cRFS/vi/76XgyMx
DDrODUvUPuUDoX+yCOckW7Ws+yMHQIhEyfJQAPMlmJvTi2ngIPA564GO13SV+JEO
l+aABjTIAb8=
=ojqQ
-----END PGP SIGNATURE-----

--ZsW/usBbx2ObC9TW--
