Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbTKMSEq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 13:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbTKMSEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 13:04:46 -0500
Received: from dd1234.kasserver.com ([81.209.148.157]:20436 "EHLO
	dd1234.kasserver.com") by vger.kernel.org with ESMTP
	id S264376AbTKMSEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 13:04:44 -0500
Date: Thu, 13 Nov 2003 18:04:42 +0000
From: Jochen Voss <voss@seehuhn.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: invalid SMP mptable on Toshiba Satellite 2430-301
Message-ID: <20031113180442.GA2161@seehuhn.de>
References: <20031113112740.GA4719@seehuhn.de> <Pine.LNX.4.44.0311130836150.8093-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311130836150.8093-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2003 at 08:40:16AM -0800, Linus Torvalds wrote:
>=20
> On Thu, 13 Nov 2003, Jochen Voss wrote:
> > Herbert Xu produced a patch, which converts the crash into an error
> > message, so the symptoms are cured for me.
>=20
> Ok. That panic is obviously crud from a lazy initial developer, and yes,=
=20
> it's always silly (and very very wrong) to crash if you can just continue.
>=20
> Can you send the (tested) patch over?

Herbert sent it to the list (Subject: [i386] Remove bogus panic calls
in mpparse.c).  You can find the corresponding message under

    http://www.ussg.iu.edu/hypermail/linux/kernel/0311.1/0879.html

> I really think that the Linux behaviour i smore of a bug than the BIOS=20
> behaviour. There's no excuse for panicing just because some signature=20
> for a data block that we don't even strictly need isn't there.

With the patch the crash goes away, but I get the error message

    BIOS bug, MP table errors detected!...
    ... disabling SMP support. (tell your hw vendor)

now.  I guess that means no hyperthreading for me :-(

Jochen
--=20
http://seehuhn.de/

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/s8e6f+iD8yEbECURAnYGAKCnE0vcyvs4/qOSh40kicEPoCh+IwCggtKq
NtZ1jS9Gh2FW3UFgNbPvVo4=
=cfLR
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
