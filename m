Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbUENRQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbUENRQg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 13:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbUENRQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 13:16:36 -0400
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:39618 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S261787AbUENRQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 13:16:33 -0400
Date: Fri, 14 May 2004 10:16:31 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Michal Semler <cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VMAX USB-STORAGE - kernel deadlock
Message-ID: <20040514171631.GA25128@one-eyed-alien.net>
Mail-Followup-To: Michal Semler <cijoml@volny.cz>,
	linux-kernel@vger.kernel.org
References: <200405141509.25967.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <200405141509.25967.cijoml@volny.cz>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Try mounting /dev/sda instead of a partition.

Matt

On Fri, May 14, 2004 at 03:09:25PM +0200, Michal Semler wrote:
> Hi,
>=20
> my friend bought usb flash disk VMAX/USB2.0/0404 version.
> Under WinXP it works, but not under Linux.
> There is 1 vfat filesystem, but linux reports 4 and when I try mount one,=
=20
> kernel goes to deadlock. System reports bad size too.
>=20
> Tested 2.4.26, 2.6.6
>=20
> Here is output:
>=20
> SCSI subsystem initialized
> Initializing USB Mass Storage driver...
> scsi0 : SCSI emulation for USB Mass Storage devices
>   Vendor: VMAX      Model: 128MB             Rev: 2.00
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> USB Mass Storage device found at 2
> usbcore: registered new driver usb-storage
> USB Mass Storage support registered.
> sda: Unit Not Ready, sense:
> Current : sense key Unit Attention
> Additional sense: Not ready to ready change, medium may have changed
> SCSI device sda: 256000 512-byte hdwr sectors (131 MB)
> sda: assuming Write Enabled
> sda: assuming drive cache: write through
>  sda: sda1 sda2 sda3 sda4
>=20
> Michal

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I'm a pink gumdrop! How can anything be worse?!!
					-- Erwin
User Friendly, 10/4/1998

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFApP7vIjReC7bSPZARAvUcAKCsgW95fL8E7Y1whfnpuiVTyNX19ACfZNmW
VzdrzwyxAMrSCJm/M1tZMqU=
=SkAC
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
