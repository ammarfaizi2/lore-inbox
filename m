Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUBJVwW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 16:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbUBJVwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 16:52:22 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:2450 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S261606AbUBJVwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 16:52:16 -0500
Date: Tue, 10 Feb 2004 13:52:13 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Gidon <gidon@warpcore.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel GPL Violations and How to Research
Message-ID: <20040210215213.GA8092@one-eyed-alien.net>
Mail-Followup-To: Gidon <gidon@warpcore.org>, linux-kernel@vger.kernel.org
References: <1076388828.9259.32.camel@CPE-65-26-89-23.kc.rr.com> <20040210192007.GA6987@one-eyed-alien.net> <1076449796.6373.3.camel@CPE-65-26-89-23.kc.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <1076449796.6373.3.camel@CPE-65-26-89-23.kc.rr.com>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2004 at 03:49:56PM -0600, Gidon wrote:
> On Tue, 2004-02-10 at 13:20, Matthew Dharm wrote:
> > As a final level of analysis, you can always look at the compiled binary
> > code -- if you think they are using a _reasonably_ compatible compiler,=
 you
> > might actually be able to find long sections of identical or near-ident=
ical
> > assembly (modulo loop unrolling, etc. which you should be able to ident=
ify
> > by hand.)
>=20
> Your advice is appreciated. I will do some further research using
> objdump. I believe they use gcc.
>=20
> One thing I am unsure of is how to approach them and ensure at the same
> time that the problem is taken care of. Another words, if I show them
> what's wrong, they may simply obfuscate it (although at this time I hope
> not) and then I have no way to easily prove anything anymore...

Obfuscation can obscure the names of functions, but generally not string
constants or the structure of functions calling other functions.

Tho, if it comes to that point, you need a lawyer.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

What, are you one of those Microsoft-bashing Linux freaks?
					-- Customer to Greg
User Friendly, 2/10/1999

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAKVKNIjReC7bSPZARAl5NAKCgn5QWUj5nK1oQa9tf9542NvyJ7gCeNX0a
CEO8iwMmtmfya3CrjQxOd6k=
=W3Qk
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
