Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135662AbRALXKk>; Fri, 12 Jan 2001 18:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135648AbRALXKU>; Fri, 12 Jan 2001 18:10:20 -0500
Received: from ziggy.one-eyed-alien.net ([216.120.107.189]:62213 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S135609AbRALXKP>; Fri, 12 Jan 2001 18:10:15 -0500
Date: Fri, 12 Jan 2001 15:10:08 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: "Robert J. Bell" <rob@bellfamily.org>
Cc: kernel-list <linux-kernel@vger.kernel.org>
Subject: Re: USB Mass Storage in 2.4.0
Message-ID: <20010112151008.A5798@one-eyed-alien.net>
Mail-Followup-To: "Robert J. Bell" <rob@bellfamily.org>,
	kernel-list <linux-kernel@vger.kernel.org>
In-Reply-To: <3A5F8956.9040305@bellfamily.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3A5F8956.9040305@bellfamily.org>; from rob@bellfamily.org on Fri, Jan 12, 2001 at 02:46:46PM -0800
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Please turn on USB Mass Storage debugging and send me the dmesg output from
when you attach the device and load the drivers.

Matt

On Fri, Jan 12, 2001 at 02:46:46PM -0800, Robert J. Bell wrote:
> I know there has been some talk arround this topic on this list so If I=
=20
> missed the answer I apologize, i just joined the list today. I read=20
> through the archive and all I could find relative to mass storage is the=
=20
> scsi dependancy, which I am aware of. Here is my situation.
>=20
> I have a Fujufilm FX-1400 digital camera that uses the USB Mass Storage=
=20
> driver. I know it works because I had it working in 2.4.0-test12, and in=
=20
> 2.4.0 however I had a major system failure and lost my new kernel. This=
=20
> time arround I can not get USB Mass Storage to work. I have tried=20
> various combinations of the scsi and usb options. I thought maybe I=20
> needed SCSI Disk support as well but it didnt seem to matter. I have=20
> tried with scsi and usb mass storage as modules and as part of the=20
> kernel, still no luck. Here is what happens when I connect the camera :
>=20
> Jan 10 18:49:05 t20 kernel: hub.c: USB new device connect on bus1/1,=20
> assigned device number 3
> Jan 10 18:49:05 t20 kernel: Product: USB Mass Storage
> Jan 10 18:49:05 t20 kernel: SerialNumber: Y-170^^^^^000810X0000003005237
> Jan 10 18:49:06 t20 kernel: scsi0 : SCSI emulation for USB Mass Storage=
=20
> devices
> Jan 10 18:49:06 t20 kernel:   Vendor:  `.=C0 =C0=F2=CF  Model: \206   =D8=
\177.=C0=A1#=20
> =C0 =DD=F2=CF  Rev: =FF=FF=FF=FF
> Jan 10 18:49:06 t20 kernel:   Type:   Scanner                           =
=20
> ANSI SCSI revision: 02
>=20
> Now this used to detect a scsi disk and all I had to do was mount it. I=
=20
> am sure there must be other conflicting config options but I just dont=20
> know what it could be. Any help would be greatly appreciated.
>=20
> Robert.
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Oh great modem, why hast thou forsaken me?
					-- Dust Puppy
User Friendly, 3/2/1998

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6X47Qz64nssGU+ykRAufWAKDZ5vlIdelIMjmAkeiMVZknrhQ/qACgoCY+
SLFE7L0ESsGsQlTXq6vyFyo=
=gfOC
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
