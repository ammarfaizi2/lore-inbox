Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264298AbUGYTRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264298AbUGYTRM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 15:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbUGYTRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 15:17:12 -0400
Received: from mail.szintezis.hu ([195.56.253.241]:7616 "HELO
	hold.szintezis.hu") by vger.kernel.org with SMTP id S264298AbUGYTQt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 15:16:49 -0400
Subject: Re: PROBLEM: 2.6.8 breaks pop3, telnet
From: Gabor MICSKO <gmicsko@szintezis.hu>
To: "Gerard H. Pille" <g.h.p@skynet.be>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4100F899.7050501@skynet.be>
References: <4100F899.7050501@skynet.be>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sAcZA/zOzPv5wcEB3+6S"
Message-Id: <1090783034.1007.15.camel@alderaan.trey.hu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 25 Jul 2004 21:17:15 +0200
X-OriginalArrivalTime: 25 Jul 2004 19:16:45.0252 (UTC) FILETIME=[ECCB8040:01C4727B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sAcZA/zOzPv5wcEB3+6S
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable

Hi!

Maybe you need set=20

net.ipv4.tcp_default_win_scale=20

sysctl value to 0.

sysctl -w net.ipv4.tcp_default_win_scale=3D0

looks like a broken firewall which mangling the TCP window scale option

More details here:
http://lwn.net/Articles/91976/

(TCP window scaling and broken routers)


2004-07-23, p keltez=E9ssel 13:38-kor Gerard H. Pille ezt =EDrta:
> 1.
> 2.6.8 breaks pop3, telnet
>=20
> 2.
> hallo,
>=20
> on a number of systems that I upgraded from 2.6.6 and 2.6.7 to 2.6.8, moz=
illa
> can no longer access my pop3 mail account, neither can I when using telne=
t:
>=20
> telnet pop3.skynet.be 110
> Trying 195.238.3.116...
> Connected to pop3pool1.skynet.be.
> Escape character is '^]'.
> +OK Skynet POP3 Ready pop3pool1.skynet.be
> user XXXXXX
> +OK USER XXXXXX set
> pass YYYYYY
> +OK You are so in
> UIDL
> +OK uidl command accepted.

--=20
Micsk=F3 G=E1bor
HP Accredited Platform Specialist, System Engineer (APS, ASE)
Szint=E9zis Computer Rendszerh=E1z Rt.     =20
H-9021 Gy=F5r, Tihanyi =C1rp=E1d =FAt 2.
Tel: +36-96-502-216
Fax: +36-96-318-658
E-mail: gmicsko@szintezis.hu
Web: http://www.hup.hu/
GPG Key fingerprint: 6FA1 D8BF 3C73 0570 ED5D  82AC A3BE 4E6A CF95 5F50

--=-sAcZA/zOzPv5wcEB3+6S
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ez az =?ISO-8859-1?Q?=FCzenetr=E9sz?=
	=?ISO-8859-1?Q?_digit=E1lis?= =?ISO-8859-1?Q?_al=E1=EDr=E1ssal?= van
	=?ISO-8859-1?Q?ell=E1tva?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBBAc6o75Oas+VX1ARAgyFAKCnQe1tUKFOpldd0BXIEusohXR6OACguMGU
j/hZyUwHyHr359Ttk+5SoVk=
=FRqC
-----END PGP SIGNATURE-----

--=-sAcZA/zOzPv5wcEB3+6S--

