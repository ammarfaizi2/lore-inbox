Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318607AbSIHA5l>; Sat, 7 Sep 2002 20:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319550AbSIHA5l>; Sat, 7 Sep 2002 20:57:41 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:2192 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S318607AbSIHA5j>; Sat, 7 Sep 2002 20:57:39 -0400
Date: Sat, 7 Sep 2002 20:01:44 -0500
From: Bob McElrath <mcelrath+kernel@draal.physics.wisc.edu>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: ide-scsi oops
Message-ID: <20020908010144.GC4828@draal.physics.wisc.edu>
References: <20020907183328.GB5985@draal.physics.wisc.edu> <Pine.LNX.4.10.10209071143080.16589-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10209071143080.16589-100000@master.linux-ide.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Andre Hedrick [andre@linux-ide.org] wrote:
> On Sat, 7 Sep 2002, Bob McElrath wrote:
>=20
> Would you pass hdc=3Dscsi for the next reboot?

I just noticed a lot of log messages:
While playing a DVD:

Sep  7 19:39:03 localhost kernel: hdc: packet command error: status=3D0x51 =
{ DriveReady SeekComplet
e Error }
Sep  7 19:39:03 localhost kernel: hdc: packet command error: error=3D0x50
Sep  7 19:39:03 localhost kernel: ATAPI device hdc:
Sep  7 19:39:03 localhost kernel:   Error: Illegal request -- (Sense key=3D=
0x05)
Sep  7 19:39:03 localhost kernel:   Media region code is mismatched to logi=
cal unit -- (asc=3D0x6f,
 ascq=3D0x04)
Sep  7 19:39:03 localhost kernel:   The failed "Report Key" packet command =
was:=20
Sep  7 19:39:03 localhost kernel:   "a4 00 00 00 01 33 00 00 00 0c c4 00 "
Sep  7 19:39:03 localhost kernel: hdc: packet command error: status=3D0x51 =
{ DriveReady SeekComplet
e Error }
Sep  7 19:39:03 localhost kernel: hdc: packet command error: error=3D0x50
Sep  7 19:39:03 localhost kernel: ATAPI device hdc:
Sep  7 19:39:03 localhost kernel:   Error: Illegal request -- (Sense key=3D=
0x05)
Sep  7 19:39:03 localhost kernel:   System resource failure -- (asc=3D0x55,=
 ascq=3D0x00)
Sep  7 19:39:03 localhost kernel:   The failed "Report Key" packet command =
was:=20
Sep  7 19:39:03 localhost kernel:   "a4 00 00 00 00 00 00 00 00 08 c0 00 "
Sep  7 19:39:03 localhost kernel: hdc: packet command error: status=3D0x51 =
{ DriveReady SeekComplet
e Error }
[...more...]
Sep  7 19:39:20 localhost kernel: hdc: packet command error: error=3D0x50
Sep  7 19:39:20 localhost kernel: ATAPI device hdc:
Sep  7 19:39:20 localhost kernel:   Error: Illegal request -- (Sense key=3D=
0x05)
Sep  7 19:39:20 localhost kernel:   Invalid field in command packet -- (asc=
=3D0x24, ascq=3D0x00)
Sep  7 19:39:20 localhost kernel:   The failed "Report Key" packet command =
was:=20
Sep  7 19:39:20 localhost kernel:   "a4 00 00 00 00 00 00 00 00 00 bf 00 "
Sep  7 19:39:20 localhost kernel:   Error in command packet byte 10 bit 0
Sep  7 19:39:20 localhost kernel: hdc: packet command error: status=3D0x51 =
{ DriveReady SeekComplet
e Error }
Sep  7 19:39:20 localhost kernel: hdc: packet command error: error=3D0x50
Sep  7 19:39:20 localhost kernel: ATAPI device hdc:
Sep  7 19:39:20 localhost kernel:   Error: Illegal request -- (Sense key=3D=
0x05)
Sep  7 19:39:20 localhost kernel:   System resource failure -- (asc=3D0x55,=
 ascq=3D0x00)
Sep  7 19:39:20 localhost kernel:   The failed "Report Key" packet command =
was:=20
Sep  7 19:39:20 localhost kernel:   "a4 00 00 00 00 00 00 00 00 08 80 00 "
Sep  7 19:39:20 localhost kernel: hdc: packet command error: status=3D0x51 =
{ DriveReady SeekComplet
e Error }
[...more...]

Similarly when trying to 'less' files on a mounted DVD:
Sep  7 19:51:07 localhost kernel: hdc: command error: status=3D0x51 { Drive=
Ready SeekComplete Error
 }
Sep  7 19:51:07 localhost kernel: hdc: command error: error=3D0x50
Sep  7 19:51:07 localhost kernel: end_request: I/O error, dev 16:00 (hdc), =
sector 1524
[...more...]

Grrr...region encoding...This DVD should be US region and so should the
drive...I don't know how to check though.

Note that everything appears to operate normally despite the log messages.

Cheers,
-- Bob

Bob McElrath
Univ. of Wisconsin at Madison, Department of Physics

"No nation could preserve its freedom in the midst of continual warfare."
    --James Madison, April 20, 1795

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj16oXcACgkQjwioWRGe9K0nfQCg2tVrIRqUq7JVhUFXggXNa22P
3RMAoKZg49aobeBqLE67yde1pJa9/W+5
=ce4d
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
