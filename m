Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbUACWOd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 17:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263836AbUACWOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 17:14:33 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:52903 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S263793AbUACWOa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 17:14:30 -0500
Subject: Re: does udev really require hotplug?
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Andrea Barisani <lcars@gentoo.org>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       linux-hotplug-devel@lists.sourceforge.net
In-Reply-To: <20040102225627.GB24688@sole.infis.univ.trieste.it>
References: <20040102101051.GA12073@sole.infis.univ.trieste.it>
	 <20040102201905.GB4992@kroah.com>
	 <20040102225627.GB24688@sole.infis.univ.trieste.it>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Wiq7UY0aeJFFK8t82Gbt"
Message-Id: <1073168233.6075.48.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 04 Jan 2004 00:17:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Wiq7UY0aeJFFK8t82Gbt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-01-03 at 00:56, Andrea Barisani wrote:
> On Fri, Jan 02, 2004 at 12:19:05PM -0800, Greg KH wrote:
> > On Fri, Jan 02, 2004 at 11:10:51AM +0100, Andrea Barisani wrote:
> > >=20
> > > Hi everybody and happy new year!
> > >=20
> > > Just one simple question about a very simple matter that right now=20
> > > I can't figure out: does udev need hotplug package presence?
> > >=20
> > > >From your README:
> > >=20
> > >   If for some reason you do not install the hotplug scripts, you must=
 tell the
> > >   kernel to point the hotplug binary at wherever you install udev at.=
  This can
> > >   be done by:
> > > 	echo "/sbin/udev" > /proc/sys/kernel/hotplug
> > >=20
> > >=20
> > > ...does this work properly?
> >=20
> > It should.  Does it not for you?
> >=20
> > > It's not clear if some features are lost by not having hotplug script
> > > installed.
> >=20
> > None of the other programs that hook off of the hotplug program will be
> > available to you if you do this (automatic driver loading, firmware
> > loading, devlabel, etc.)
> >=20
> > > Also is this policy subject to changes in the near future?
> >=20
> > What policy?  If you don't have the hotplug package installed, then you
> > can still use udev.  If you have the hotplug package installed, I've
> > detailed how you can still use udev.  What's the problem?  :)
> >=20
> > thanks,
> >=20
> > greg k-h
>=20
> Ok, now it's all clear :). It wasn't so clear from the documentation (at
> least for me) and since I'm not fully familiar with hotplug features I've
> decided to ask ;).
>=20

You do know that latest unstable initscripts from Gentoo _do_ support
udev with or _without_ hotplug?  If you have any further issues, please
give me a shout.


Thanks,

--=20
Martin Schlemmer

--=-Wiq7UY0aeJFFK8t82Gbt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/9z9pqburzKaJYLYRAmzOAJ0d4rLh+wcMKoujy8D9tDVi2afTOwCfQpzF
Gi1uiIXUgHjNhkQjbBTOeyY=
=Rk44
-----END PGP SIGNATURE-----

--=-Wiq7UY0aeJFFK8t82Gbt--

