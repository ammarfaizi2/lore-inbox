Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbUCHW72 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 17:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbUCHW72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 17:59:28 -0500
Received: from legolas.restena.lu ([158.64.1.34]:10193 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S261393AbUCHW7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 17:59:25 -0500
Subject: Re: [PATCH] 2.6, 2.4, Nforce2, Experimental idle halt workaround
	instead of apic ack delay.
From: Craig Bradney <cbradney@zip.com.au>
To: a.verweij@student.tudelft.nl
Cc: Ross Dickson <ross@datscreative.com.au>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       Ian Kumlien <pomac@vapor.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       Daniel Drake <dan@reactivated.net>
In-Reply-To: <Pine.GHP.4.44.0403082315490.3880-100000@elektron.its.tudelft.nl>
References: <Pine.GHP.4.44.0403082315490.3880-100000@elektron.its.tudelft.nl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-s8vqQ/V/3OUFrAq6J2Hz"
Message-Id: <1078786761.9399.15.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 08 Mar 2004 23:59:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-s8vqQ/V/3OUFrAq6J2Hz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Arjen

<snip>

> So far I have seen this only once, and I don't know what causes it.
>=20
> Ross, I prefer using your old patch because it keeps my temperature withi=
n
> reasonable bounds when the case is closed. Sorry.
>=20

<snip>

I have put the idle=3DC1halt patch that Ross released a little while back
now into Gentoo-dev-sources-2.6.3 as I reported to the list yesterday. I
no longer use the old apic_tack=3D2 patch. I have been playing silly
buggers with hardware, but so far the PC has made it to 11 hours and now
7 hours with no issues.=20

After those 11 hours I decided I'd change the PC setup in here and
disconnected a fan and a hard drive and moved my server s/w (apache etc)
to this PC so I only have one in here fpr now.

Right now, CPU is at 34C which is only 1-3C higher than with the other
patch, including having one less fan sucking air out the back of the
box. Motherboard is actually lower (27C) than before (29C). Ambient room
temp is normal.

After those 11 hours, I am quite sure that on normal use (ie not
compiling) the motherboard and cpu was 1-2C lower than with apic_tack=3D2.

regards
Craig

--=-s8vqQ/V/3OUFrAq6J2Hz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBATPrJi+pIEYrr7mQRAhXWAKCn3pn/h7lar8FLQE8Ltj/SMIIfXwCgn5cK
n9+5qp8khYIZuE57NhFjRA4=
=04RR
-----END PGP SIGNATURE-----

--=-s8vqQ/V/3OUFrAq6J2Hz--

