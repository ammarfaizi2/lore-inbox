Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267874AbUGaIKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267874AbUGaIKS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 04:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267654AbUGaIKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 04:10:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23974 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267874AbUGaIKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 04:10:12 -0400
Subject: Re: tcp_push_pending_frames() without TCP_CORK or TCP_NODELAY
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "David S. Miller" <davem@redhat.com>
Cc: Robert White <rwhite@casabyte.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040730153700.2bb46976.davem@redhat.com>
References: <20040729193637.36d018a5.davem@redhat.com>
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAto7TSbyGCEOKEjP4Tiu9VgEAAAAA@casabyte.com>
	 <20040730153700.2bb46976.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Y00093/x4CJ6MjvebEWm"
Organization: Red Hat UK
Message-Id: <1091261406.2819.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 31 Jul 2004 10:10:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Y00093/x4CJ6MjvebEWm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-07-31 at 00:37, David S. Miller wrote:
> On Fri, 30 Jul 2004 15:02:33 -0700
> "Robert White" <rwhite@casabyte.com> wrote:
>=20
> > 4) Cork-then-uncork would still end up with two syscalls instead of one=
.
>=20
> Syscalls are incredible cheap, this is not an argument for not
> using cork'ing.

btw do we export MSG_MORE functionality to userspace ? That might be a
solution as well...

--=-Y00093/x4CJ6MjvebEWm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBC1PdxULwo51rQBIRAqqAAJ43qrd5f6SLvwF9PyyO7OVlwJsCpQCfZucp
aUwqKraP0Mp67WvpWxkuMaA=
=TkXd
-----END PGP SIGNATURE-----

--=-Y00093/x4CJ6MjvebEWm--

