Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318832AbSG0VuS>; Sat, 27 Jul 2002 17:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318833AbSG0VuS>; Sat, 27 Jul 2002 17:50:18 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:20747 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S318832AbSG0VuR>; Sat, 27 Jul 2002 17:50:17 -0400
Date: Sat, 27 Jul 2002 14:49:22 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: David Ford <david+cert@blue-labs.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
Subject: Re: Linux booting from USB HD / USB interface devices
Message-ID: <20020727144922.E2730@one-eyed-alien.net>
Mail-Followup-To: David Ford <david+cert@blue-labs.org>,
	linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
References: <3D42E333.4010602@blue-labs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="WBsA/oQW3eTA3LlM"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D42E333.4010602@blue-labs.org>; from david+cert@blue-labs.org on Sat, Jul 27, 2002 at 02:15:15PM -0400
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WBsA/oQW3eTA3LlM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 27, 2002 at 02:15:15PM -0400, David Ford wrote:
> Linux booting from USB HD
>=20
> 1) Most motherboard vendors (that mention Linux) are indicating Linux=20
> 2.4.x for support.  How is the USB Mass storage support in 2.4.19+?

It works nicely for many people.

> 2) There are some vague comments about some devices requiring the=20
> ability to boot, are there some USB hard drives that are incapable of=20
> acting as a boot device?

Yes.  They are few, tho.  The USB-IF is currently working on a bootability
standard to eliminate this problem.

> 3) I don't suspect there is anything tricky or nonstandard that I'd need=
=20
> to do on the USB drive, do I need corrected?

No correction.

> 4) What kind of USB hard drives are well supported in Linux?

See www.linux-usb.org for a link to a list of good devices.

> 5) What kernel issues do I need to be aware of?

THe stock kernel won't work.  There are patches floating around to make
this work.  Basically, the kernel needs to pause for a couple of seconds
before attempting to mount the root fs so that the plug-n-pray detection
can work, identify the drive, and get going.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Okay, this isn't funny anymore! Let me down!  I'll tell Bill on you!!
					-- Microsoft Salesman
User Friendly, 4/1/1998

--WBsA/oQW3eTA3LlM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9QxViIjReC7bSPZARArgmAKCp4Fw9l/M/fY3kU1GDNYSIl/nTfwCfZljG
W4qIxCQLXyuAUFXBBKBriIE=
=SQnb
-----END PGP SIGNATURE-----

--WBsA/oQW3eTA3LlM--
