Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135403AbRDMEup>; Fri, 13 Apr 2001 00:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135404AbRDMEug>; Fri, 13 Apr 2001 00:50:36 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:12292 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S135403AbRDMEuX>; Fri, 13 Apr 2001 00:50:23 -0400
Date: Thu, 12 Apr 2001 23:50:07 -0500
From: Bob McElrath <rsmcelrath@students.wisc.edu>
To: Erik DeBill <edebill@swbell.net>
Cc: John Madden <weez@freelists.org>, linux-kernel@vger.kernel.org
Subject: Re: k 2.4.2; usb; handspring-visor
Message-ID: <20010412235007.A3118@draal.physics.wisc.edu>
In-Reply-To: <01041109595000.00940@horus.arge> <0104110852300F.25330@weez> <20010412235203.A30278@austin.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010412235203.A30278@austin.rr.com>; from edebill@swbell.net on Thu, Apr 12, 2001 at 11:52:03PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Erik DeBill [edebill@swbell.net] wrote:
> On Wed, Apr 11, 2001 at 08:52:30AM -0500, John Madden wrote:
> > > Apr  8 23:33:09 horus kernel: hub.c: USB new device connect on bus1/1,
> > > assigned device number 5
> > > Apr  8 23:33:12 horus kernel: usb_control/bulk_msg: timeout
> > > Apr  8 23:33:12 horus kernel: usb.c: USB device not accepting new
> > > address=3D5 (error=3D-110)
> >=20
> > Funny, I've been getting the same messages (on 2.4.0 and now 2.4.3) for=
 a=20
> > while now, and I thought the problem was with my Visor.  (...I haven't=
=20
> > been able to sync for months...)
>=20
> Have you tried using the normal UHCI driver, instead of the UHCI
> Alternate Driver (JE)?  I know the "alternate" one is default from
> Linus, but it's incompatible with the usb-visor driver.  The
> maintainer said he'd patch the docs to clear up the confusion, but it
> hasn't shown up in the mainstream kernels yet.

I've also been seeing these messages (for a very, very long time), with
both the uhci and usb-uhci drivers, with many different devices (not
just visor).  Usually the only way to fix it is to have the usb stuff
compiled as modules, remove it all, and the re-insmod it all.  Then it
works again for a little while...

There really needs to be only one driver.  It's just confusing.

> In my case, trying to use the visor would actually lock up the
> machine, requiring a cold boot.  Switched to the other UHCI driver
> and it works fine.

Never had to reboot though...on either x86 or alpha with UHCI...

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjrWhX8ACgkQjwioWRGe9K0PiQCfSjmo03qbO3y5nRyxusGE6IKA
hncAn11RaJzmCdZJjrMhzdhh7+SkzFeC
=h54m
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
