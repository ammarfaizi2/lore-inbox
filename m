Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbUKVRZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbUKVRZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 12:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbUKVRZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 12:25:15 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:64195 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S262259AbUKVRUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 12:20:01 -0500
Subject: Re: Linux 2.6.9 pktgen module causes INIT process respawning and
	sickness
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: "Jeff V. Merkey" <jmerkey@devicelogics.com>
Cc: linux-kernel@vger.kernel.org, jmerkey@drdos.com
In-Reply-To: <419E6E5D.2000709@devicelogics.com>
References: <419E6B44.8050505@devicelogics.com>
	 <419E6E5D.2000709@devicelogics.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iZ19agDxGW9kghhpWm3q"
Message-Id: <1101143995.1125.12.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 22 Nov 2004 18:19:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iZ19agDxGW9kghhpWm3q
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-11-19 at 23:06, Jeff V. Merkey wrote:
> Additionally, when packets sizes 64, 128, and 256 are selected, pktgen=20
> is unable to achieve > 500,000 pps (349,000 only on my system).
> A Smartbits generator can achieve over 1 million pps with 64 byte=20
> packets on gigabit.  This is one performance
> issue for this app.  However, at 1500 and 1048 sizes, gigabit saturation=20
> is achievable.=20

What hardware are you using? 349kpps is _low_ performance at 64byte
packets.

Here you can see Roberts (pktgen author) results when testing diffrent
e1000 nics at diffrent bus speeds. He also tested 2port and 4port e1000
cards, the 4port nics have an pci-x bridge...

http://robur.slu.se/Linux/net-development/experiments/2004/040808-pktgen

I get a lot higher than 349kpps with an e1000 desktop adapter running at
32bit/66MHz.
=20
--=20
/Martin

--=-iZ19agDxGW9kghhpWm3q
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBoh+7Wm2vlfa207ERArC4AKC0xqX3R5V1l3kBkVgYamsjH7PSDwCfQWYk
1FYnHSQ7vt13zhSkr6G0Z9Y=
=+Pd4
-----END PGP SIGNATURE-----

--=-iZ19agDxGW9kghhpWm3q--
