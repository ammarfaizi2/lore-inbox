Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267473AbSKQJtf>; Sun, 17 Nov 2002 04:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267480AbSKQJtf>; Sun, 17 Nov 2002 04:49:35 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:56850 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S267473AbSKQJte>;
	Sun, 17 Nov 2002 04:49:34 -0500
Date: Sun, 17 Nov 2002 10:56:32 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: lan based kgdb
Message-ID: <20021117095632.GN4545@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021116182454.GH19061@waste.org> <Pine.LNX.4.44.0211161025500.15838-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ztcJpsdPpsnnlAp8"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211161025500.15838-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
x-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
x-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ztcJpsdPpsnnlAp8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2002-11-16 10:33:57 -0800, Linus Torvalds <torvalds@transmeta.com>
wrote in message <Pine.LNX.4.44.0211161025500.15838-100000@home.transmeta.c=
om>:
> On Sat, 16 Nov 2002, Oliver Xymoron wrote:
> >=20
> > LAN latencies should be low enough that waiting on an ACK for each
> > packet will do just fine for error correction. If someone wants to do
> > remote debugging, they can ssh into a debugging machine on the same LAN.
>=20
> Basically, I don't personally care too much for kgdb itself, but I see a
> asynchronous LAN console as a more generic tool for just doing not just
> kernel debugging, but management in general. syslogd is fine for when the

=2E..which reminds me to DEC's MOP (Maintainence and Operator's Protocol),
which is ethernet (but not IP) based remote console and a mixture of
bootp/tftp. Sure, we won't (yet) go as far as sending the next kernel to
boot via our new console protocol to kexec(), but wait for the very
first S-Records to arrive:-p

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet!
   Shell Script APT-Proxy: http://lug-owl.de/~jbglaw/software/ap2/

--ztcJpsdPpsnnlAp8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE912fQHb1edYOZ4bsRAjbAAJ9vDl6zpH7D26J4LdMo8ncAi3owSQCfW44j
lCT7L/LpkW4NNe2QQ5cJhzI=
=ngWU
-----END PGP SIGNATURE-----

--ztcJpsdPpsnnlAp8--
