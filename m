Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbVLUKDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbVLUKDm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 05:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVLUKDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 05:03:42 -0500
Received: from lug-owl.de ([195.71.106.12]:37834 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S932341AbVLUKDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 05:03:42 -0500
Date: Wed, 21 Dec 2005 11:03:38 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: dada1@cosmosbay.com, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on x86_64 machines ?
Message-ID: <20051221100338.GV13985@lug-owl.de>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	dada1@cosmosbay.com, linux-kernel@vger.kernel.org, ak@suse.de
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net> <43A91C57.20102@cosmosbay.com> <20051221.012212.65592069.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FUBn+A0X9P+7IcSo"
Content-Disposition: inline
In-Reply-To: <20051221.012212.65592069.davem@davemloft.net>
X-Operating-System: Linux mail 2.6.12.3lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FUBn+A0X9P+7IcSo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-12-21 01:22:12 -0800, David S. Miller <davem@davemloft.net> wr=
ote:
> From: Eric Dumazet <dada1@cosmosbay.com>
> Date: Wed, 21 Dec 2005 10:11:51 +0100
>=20
> > Could some of you post the result of the following command on your mach=
ines :

VAX KA650 (simulated), 4k pages (hw-size is 512 Bytes, though),
L1_CACHE_BYTES=3D32

# grep "size-" /proc/slabinfo |grep -v DMA|cut -c1-40
size-131072            0      0 131072 =20
size-65536             0      0  65536 =20
size-32768             0      0  32768 =20
size-16384             0      0  16384 =20
size-8192              0      0   8192 =20
size-4096             21     21   4096 =20
size-2048             39     42   2060 =20
size-1024             18     21   1036 =20
size-512              70     70    524 =20
size-256               5     14    268 =20
size-192             722    722    204 =20
size-128             145    168    140 =20
size-96              382    396    108 =20
size-32             1040   1092     44 =20
size-64              338    350     76 =20

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

--FUBn+A0X9P+7IcSo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDqSh6Hb1edYOZ4bsRAuLeAKCGsOBRIf2qwzjyHXtokIdU5EhQiACeKjCA
lISMVJeAtDV6V/lvd219UVQ=
=j/a4
-----END PGP SIGNATURE-----

--FUBn+A0X9P+7IcSo--
