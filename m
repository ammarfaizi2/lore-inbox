Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135215AbRAQUrL>; Wed, 17 Jan 2001 15:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133095AbRAQUqv>; Wed, 17 Jan 2001 15:46:51 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:56129 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S130643AbRAQUqp>; Wed, 17 Jan 2001 15:46:45 -0500
Date: Wed, 17 Jan 2001 20:46:42 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Sven Koch <haegar@cut.de>
Cc: Shawn Starr <Shawn.Starr@Home.net>, linux-kernel@vger.kernel.org
Subject: Re: [QUESTION]: Applying patches ontop of patches (2.4.1pre7 to 2.4.1pre8)
Message-ID: <20010117204642.F546@redhat.com>
In-Reply-To: <3A65F3DA.7E2C8823@Home.net> <Pine.LNX.4.30.0101172130580.2313-100000@space.comunit.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="1Y7d0dPL928TPQbc"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101172130580.2313-100000@space.comunit.de>; from haegar@cut.de on Wed, Jan 17, 2001 at 09:32:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1Y7d0dPL928TPQbc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2001 at 09:32:30PM +0100, Sven Koch wrote:

> reverse the patch for 2.4.1pre7
>=20
> for example: cd /usr/src/linux ; zcat 2.4.1pre7.gz | patch -p1 -R
>=20
> after that apply pre8

You can also use interdiff:

$ interdiff 2.4.1pre7 2.4.1pre8 | patch -p1

It's mostly reliable.

Tim.
*/

--1Y7d0dPL928TPQbc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6ZgSxONXnILZ4yVIRArlgAJ91pV9jhHc3sIXsVhZr5bl6myHTAACgnGSV
qG6g/t65OBK3zmx59Zsh7cQ=
=SIIH
-----END PGP SIGNATURE-----

--1Y7d0dPL928TPQbc--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
