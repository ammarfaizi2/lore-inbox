Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbWEZELZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbWEZELZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 00:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030318AbWEZELZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 00:11:25 -0400
Received: from zak.futurequest.net ([69.5.6.152]:49034 "HELO
	zak.futurequest.net") by vger.kernel.org with SMTP id S1030319AbWEZELZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 00:11:25 -0400
Date: Thu, 25 May 2006 22:11:22 -0600
From: Bruce Guenter <bruce@untroubled.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Source Compression
Message-ID: <20060526041122.GA31821@untroubled.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0605211028100.4037@p34>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605211028100.4037@p34>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 21, 2006 at 10:35:00AM -0400, Justin Piszcz wrote:
> Was curious as to which utilities would offer the best compression ratio=
=20
> for the kernel source, I thought it'd be bzip2 or rar but lzma wins,=20
> roughly 6 MiB smaller than bzip2.
>=20
> $ du -sk * | sort -n
> 33520   linux-2.6.16.17.tar.lzma

Since it was requested by somebody:

$ du -sk linux-2.6.16.17.*
32904	linux-2.6.16.17.7z
39919	linux-2.6.16.17.tar.bz2

This was done with: 7z -mx=3D9
--=20
Bruce Guenter <bruce@untroubled.org> http://untroubled.org/
OpenPGP key: 699980E8 / D0B7 C8DD 365D A395 29DA  2E2A E96F B2DC 6999 80E8

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEdn/q6W+y3GmZgOgRAj9KAJ9rzXYuepAFOTZOfKEs+0p6i8k+CwCdGq2r
pYf+jLuMKVoBgILncPJ1AAU=
=Z/Uj
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
