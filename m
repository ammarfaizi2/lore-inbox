Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135668AbRD2BGp>; Sat, 28 Apr 2001 21:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135660AbRD2BG0>; Sat, 28 Apr 2001 21:06:26 -0400
Received: from adsl-63-199-250-45.dsl.sndg02.pacbell.net ([63.199.250.45]:51471
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S135621AbRD2BGV>; Sat, 28 Apr 2001 21:06:21 -0400
Date: Sat, 28 Apr 2001 18:06:16 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
        mailhot@enst.fr, markus@schlup.net
Subject: Re: Dane-Elec PhotoMate Combo
Message-ID: <20010428180616.B30295@one-eyed-alien.net>
Mail-Followup-To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net, mailhot@enst.fr,
	markus@schlup.net
In-Reply-To: <UTC200104281502.RAA26232.aeb@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200104281502.RAA26232.aeb@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Sat, Apr 28, 2001 at 05:02:21PM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 28, 2001 at 05:02:21PM +0200, Andries.Brouwer@cwi.nl wrote:
> I just got a Dane-Elec PhotoMate Combo SmartMedia/CompactFlash reader
> manufactured by SCM Microsystems. It is a USB device with ID 04e6:0005.
>=20
> The http://www.qbik.ch/usb/devices/ list of supported devices
> calls this thing unsupported, and mailhot@enst.fr writes:
> "I want this to work ! I'll help testing."
>=20
> I think the status can be changed to fully supported, at least
> it works fine in my first tests.
>=20
> Changes required:
> (i) in sd.c there is a peculiar code fragment that assumes
> that a removable disk is write protected in case the status is unknown;
> reversing this default allows writing to the flash card.

This is an unsafe assumption.  The code fragment you call "peculiar" is
definately necessary.

> (ii) this card needs usb/storage/dpcm.c which is compiled when
> CONFIG_USB_STORAGE_DPCM is set, but this variable is missing
> from usb/Config.in. Add it.

This config option is considered so immature that it's not ready for the
kernel config, even as an EXPERIMENTAL.  Use it at your own risk.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

A female who groks UNIX?  My universe is collapsing.
					-- Mike
User Friendly, 10/11/1998

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE662kIz64nssGU+ykRAuLsAJ45wQP1MbbIDSkEhkS+/XA/j0dwZwCggLH8
7FlkIUBXLQObMOeHj6VZLYo=
=ZMj4
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
