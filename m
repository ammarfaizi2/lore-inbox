Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272430AbTGaHwU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 03:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272808AbTGaHwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 03:52:20 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:62472 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S272430AbTGaHwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 03:52:18 -0400
Date: Thu, 31 Jul 2003 00:52:13 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Greg KH <greg@kroah.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Grant Miner <mine0057@mrs.umn.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Zio! compactflash doesn't work
Message-ID: <20030731005213.B7207@one-eyed-alien.net>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Andries Brouwer <aebr@win.tue.nl>,
	Grant Miner <mine0057@mrs.umn.edu>, linux-kernel@vger.kernel.org
References: <3F26F009.4090608@mrs.umn.edu> <20030730231753.GB5491@kroah.com> <20030731011450.GA2772@win.tue.nl> <20030731041103.GA7668@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030731041103.GA7668@kroah.com>; from greg@kroah.com on Wed, Jul 30, 2003 at 09:11:03PM -0700
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2003 at 09:11:03PM -0700, Greg KH wrote:
> On Thu, Jul 31, 2003 at 03:14:50AM +0200, Andries Brouwer wrote:
> > On Wed, Jul 30, 2003 at 04:17:53PM -0700, Greg KH wrote:
> > > On Tue, Jul 29, 2003 at 05:07:05PM -0500, Grant Miner wrote:
> > > > I have a Microtech CompactFlash ZiO! USB
> > > > P:  Vendor=3D04e6 ProdID=3D1010 Rev=3D 0.05
> > > > S:  Manufacturer=3DSHUTTLE
> > > > S:  Product=3DSCM Micro USBAT-02
> > > >=20
> > > > but it does not show up in /dev; this is in 2.6.0-pre1.  (It never=
=20
> > > > worked in 2.4 either.)  config is attached.  Any ideas?
> > >=20
> > > Linux doesn't currently support this device, sorry.
> >=20
> > Hmm. I think I recall seeing people happily using that.
> > Do I misremember?
> >=20
> > Google gives
> >   http://www.scm-pc-card.de/service/linux/zio-cf.html
> > and
> >   http://usbat2.sourceforge.net/
>=20
> In looking at the kernel source, I don't see support for this device.  I
> do see support for others like it, but with different product ids.

Zio! apparently makes multiple CF readers.  Some of them are supported, but
this particular one is not, and likely never will be.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

G:   Baaap booop BAHHHP.
Mir: 9600 Baud?
Mik: No, no!  9600 goes baap booop, not booop bahhhp!
					-- Greg, Miranda and Mike
User Friendly, 12/31/1998

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/KMqtIjReC7bSPZARAnamAJ9HdubtYwwZrRZKZY4Z8iiTZmlUDACfYxmd
I/fgUXUOcFLu6pQGxS8sUtw=
=y9Zm
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
