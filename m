Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266777AbSKLRpn>; Tue, 12 Nov 2002 12:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266788AbSKLRpm>; Tue, 12 Nov 2002 12:45:42 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:46240 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266777AbSKLRox>; Tue, 12 Nov 2002 12:44:53 -0500
Subject: Re: [2.5-bk] Module loader compile bug
From: Paul Larson <plars@austin.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: bheilbrun@paypal.com, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20021112172423.818182C2A0@lists.samba.org>
References: <20021112172423.818182C2A0@lists.samba.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-k2f1qRtPyI1YmwL4zOtW"
X-Mailer: Ximian Evolution 1.0.5 
Date: 12 Nov 2002 11:48:27 -0600
Message-Id: <1037123308.10626.9.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-k2f1qRtPyI1YmwL4zOtW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-11-12 at 11:23, Rusty Russell wrote:
> Yep, symbol_put_addr() in module.c should be moved under __symbol_put.
>=20
> Patch is fairly trivial, does this work for you?
> Rusty.
Fixed mine.  Only one minor thing, I still get a lot of warnings on:
include/linux/module.h:239: warning: `symbol_put' redefined

Thanks,
Paul Larson


--=-k2f1qRtPyI1YmwL4zOtW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAj3RPusACgkQg9lkBG+YkH9VeACfU5N3Kn9Tl1TWFjJTl1lrOe2v
zFgAn0NpjhBRCAHN5fidmXM237EI3aHE
=Wzp4
-----END PGP SIGNATURE-----

--=-k2f1qRtPyI1YmwL4zOtW--

