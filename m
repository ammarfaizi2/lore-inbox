Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265516AbSJSFCE>; Sat, 19 Oct 2002 01:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265514AbSJSFCE>; Sat, 19 Oct 2002 01:02:04 -0400
Received: from adsl-65-64-137-212.dsl.stlsmo.swbell.net ([65.64.137.212]:641
	"EHLO base.torri.linux") by vger.kernel.org with ESMTP
	id <S265516AbSJSFCD>; Sat, 19 Oct 2002 01:02:03 -0400
Subject: Detecting proper device for /dev/dvd
From: Stephen Torri <storri@sbcglobal.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-MfbY8gSqtYwY4y2xLNTf"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Oct 2002 00:07:03 -0500
Message-Id: <1035004023.13168.6.camel@base.torri.linux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MfbY8gSqtYwY4y2xLNTf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On my RedHat 8.0 system the DVD/CDRW drive is handle by the ide-scsi
module. So the link /dev/dvd points to /dev/scd0. The interface that
handles /dev/dvd is actual the IDE interface on the motherboard. So
/dev/hdc is the proper link for /dev/dvd. The reason I go into this is
because I am writing a piece of C code that is suppose to detect if DMA
is turned on for the DVD/CDRW drive. This is important for playing DVDs.
What is the best method I should go about doing this?

So far my guesses are

1) Hard code the link (only good for my system so not the ideal
solution). This is only good so far to prove that the DMA detection
works.

2) Use the /proc system to discover the proper /dev link. So far this
has provides confusing since I am not that sure of how to use the
information.

3) Require the user to edit the program's configuration file. Not the
ideal since I would like to make this as easy as possible for
non-technical or novice users of the program.

Ideas, links, documentation and examples are welcome.

Stephen



--=-MfbY8gSqtYwY4y2xLNTf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9sOh3sZ6ZpmJVIPURAnEFAKDNAEIvODHNnS1bgwO8wn8hCSYRgACgrHyR
1lcoV6w43TRHStBp56fdzGs=
=BHMJ
-----END PGP SIGNATURE-----

--=-MfbY8gSqtYwY4y2xLNTf--
