Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbTA1JWX>; Tue, 28 Jan 2003 04:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264614AbTA1JWX>; Tue, 28 Jan 2003 04:22:23 -0500
Received: from host213-121-111-56.in-addr.btopenworld.com ([213.121.111.56]:1258
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S262821AbTA1JWW>; Tue, 28 Jan 2003 04:22:22 -0500
Subject: Re: sendfile support in linux
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: Stanley Yee <SYee@snapappliance.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <057889C7F1E5D61193620002A537E8690B4387@NCBDC>
References: <057889C7F1E5D61193620002A537E8690B4387@NCBDC>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-NrPkRLsOL2YtXYLUhU5J"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Jan 2003 09:32:05 +0000
Message-Id: <1043746326.6975.93.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NrPkRLsOL2YtXYLUhU5J
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-01-28 at 01:45, Stanley Yee wrote:
> I'm trying to find out more about sendfile(2).  So far, from what I've
> gathered, it sounds like the requirements for it are (please correct me i=
f
> I'm wrong):
>=20
> 1.  A kernel with sendfile support (i.e. 2.4.X)
> 2.  A network card capable of doing the TCP checksum in the hardware
> 3.  The application must support sendfile=20

Those are the user requirements yes. Of course the programmer only needs
to assume (1) to start writing applications. Oh and its probably worth
mentioning:

 4. You can't do zero-copy receive.

> Do you know what applications support zerocopy (sendfile)?  I noticed tha=
t a
> zerocopy NFS patch was added to the 2.5.x tree.  Does the 2.4.X NFS daemo=
n
> support zerocopy?  Does samba support zerocopy and if so what version?

Samba, tux2, apache?, all the big stuff.

Dunno about NFS.

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-NrPkRLsOL2YtXYLUhU5J
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+Nk4VkbV2aYZGvn0RAthuAJ9CAzbxhYdper9UKFTHiqhjsxYrAgCdEfwy
kouOxknoD0r4yETFcXN8ojM=
=w2XE
-----END PGP SIGNATURE-----

--=-NrPkRLsOL2YtXYLUhU5J--

