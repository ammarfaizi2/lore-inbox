Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317462AbSINScO>; Sat, 14 Sep 2002 14:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317463AbSINScO>; Sat, 14 Sep 2002 14:32:14 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:64439 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S317462AbSINScN>;
	Sat, 14 Sep 2002 14:32:13 -0400
Subject: Re: [PATCH 2.4.20-pre7] net/ipv4/netfilter/ip_conntrack_ftp and
	_irc to export objs
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Jarno Paananen <jpaana@s2.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3n0qkqvs8.fsf@kalahari.s2.org>
References: <m3vg58qwz1.fsf@kalahari.s2.org>
	<1032027105.29595.129.camel@tux>  <m3n0qkqvs8.fsf@kalahari.s2.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-zM+cwIW1hMYVnWPrzqfc"
X-Mailer: Ximian Evolution 1.0.7 
Date: 14 Sep 2002 20:37:02 +0200
Message-Id: <1032028622.29595.134.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zM+cwIW1hMYVnWPrzqfc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2002-09-14 at 20:19, Jarno Paananen wrote:

> Hm, didn't notice those, sorry.
>=20
> It seems the condition for the actual export is different than the
> Makefile. In ip_conntrack_ftp.c for example the export is done:
>=20
> #ifdef CONFIG_IP_NF_NAT_NEEDED
> EXPORT_SYMBOL(ip_ftp_lock);
> #endif
>=20
> and in Makefile:
>=20
> ifdef CONFIG_IP_NF_NAT_FTP
>         export-objs +=3D ip_conntrack_ftp.o
> endif

I just did a basic test and I didn't manage to get
CONFIG_IP_NF_NAT_NEEDED set without getting CONFIG_IP_NF_NAT and
CONFIG_IP_NF_NAT_FTP and CONFIG_IP_NF_NAT_IRC set aswell.
(with the corresponding CONFIG_IP_NF_FTP and CONFIG_IP_NF_IRC of course)

--=20
/Martin

Never argue with an idiot. They drag you down to their level, then beat
you with experience.

--=-zM+cwIW1hMYVnWPrzqfc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9g4HOWm2vlfa207ERAjYcAJ4u3q5Cw1il55frAonyKkxZG+oKDwCgpEj/
um76U0ZO2uH6pzqF5z/lOSM=
=2ect
-----END PGP SIGNATURE-----

--=-zM+cwIW1hMYVnWPrzqfc--
