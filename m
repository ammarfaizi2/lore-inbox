Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268489AbUHYHWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268489AbUHYHWh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 03:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268497AbUHYHWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 03:22:37 -0400
Received: from trantor.org.uk ([213.146.130.142]:36289 "EHLO trantor.org.uk")
	by vger.kernel.org with ESMTP id S268489AbUHYHWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 03:22:20 -0400
Subject: Re: Linux Incompatibility List
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: public@mikl.as
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200408250159.20606.public@mikl.as>
References: <87r7q0th2n.fsf@dedasys.com> <200408211955.44914.public@mikl.as>
	 <1093233294.26293.46.camel@sherbert>  <200408250159.20606.public@mikl.as>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3M4kf8HoqHkYBTfq2ffq"
Date: Wed, 25 Aug 2004 08:21:33 +0100
Message-Id: <1093418493.18600.10.camel@sherbert>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3M4kf8HoqHkYBTfq2ffq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-08-25 at 01:59 -0400, Andrew Miklas wrote:
> I've been working with a few people to reverse engineer the drivers inclu=
ded=20
> with the WAP54G 1.08.  We're about 50% done translating them back into C.=
 =20
> Once we're done, we plan to study the driver in order to write our own fr=
om=20
> scratch, or ask someone else to cleanroom it.
>=20
> However, it's likely that by the time we're done (if ever), the hardware =
will=20
> be supplanted by something else.  We've learnt the hard way that reverse=20
> engineering a 420K binary, and completing in a reasonable time isn't as e=
asy=20
> as it sounds.  :)  This is especially true when you can't simply make=20
> everything public (out of copyright concerns) and do the project in a rea=
l=20
> open source way. =20

I agreee, reverse engineering machine code is not trivial, especially
with the tools currently available. However I don't think that the
difficulty is intrinsic. It is possible (though obviously not simple) to
wite software that is able to infer a great deal from machine code
automatically and produce pretty good decompilations.

Also I think that the pciproxy[0] technique currently offers a simpler
solution. Analyzing the data produced is more akin to reverse
engineering a network protocol than machine code. Reverse engineering
protocols is much less 'copyright sensitive' than decompiling machine
code and, I think, more easily shared.

Anyway, perhaps once I've had some time to make a little more progress
we would be able to compare some notes?

[0]. I should probably explain the technique. It basically involves
running supported operating systems under a PC emulator, and trapping
and logging i/o on the PCI bus.

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/scaramanga.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-3M4kf8HoqHkYBTfq2ffq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBLD39kbV2aYZGvn0RAkgfAJ0ZdeRfgcGtncxd5EEcHa9GeftDswCeMdvv
/b1wvaHhfjGyFs5TAKwnvyg=
=iEyl
-----END PGP SIGNATURE-----

--=-3M4kf8HoqHkYBTfq2ffq--

