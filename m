Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313638AbSHBW3f>; Fri, 2 Aug 2002 18:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317251AbSHBW3f>; Fri, 2 Aug 2002 18:29:35 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:59399 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S313638AbSHBW3e>; Fri, 2 Aug 2002 18:29:34 -0400
Date: Fri, 2 Aug 2002 15:32:30 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: David Ford <david+cert@blue-labs.org>,
       linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Linux-usb-users] Re: Linux booting from USB HD / USB interface devices
Message-ID: <20020802153230.E31990@one-eyed-alien.net>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	David Ford <david+cert@blue-labs.org>,
	linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20020728123329.C12344@one-eyed-alien.net> <Pine.LNX.4.33L2.0208021348560.14068-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="uCPdOCrL+PnN2Vxy"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L2.0208021348560.14068-100000@dragon.pdx.osdl.net>; from rddunlap@osdl.org on Fri, Aug 02, 2002 at 02:03:02PM -0700
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2002 at 02:03:02PM -0700, Randy.Dunlap wrote:
> My turn for a question:
> What files do I need to copy to a USB boot disk to be able to
> successfully boot a Linux kenrel?
> I'm already building the kernel with usb-storage support and all of
> the required SCSI support in the kernel.

You should have a full linux install on that disk.  It is, after all, going
to be the root fs.

> Won't I need to put the kernel as the primary boot image,
> i.e., don't use a boot loader on the USB storage device,
> since the boot loader won't have USB storage I/O capabilities?

Depends on your motherboard.  Some BIOSes allow loaders like LILO to work
because they provide the translation between the int13h calls and the USB
stack.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I see you've been reading alt.sex.chubby.sheep voraciously.
					-- Tanya
User Friendly, 11/24/97

--uCPdOCrL+PnN2Vxy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9Swh+IjReC7bSPZARAvsUAJwIG56AiCIYd7foSShLMFVD+fe5ZACgkpru
e4PrY2sU0KzDufCZ/aJZIP8=
=C4A6
-----END PGP SIGNATURE-----

--uCPdOCrL+PnN2Vxy--
