Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbUACWUt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 17:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264285AbUACWUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 17:20:48 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:54183 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S264275AbUACWUh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 17:20:37 -0500
Subject: Re: OSS sound emulation broken between 2.6.0-test2 and test3
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Chris Shafer <cshafer@toad.net>
Cc: Edward Tandi <ed@efix.biz>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040103005350.GA4960@cablespeed.com>
References: <1072479167.21020.59.camel@nosferatu.lan>
	 <1480000.1072479655@[10.10.2.4]> <1072480660.21020.64.camel@nosferatu.lan>
	 <1640000.1072481061@[10.10.2.4]> <1072482611.21020.71.camel@nosferatu.lan>
	 <2060000.1072483186@[10.10.2.4]> <1072500516.12203.2.camel@duergar>
	 <8240000.1072511437@[10.10.2.4]> <1072523478.12308.52.camel@nosferatu.lan>
	 <1072525450.3794.8.camel@wires.home.biz>
	 <20040103005350.GA4960@cablespeed.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dCo0TwhobuQ3NjIaOv01"
Message-Id: <1073168600.6075.59.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 04 Jan 2004 00:23:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dCo0TwhobuQ3NjIaOv01
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-01-03 at 02:53, Chris Shafer wrote:
> On Sat, Dec 27, 2003 at 11:44:11AM +0000, Edward Tandi scrawled:
> >=20
> > Because it only happens in XMMS I thought it was one of those
> > application bugs brought out by scheduler changes. I now use Zinf BTW
> > -It's better for large music collections (although not as stable or
> > flash).
>=20
> Have you tried and see if it occurs with the ALSA output driver for XMMS.
> Without the whole frag line set?
>=20

That should work.  The chip used for the i8[67]5 boards used to behave
like this, but apparently to somebody else on the list it was because
it could not handle variable data lengths (could have the term wrong)
written to it, and was fixed driver side - this is not maybe an issue
for the sis based boards as well (using a realtek chip i think??) ?
Meaning its chip/driver side, not OSS-emu side?


Cheers,

--=20
Martin Schlemmer

--=-dCo0TwhobuQ3NjIaOv01
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/90DYqburzKaJYLYRAp+TAJ9OALT/vmGb0J31+CSoNI/AZbywdwCcDODv
v4wFbt1Pr3Ut4fkMmkEwpNU=
=rK+S
-----END PGP SIGNATURE-----

--=-dCo0TwhobuQ3NjIaOv01--

