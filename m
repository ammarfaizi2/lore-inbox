Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265673AbUATTYs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 14:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265690AbUATTYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 14:24:48 -0500
Received: from mcgroarty.net ([64.81.147.195]:47496 "EHLO pinkbits.internal")
	by vger.kernel.org with ESMTP id S265673AbUATTYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 14:24:00 -0500
Date: Tue, 20 Jan 2004 13:24:01 -0600
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ALSA vs. OSS
Message-ID: <20040120192401.GA5685@mcgroarty.net>
References: <1074532714.16759.4.camel@midux> <microsoft-free.87vfn7bzi1.fsf@eicq.dnsalias.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <microsoft-free.87vfn7bzi1.fsf@eicq.dnsalias.org>
X-Debian-GNU-Linux: Rocks
From: Brian McGroarty <brian@mcgroarty.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2004 at 03:48:54AM +1000, Steve Youngs wrote:
> * Markus H?stbacka <midian@ihme.org> writes:
>=20
>   > but ALSA didn't let me to open two sound sources (like XMMS and
>   > Quake3) at the same time, so I guess it is not really done yet, or
>   > is it?
>=20
> Works for me.  Right now I've got 3 instances of mpg123 playing 3
> different MP3s and XEmacs playing a big .wav file and an audio CD
> playing.  It's a horrible jumbled mess of noise coming out of my
> speakers, but it is working.

You probably have a Soundblaster Live or similar, which has multiple
hardware wave outputs.

OSS has software mixing. ALSA seems designed for people relying on
esd, aRts or similar multiplexing daemons.

It's possible to run a program via 'esddsp' or 'artsdsp' to reroute
/dev/dsp to the daemon, but the overhead isn't so nice, and the output
quality is often wanting.

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFADYBR2PBacobwYH4RAoktAJ0W/U3gAyCqHQzy2PTVBUKKcfa4OACdF2Pk
BcsQ1NMu4kDpWdXcrwnUSWU=
=84W+
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
