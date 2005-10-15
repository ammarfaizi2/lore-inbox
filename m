Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbVJOUDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbVJOUDA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 16:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVJOUDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 16:03:00 -0400
Received: from wg.technophil.ch ([213.189.149.230]:58785 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1751215AbVJOUC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 16:02:59 -0400
Date: Sat, 15 Oct 2005 22:02:45 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Nico Schottelius <nico-kernel@schottelius.org>,
       Christian Kujau <evil@g-house.de>, LKML <linux-kernel@vger.kernel.org>,
       Daniel Aubry <kernel-obri@chaostreff.ch>
Subject: Re: Some problems with 2.6.13.4
Message-ID: <20051015200245.GM12774@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Christian Kujau <evil@g-house.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Daniel Aubry <kernel-obri@chaostreff.ch>
References: <20051015122131.GG8609@schottelius.org> <43511AB1.3010608@g-house.de> <20051015154048.GK8609@schottelius.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x38akuY2VS0PywU3"
Content-Disposition: inline
In-Reply-To: <20051015154048.GK8609@schottelius.org>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x38akuY2VS0PywU3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I was a little bit wrong:

2.6.13.3 and 2.6.13.4 freeze both on the ibm tp 600, but first
after "Freeing unused kernel memory: 96k"

There is no output from init (neither "cinit-0.2: Booting from ..."
nor "INIT:" (sys-v-init)), so this is not an init problem.

Could we somehow debug this differently or do I have to install
2.6.13.2 and 2.6.13.1, too? It would take simply hours until it is
finished here.

Nico

Nico Schottelius [Sat, Oct 15, 2005 at 05:40:48PM +0200]:
> Christian Kujau [Sat, Oct 15, 2005 at 05:05:21PM +0200]:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: RIPEMD160
> >=20
> > Nico Schottelius schrieb:
> > > The kernel configurations are used from the versions before, with run=
ning
> > > make oldconfig before.
> >=20
> > so, these machines were running fine with 2.6.13.3 or .2 and stopped
> > working with 2.6.13.4? if yes, then perhaps you can narrow it down to o=
ne
> > of the changes in patch-2.6.13.3-4.gz or patch-2.6.13.2-3.gz
> >=20
> > (from http://www.kernel.org/pub/linux/kernel/v2.6/incr/)
>=20
> Sorry, I sent the message before inserting this info:
>=20
> - ibm tp runs with 2.6.12.5
> - dell latitude runs with 2.6.10
>=20
> I personally have access to the ibm tp and I'll test 2.6.13.3 in some hou=
rs
> (which it nees to compile it).
>=20
> I'll report more info than. Perhaps Daniel Aubry can test on his dell, to=
o.
>=20
> Nico
>=20
> --=20
> Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
> Open Source nutures open minds and free, creative developers.



--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--x38akuY2VS0PywU3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ1FgZbOTBMvCUbrlAQI6Dw/9GmE2tQ7sIRmaMONb2wDEnqwn14jiJo9Q
1N03LInbt4HJ/jhMhzaBhy6CbgfDPxGGOpwO+nXRPgjSAQMqrLYfEzHPNz9fwPUV
vrhPxAu+hWM0eX8y1DQLEnA33DrqFUHDpM1h/rX0XHMkBjqdkFjjhm/nkVGSAU0t
OCDatw+0AWZoZyLDxiCmuRUx5wpbqytaphNpS7I0EwNHj/jGYpzp8iqAX8kV8Igo
5N1JnusOstn91FiPknjut1Qq4mHawhy4OpM9yksSe9MqHGij6F9c/ikvBD6EgYgf
HNRgHwKiJlDXLXJBQ5Wv03gO7vvCpcoEanOhWbVVASUJrZjXYFvySYi2Ehz/jzXh
6ym0IILvNp2q9KW7WCCbf7+zF5cjgbFNEMlh0NF4bl2PTMS638ggJooGg53rUX36
2SdlZUoMO9jRiORQrFBHksdcoInlXmX/ksn1txTBhqJJOjqjBH63/D3RxsMSox/A
u4wkm1qUdOiPgdguSnSfjQUm0W431FugLijiBOcujRZ14K1AuRDw1GJuF5n1GU+o
2FBqkF/Wfw65WfPAnAo5I9f+Cr++dR8et90nLx/tPRQQvljCN496L27bzCOCrcIa
QXfdluV5YRr2cIoQtqqCWS6A8tbaqCh1TLVm7h+Ohz/i9Uq6c/VEJeqAlAC3Mk5h
2eUOOA8Bu/k=
=4HZl
-----END PGP SIGNATURE-----

--x38akuY2VS0PywU3--
