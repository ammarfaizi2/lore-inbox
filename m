Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293230AbSCJUhZ>; Sun, 10 Mar 2002 15:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293229AbSCJUhG>; Sun, 10 Mar 2002 15:37:06 -0500
Received: from [217.79.102.244] ([217.79.102.244]:27637 "EHLO
	monkey.beezly.org.uk") by vger.kernel.org with ESMTP
	id <S293226AbSCJUhA>; Sun, 10 Mar 2002 15:37:00 -0500
Subject: Re: Sun GEM card looses TX on x86 32bit PCI
From: Beezly <beezly@beezly.org.uk>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-+sjUgR6Wd7Mcc8TehFR9"
X-Mailer: Evolution/1.0.2 
Date: 10 Mar 2002 20:36:59 +0000
Message-Id: <1015792619.1801.4.camel@monkey>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+sjUgR6Wd7Mcc8TehFR9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi David,

Unfortunately not. I've just applied these changes and recompiled, but
I'm suffering exactly the same problem.

This is what I have this time when the card has stopped receiving;

monkey:/home/andy# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:03:BA:04:5B:D7 =3D20
          inet addr:10.0.0.12  Bcast:10.0.0.255  Mask:255.255.255.0
          inet6 addr: fe80::203:baff:fe04:5bd7/10 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:48508 errors:0 dropped:1 overruns:1 frame:68
          TX packets:49362 errors:0 dropped:0 overruns:0 carrier:1
          collisions:2 txqueuelen:100=3D20
          RX bytes:61058494 (58.2 MiB)  TX bytes:61988220 (59.1 MiB)
          Interrupt:5 Base address:0x8400=3D20

Cheers,

Beezly

On Sun, 2002-03-10 at 08:19, David S. Miller wrote:
>=3D20
> Let me know if this makes things any better:
>=3D20

--=-+sjUgR6Wd7Mcc8TehFR9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8i8PrXu4ZFsMQjPgRAhGeAJwJlIUw79SlYAgzFoV2UWB83NXLYwCguQ23
3BHc0XllA2t9kL4fftOGi10=
=XYqW
-----END PGP SIGNATURE-----

--=-+sjUgR6Wd7Mcc8TehFR9--
