Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265549AbUADM5d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 07:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265555AbUADM5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 07:57:32 -0500
Received: from h192n2fls310o1003.telia.com ([81.224.187.192]:4493 "EHLO
	cambrant.com") by vger.kernel.org with ESMTP id S265549AbUADM53
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 07:57:29 -0500
Date: Sun, 4 Jan 2004 13:57:14 +0100
From: Tim Cambrant <tim@cambrant.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspected bug in fs/ufs/inode.c - test for < 0 on unsigned sector_t - [2.6.1-rc1-mm1]
Message-ID: <20040104125714.GA24157@cambrant.com>
References: <Pine.LNX.4.56.0401032326050.4664@jju_lnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0401032326050.4664@jju_lnx.backbone.dif.dk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 03, 2004 at 11:45:56PM +0100, Jesper Juhl wrote:
>=20
> Is this analysis correct?  If it is, can the code simply be removed?

It does seem odd, but indeed, a confirmation from someone with authority
would be nice before digging in to a cleanup-process like this. Try e-maili=
ng
the maintainer of the code directly, since it doesn't seem like anyone
feels like wasting any time on this :)

Nice job on the discovery though, if this is true, these things really shou=
ld
be removed.

--=20
Tim Cambrant <tim@cambrant.com>=20
GPG KeyID 0x59518702
Fingerprint: 14FE 03AE C2D1 072A 87D0  BC4D FA9E 02D8 5951 8702

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+A2q+p4C2FlRhwIRAquiAKDADcMXCPq2iTIGfLoq/MGpWTzGuACeNKbk
PCtiu9cE7qbent1tD6tAp5A=
=Zhgr
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
