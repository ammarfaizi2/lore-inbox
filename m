Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263284AbTDCFzC>; Thu, 3 Apr 2003 00:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263285AbTDCFzC>; Thu, 3 Apr 2003 00:55:02 -0500
Received: from adsl-67-121-155-183.dsl.pltn13.pacbell.net ([67.121.155.183]:20448
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id <S263284AbTDCFzB>; Thu, 3 Apr 2003 00:55:01 -0500
Date: Wed, 2 Apr 2003 22:06:18 -0800
To: Brad Campbell <brad@seme.com.au>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Synaptics Touchpad loses sync 2.5.66
Message-ID: <20030403060618.GA28432@triplehelix.org>
References: <3E8BCB4F.5080900@seme.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <3E8BCB4F.5080900@seme.com.au>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 03, 2003 at 01:49:03PM +0800, Brad Campbell wrote:
> Under X 4.2.0 (Happened under 4.1.x also) the Touchpad loses sync quite=
=20
> frequently causing the mouse to go haywire, jumping all over the screen=
=20
> and sending button presses that I have not made.
> The exact same configuration works perfectly under 2.4.x

I talked about this problem on LKML around 2.5.59.

If you use an ACPI battery monitor (I notice you are on a laptop and
you have ACPI enabled), there is a lot of Bad Mojo (TM) in psmouse.c
at the moment. Just don't use it if you have a synaptics touchpad, and
things should work out immediately.

Anyone who can comment on the status of this problem? I'd like to get
it fixed too, personally, but I haven't been worrying much about it
of late.

Regards
Josh

--
New PGP public key: 0x27AFC3EE

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+i89aT2bz5yevw+4RAvTJAKCMvNazeMyNnvBI7jS9DpxePubyCACg269y
L23W1eYrE/hf19KZCTzCRnY=
=nb2c
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
