Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131372AbRAEEEP>; Thu, 4 Jan 2001 23:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131375AbRAEEEF>; Thu, 4 Jan 2001 23:04:05 -0500
Received: from ziggy.one-eyed-alien.net ([216.120.107.189]:2832 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S131372AbRAEEDq>; Thu, 4 Jan 2001 23:03:46 -0500
Date: Thu, 4 Jan 2001 20:03:33 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: Announce: modutils 2.4.0 is available
Message-ID: <20010104200333.A20175@one-eyed-alien.net>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <14993.978663552@kao2.melbourne.sgi.com> <16062.978666989@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <16062.978666989@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Fri, Jan 05, 2001 at 02:56:29PM +1100
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Well, I'll be the one to fall on my sword...

This is probably my fault.  The matching code was pretty much broken for a
non-trivial subset of usb devices.  I'd submitted the patch to Linus before
the holdiays, but it was rejected for various reasons.  After some back and
forth, Linus finally accepted it on about the 2st of the year.

It's pretty much the same patch (functionally) as I posted to the
linux-usb-devel mailing list, which I presumed would inform the hotplugging
people.  Mea culpa, I seem to have been in error there.  Tho, that was
several weeks ago, so it may have just fallen out of people's heads in the
interim time.

Keith, if you need any info on what the new structure means, please let me
know and I can fill you in on all the details.

Matt

On Fri, Jan 05, 2001 at 02:56:29PM +1100, Keith Owens wrote:
> On Fri, 05 Jan 2001 13:59:12 +1100,=20
> Keith Owens <kaos@ocs.com.au> wrote:
> >modutils-2.4.0.tar.gz           Source tarball, includes RPM spec file
>=20
> I have just found out that there was an incompatible change to struct
> usb_device_id during 2.4.0-prerelease :(((.  That means that all
> versions of depmod will break on kernel 2.4.0 if you have any modules
> that use MODULE_DEVICE_TABLE(usb).  Incompatible changes to an ABI
> structure without notification immediately prior to a major kernel
> release, yech!
>=20
> If you have usb modules then stay on kernel 2.4.0-prerelease or compile
> usb without modules or wait until I can test and release modutils
> 2.4.1.  The usb hotplug utilities will also have to change to handle
> the new table layout.
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

A:  The most ironic oxymoron wins ...
DP: "Microsoft Works"
A:  Uh, okay, you win.
					-- A.J. & Dust Puppy
User Friendly, 1/18/1998

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6VUeVz64nssGU+ykRAjDrAKCXBmqxd35/69JYXQW1cmCbHBXctgCcD/je
04rMUvNhLMG5/x29Rv+IRs4=
=GXAU
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
