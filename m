Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbUKSXMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbUKSXMb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 18:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbUKSXKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 18:10:23 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:25541 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S261677AbUKSXIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 18:08:34 -0500
Date: Fri, 19 Nov 2004 15:08:20 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Stelian Pop <stelian@popies.net>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] usb-storage should enable scsi disk in Kconfig
Message-ID: <20041119230820.GB32455@one-eyed-alien.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Christoph Hellwig <hch@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20041119193350.GE2700@deep-space-9.dsnet> <20041119195736.GA8466@infradead.org> <20041119213942.GG2700@deep-space-9.dsnet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
In-Reply-To: <20041119213942.GG2700@deep-space-9.dsnet>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 19, 2004 at 10:39:42PM +0100, Stelian Pop wrote:
> On Fri, Nov 19, 2004 at 07:57:36PM +0000, Christoph Hellwig wrote:
>=20
> > On Fri, Nov 19, 2004 at 08:33:50PM +0100, Stelian Pop wrote:
> > > As $subject says, usb-storage storage should automatically enable
> > > scsi disk support in Kconfig.
> > >=20
> > > Please apply.
> >=20
> > No, it shouldn't.  There's lots of usb storage devices that don't use
> > sd, as there are lots of SPI/FC/etc.. devices.
>=20
> Indeed, I should have checked more carefully. My bad.
>=20
> Still, it is not obvious that one should go into a completly different
> config section and manually enable sd support, and I have been bitten
> by this more than one time.
>=20
> Maybe we should add, just below the 'USB storage' Kconfig option another
> one, let's say 'SCSI disk based USB storage support', which documentation
> would talk about 'usb keys, memory stick readers, USB floppy drives etc',
> which should just be a dummy option selecting  BLK_DEV_SD ?
>=20
> Or perhaps we should add something along the Debian's dpkg 'suggests' rule
> to Kconfig ? :)

I get enough e-mail on this topic that we should do something about it.
We need some sort of 'suggests' rule, or at least some sort of message to
the user to tell them to enable the high-level drivers.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

What, are you one of those Microsoft-bashing Linux freaks?
					-- Customer to Greg
User Friendly, 2/10/1999

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBnnzkIjReC7bSPZARAkl8AJ9zrhVv2T/a0Ml3zjusoLADE8w3UwCcCTfd
t8pL+Wla2LuQdIVR23MPg74=
=V97u
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
