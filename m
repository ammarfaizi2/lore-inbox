Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbUAISLN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 13:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbUAISLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 13:11:13 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:54428 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S262805AbUAISLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 13:11:08 -0500
Subject: Re: stability problems with 2.4.24/Software RAID/ext3
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: martin f krafft <madduck@madduck.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040108151225.GA11740@piper.madduck.net>
References: <20040108151225.GA11740@piper.madduck.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fj0c3QUeo6KyXcmsHJgz"
Message-Id: <1073671862.24706.13.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 09 Jan 2004 19:11:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fj0c3QUeo6KyXcmsHJgz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-01-08 at 16:12, martin f krafft wrote:
> Hi all,
>=20
> I operate a groupware server which is giving me a very hard time.
> It's an AMD Athlon XP 3000+ with 1Gb of RAM, and four 7200 UPM IDE
> harddrives, two attached to the primary channels of the onboard
> controller, and two to the primary channels of a Promise 20269 EIDE
> controller. The kernel is a 2.4.24 with the configuration I placed
> here:

Try replacing the Promise controllers with something diffrent (doesn't
really matter what). I've helped a friend with a server that hung all
the time, it had a few promise-controllers. After it had hung _lots_ of
times we came to the conclusion that we should try some other IDE
controllers (we had replaced everything else) and we borrowed a few
HighPoint controllers. Guess what, the machine is stable with these
controllers :)
I don't have any more data than this.
If you manage to get it stable with another controller, maybe you are
willing to try to find out what the possible problems with the
promise-driver (or hardware) is.

The machine in question had two pdc20268 and two pdc20269 controllers
(we tried with to combine them in all possible combinations, it hung
anyway)

So if you can, try some other controllers.

I personally have a pdc20267 in my workstation that I stress quite
heavily sometimes and I've never had any problems with it.

--=20
/Martin

--=-fj0c3QUeo6KyXcmsHJgz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA//u62Wm2vlfa207ERApZCAJ92PrzHjelsrkw8l7+YnUYkAj+wwACfdZn7
QKtaBY7AgW20vSpww+NfTAE=
=VroZ
-----END PGP SIGNATURE-----

--=-fj0c3QUeo6KyXcmsHJgz--
