Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272555AbTGaRwO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 13:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274837AbTGaRwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 13:52:14 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:32525 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S272555AbTGaRwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 13:52:11 -0400
Date: Thu, 31 Jul 2003 10:52:07 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Greg KH <greg@kroah.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Grant Miner <mine0057@mrs.umn.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Zio! compactflash doesn't work
Message-ID: <20030731105207.A14118@one-eyed-alien.net>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Andries Brouwer <aebr@win.tue.nl>,
	Grant Miner <mine0057@mrs.umn.edu>, linux-kernel@vger.kernel.org
References: <3F26F009.4090608@mrs.umn.edu> <20030730231753.GB5491@kroah.com> <20030731011450.GA2772@win.tue.nl> <20030731041103.GA7668@kroah.com> <20030731005213.B7207@one-eyed-alien.net> <20030731100901.GB2772@win.tue.nl> <20030731155856.GE3202@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030731155856.GE3202@kroah.com>; from greg@kroah.com on Thu, Jul 31, 2003 at 08:58:56AM -0700
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2003 at 08:58:56AM -0700, Greg KH wrote:
> On Thu, Jul 31, 2003 at 12:09:01PM +0200, Andries Brouwer wrote:
> > On Thu, Jul 31, 2003 at 12:52:13AM -0700, Matthew Dharm wrote:
> >=20
> > > > > > > I have a Microtech CompactFlash ZiO! USB
> > > > > > > P:  Vendor=3D04e6 ProdID=3D1010 Rev=3D 0.05
> > > > > > > S:  Manufacturer=3DSHUTTLE
> > > > > > > S:  Product=3DSCM Micro USBAT-02
> > > > > > >=20
> > > > > > > but it does not show up in /dev; this is in 2.6.0-pre1.  (It =
never=20
> > > > > > > worked in 2.4 either.)  config is attached.  Any ideas?
> > > > > >=20
> > > > > > Linux doesn't currently support this device, sorry.
> > > > >=20
> > > > > Hmm. I think I recall seeing people happily using that.
> > > > > Do I misremember?
> > > > >=20
> > > > > Google gives
> > > > >   http://www.scm-pc-card.de/service/linux/zio-cf.html
> > > > > and
> > > > >   http://usbat2.sourceforge.net/
> > > >=20
> > > > In looking at the kernel source, I don't see support for this devic=
e.  I
> > > > do see support for others like it, but with different product ids.
> > >=20
> > > Zio! apparently makes multiple CF readers.  Some of them are supporte=
d, but
> > > this particular one is not, and likely never will be.
> >=20
> > This particular one has support on the place indicated.
> > Do you mean that that driver will never get into the vanilla kernel?
> > And no other driver ever will? Funny.
>=20
> No, I'm not saying that :)
> In looking at the patch, if Matt agrees that it's ok to apply I will.  I
> didn't see anything too bad in there.

Apparently these guys made more progess than I thought.  Last time I talked
to them there seemed to be the general opinion that a driver would never
get done.

However, if you read the web page, it sounds like they're really not ready
to have this merged into the mainstream kernel.  I don't like to merge
things before their authors want them merged.

I don't really have any objection to the 2.4 patch, but the 2.5 patch needs
some serious cleanup before it gets applied.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It was a new hope.
					-- Dust Puppy
User Friendly, 12/25/1998

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/KVdHIjReC7bSPZARAtABAJ94zdrgxYIeLthldaUfKfeSvEixhACgyc5O
sVtuB1hzPqdP8/+6+Qo9hw0=
=UCeV
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
