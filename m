Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263876AbTKGExu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 23:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbTKGExu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 23:53:50 -0500
Received: from adsl-63-207-60-234.dsl.lsan03.pacbell.net ([63.207.60.234]:27149
	"EHLO obsecurity.dyndns.org") by vger.kernel.org with ESMTP
	id S263876AbTKGExs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 23:53:48 -0500
Date: Thu, 6 Nov 2003 20:53:47 -0800
From: Kris Kennaway <kris@obsecurity.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Kris Kennaway <kris@freebsd.org>, linux-kernel@vger.kernel.org
Subject: Re: NFS Locking violates protocol spec (incompatible with FreeBSD)
Message-ID: <20031107045346.GA4583@rot13.obsecurity.org>
References: <20031107041051.GA4065@rot13.obsecurity.org> <shsk76c3hvr.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <shsk76c3hvr.fsf@charged.uio.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2003 at 11:46:48PM -0500, Trond Myklebust wrote:
> >>>>> " " =3D=3D Kris Kennaway <kris@freebsd.org> writes:
>=20
>=20
>      > contains more details about this problem, including a
>      > workaround for FreeBSD to limit the cookie size to 8 bytes.
>      > Obviously, it would be better for this bug to be fixed in
>      > Linux, since Linux is non-conformant to the protocol.
>=20
> Yes. I saw a mail with a justification for why you want to be able to
> wait on > 2^64 outstanding lock requests to a single lockd server, and
> was highly amused.
> I'm still hoping the person who decided that he needed 1024 byte
> long cookies will own up some day. OTOH, he might still be busy
> testing his locking code for cookie wraparound...
>=20
>=20
> Anyhow, a patch exists (written by Greg Banks), and can be found as
>=20
>  http://www.fys.uio.no/~trondmy/src/Linux-2.4.x/2.4.23-pre9/linux-2.4.23-=
01-fix_osx.dif
>=20
>=20
> No. It does not extend the cookie size to 1k...

Thanks..obviously we'd like a fix to be committed to Linux so that it
interoperates out of the box with FreeBSD.  What are the chances of
this?

Kris

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (FreeBSD)

iD8DBQE/qyVaWry0BWjoQKURAkVKAKDX/jpjQzR9jEIQlI70f1i2TDNYvwCeO823
GRIaVQ3npcOXXTq7KHiFosU=
=4H9C
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
