Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbVLCO6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbVLCO6w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 09:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbVLCO6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 09:58:52 -0500
Received: from lug-owl.de ([195.71.106.12]:15274 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751267AbVLCO6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 09:58:51 -0500
Date: Sat, 3 Dec 2005 15:58:48 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Jeff Haran <jharan@Brocade.COM>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] ip / ifconfig redesign
Message-ID: <20051203145848.GK13985@lug-owl.de>
Mail-Followup-To: Jeff Haran <jharan@Brocade.COM>,
	linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
References: <447BB19E14004A4388CB9A864D2BA7630DF693@hq-ex-6.brocade.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="icsXL8FABjDeMLkQ"
Content-Disposition: inline
In-Reply-To: <447BB19E14004A4388CB9A864D2BA7630DF693@hq-ex-6.brocade.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--icsXL8FABjDeMLkQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-12-02 14:34:08 -0800, Jeff Haran <jharan@Brocade.COM> wrote:
> > > The obvious benefit here, would be the transparent ability=20
> > for apps to bind=20
> > > to addresses, regardless of the link existence.
> >=20
> > # echo 1 > /proc/sys/net/ipv4/ip_nonlocal_bind
> >=20
> > and/or bind to address 0 (aka 0.0.0.0) instead of a given IP address.
> kchan          :root> ip addr show
> 1: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue=20
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>     inet 127.0.0.1/16 scope host lo
> 2: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
>     link/ether 00:05:1e:35:00:49 brd ff:ff:ff:ff:ff:ff
>     inet 10.32.246.19/20 brd 10.32.255.255 scope global eth0
>     inet 10.32.246.16/20 brd 10.32.255.255 scope global secondary eth0:1
> 3: eth1: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
>     link/ether 00:05:1e:35:00:4a brd ff:ff:ff:ff:ff:ff
>     inet 10.0.0.6/24 brd 10.255.255.255 scope global eth1
> 4: eth2: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
>     link/ether 00:05:1e:35:00:4b brd ff:ff:ff:ff:ff:ff
>     inet 127.1.16.16/24 brd 127.255.255.255 scope global eth2
> 6: fc0: <BROADCAST,UP> mtu 2024 qdisc pfifo_fast qlen 100
>     link/ieee802 00:05:1e:35:00:49 brd ff:ff:ff:ff:ff:ff
>     inet 2.3.4.6/24 brd 2.3.4.255 scope global fc0
> kchan          :root> ip addr add 4.5.6.7
> Not enough information: "dev" argument is required.
> kchan          :root>=20

We were talking about apps binding to a non-local address. That is,
some locally running server binds to any address that is not yet there
(anything except 0.0.0.0, 127.0.0.1, 10.32.246.19, 109.32.246.16,
10.0.0.6, 127.1.16.16, 2.3.4.6).  So we're talking about two different
subjects...

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--icsXL8FABjDeMLkQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDkbKnHb1edYOZ4bsRAogrAJ9b2X6mto19iI9qHBoJLO0UHjoi3wCfYPJ6
iRguQ9bRB09HRr4ugdMDTK0=
=6soG
-----END PGP SIGNATURE-----

--icsXL8FABjDeMLkQ--
