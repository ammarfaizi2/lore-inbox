Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265507AbRF1Dg6>; Wed, 27 Jun 2001 23:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265505AbRF1Dgs>; Wed, 27 Jun 2001 23:36:48 -0400
Received: from secure.hostnoc.net ([66.96.192.200]:25865 "EHLO
	secure.hostnoc.net") by vger.kernel.org with ESMTP
	id <S265503AbRF1Dgb>; Wed, 27 Jun 2001 23:36:31 -0400
Date: Wed, 27 Jun 2001 23:35:41 -0400
From: "J. Nick Koston" <nick@burst.net>
To: John Cavan <johnc@damncats.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Asus CUV4X-DLS
Message-ID: <20010627233541.A32271@burst.net>
In-Reply-To: <20010627215304.D28795@burst.net> <3B3AA1DE.E4419FA8@damncats.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B3AA1DE.E4419FA8@damncats.org>; from johnc@damncats.org on Wed, Jun 27, 2001 at 11:17:50PM -0400
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - secure.hostnoc.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [1003 1004] / [1003 1004]
X-AntiAbuse: Sender Address Domain - secure.hostnoc.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks for the tips, however it doesn't help :-(

Anyways in case anyone is curious the i/o problem still happens
with an aic7xxx card put in and the onboard scsi disabled.

[snip]=20
> "J. Nick Koston" wrote:
> >=20
> > There seems to be a major problem with this board and 2.4.x kernels.
> > I consistantly get SCSI Input/Output errors on multiple drives that I
> > know are good when running a SMP kernel.  These errors do no happen
> > with a UP kernel.  This is happening on multiple systems and with
> > multiple know good scsi drives of all speeds and sizes.
>=20
> Make sure you have the latest BIOS upgrade and set the MPS revision in
> the BIOS to 1.1 rather than 1.4. This cured a similar issue for me and
> USB on the CUV4X-D motherboard, but as your board is different, your
> mileage may vary.

Already set at 1.1
>=20
> Also, try passing "noapic" to the kernel on boot if the problem still
> persists. The downside is that all interrupts will be handled by a
> single CPU. There is a definite problem with VIA chipsets.
>=20
Tried this as well (mentioned in my original email)

> John

--=20

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7OqYMT5huNxcQLWARAophAKCDUQmxrEfygazQmLD1xE3YNNCxGwCeMD43
h6PXcM/sgJKhvuE5P1kqH4Y=
=By1P
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
