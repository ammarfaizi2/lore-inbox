Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264716AbTA2VoE>; Wed, 29 Jan 2003 16:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265126AbTA2VoE>; Wed, 29 Jan 2003 16:44:04 -0500
Received: from B574a.pppool.de ([213.7.87.74]:40578 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S264716AbTA2VoC>; Wed, 29 Jan 2003 16:44:02 -0500
Subject: Re: NFS client locking hangs for period
From: Daniel Egger <degger@fhm.edu>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org, NFS@lists.sourceforge.net
In-Reply-To: <200301280801.h0S81Ns10071@Port.imtp.ilyichevsk.odessa.ua>
References: <20030124184951.A23608@blackjesus.async.com.br>
	 <15922.2657.267195.355147@notabene.cse.unsw.edu.au>
	 <20030126140200.A25438@blackjesus.async.com.br>
	 <200301280801.h0S81Ns10071@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-thtLCaaeE54Z3roHDSuK"
Organization: 
Message-Id: <1043875672.1094.19.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 29 Jan 2003 22:53:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-thtLCaaeE54Z3roHDSuK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Die, 2003-01-28 um 09.00 schrieb Denis Vlasenko:

> It was not really *that* difficult for me. I used devfs and symlinks.
> /etc, /var, /tmp are different directories per client,
> /home, /usr are shared. The rest stays on root fs readonly.
> ssh to NFS server if you want to modify some files on root fs.

This will only work dandy if the server runs the same OS on the=20
same architecture and its own system is well enough equipped to
do software installations and bootstraps. Although I'm using Linux on
my server as well as the same architecture as most of the clients
I sometimes experience troubles working in the chrooted client
environment.

--=20
Servus,
       Daniel

--=-thtLCaaeE54Z3roHDSuK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+OEdYchlzsq9KoIYRAoQgAKCMUnP+wIgZEuNa7JjPpKhKwUBrgQCgqwus
B3gub+1OpuHgBsDPC6ZSG00=
=+ueY
-----END PGP SIGNATURE-----

--=-thtLCaaeE54Z3roHDSuK--

