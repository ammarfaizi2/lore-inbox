Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267569AbTBGBSV>; Thu, 6 Feb 2003 20:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267608AbTBGBSV>; Thu, 6 Feb 2003 20:18:21 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:52490 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S267569AbTBGBSU>; Thu, 6 Feb 2003 20:18:20 -0500
Date: Fri, 7 Feb 2003 02:27:55 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Sowmya.Krishnaswamy@nokia.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with bootimg (wish to be personally CC'ed the answers/comments posted to the list in response to this posting)
Message-ID: <20030207012755.GF1623@arthur.ubicom.tudelft.nl>
References: <4D7B558499107545BB45044C63822DDE0219C291@mvebe001.americas.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dgjlcl3Tl+kb3YDk"
Content-Disposition: inline
In-Reply-To: <4D7B558499107545BB45044C63822DDE0219C291@mvebe001.americas.nokia.com>
User-Agent: Mutt/1.4i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2003 at 04:33:24PM -0800, Sowmya.Krishnaswamy@nokia.com wro=
te:
> We are trying to use bootimg for dual boot:=20
>=20
> # bootimg -f bzImage -n -i ram40.img.gz -v console=3DttyS0,115200n8 ramdi=
sk_size=3D131072 root=3D/dev/ram
>=20
> bzImage "2.4.17_MVL21CGENOKIA_4-cpi1-lb-arun (abalasub@mvaserg011) #5 SMP=
 Wed Nov 27 17:27:00 PST 2002"
>=20
>     1439613 bytes (352 pages) 0x4109cc08-0x411fcc07 -> 0x100000-0x25fff
>     16161140 bytes (3946 pages) 0x40131008-0x4109b007 -> 0x8668c-0xff068b
>     4096 bytes (1 page) 0x804b908-0x804c907 -> 0x90000-0x90fff
>=20
> Total 4299 pages, start address is 0x100000
>=20
> Loading Kernel Image vmlinuz
> Running boot code at 0x03011000
>=20
> SYSTEM STOPS PRINTING MESSAGES AND HANGS. Has anyone faced a similar prob=
lem before. Any Suggestions?

I'd say you selected support for the wrong CPU (a P3 optimised kernel
won't run on a PII, for example). I have no idea how bootimg works, so
it could still be a problem with your bootimg setup.


Erik

--=20
J.A.K. (Erik) Mouw
Email: J.A.K.Mouw@its.tudelft.nl  mouw@nl.linux.org

--dgjlcl3Tl+kb3YDk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+Qwub/PlVHJtIto0RAgFxAJ4pw1pWrehCP2m7cPq4wphIsNrF7QCffUj4
btHshfR9GP3/IWzSGlMJFfs=
=SkHu
-----END PGP SIGNATURE-----

--dgjlcl3Tl+kb3YDk--
