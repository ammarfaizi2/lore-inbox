Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266613AbUBLWGa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 17:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266628AbUBLWGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 17:06:30 -0500
Received: from legolas.restena.lu ([158.64.1.34]:30147 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S266613AbUBLWGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 17:06:06 -0500
Subject: Re: [PATCH] 2.6, 2.4, Nforce2, Experimental idle halt workaround
	instead of apic ack delay.
From: Craig Bradney <cbradney@zip.com.au>
To: Derek Foreman <manmower@signalmarketing.com>
Cc: Jesse Allen <the3dfxdude@hotmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0402121544470.962@gonopodium.signalmarketing.com>
References: <200402120122.06362.ross@datscreative.com.au>
	 <Pine.LNX.4.58.0402121118490.515@gonopodium.signalmarketing.com>
	 <20040212214407.GA865@tesore.local>
	 <Pine.LNX.4.58.0402121544470.962@gonopodium.signalmarketing.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jRt/AODbNISkcHOASdSS"
Message-Id: <1076623565.16585.11.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 12 Feb 2004 23:06:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jRt/AODbNISkcHOASdSS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-02-12 at 22:52, Derek Foreman wrote:
> On Thu, 12 Feb 2004, Jesse Allen wrote:
>=20
> > On Thu, Feb 12, 2004 at 12:17:12PM -0600, Derek Foreman wrote:
> > > Some nforce2 systems work just fine.  Is there a way to distinguish
> > > between systems that need it and those that don't?
> > >
> >
> > Some nforce2 systems are fixed in certain bioses.  The problem is we
> > don't know where/what it is in the bios.  C1 disconnect is a clue.
>=20
> So a machine that locks up with stop grant enabled under one bios
> revision might run just fine with stop grant enabled on another?

Surely someone can decode the BIOS of an nforce user that is now ok
after a BIOS update?.

> > > (if anyone's running a betting pool, my money's on nforce2+cpu with h=
alf
> > > frequency multiplier ;)
> >
> > I don't know what your talking about.  My Shuttle AN35N nforce2 board
> > can run vanilla kernels with the 12-5-2003 dated bios version and not
> > lock up.  The frequencies I run are all the default/standard ones.
>=20
> Some old (model 4, I think) athlons had a problem with disconnect, but
> only in the half multiplier versions.
>=20
> Carlos' athlon has a 12.5 multiplier, so my theory's bogus

Whenthis thread first(?) started way back when in Nov or Dec last year I
was pretty happy.. no lockups until the 5th day. so what does "My
Shuttle AN35N nforce2 board can run vanilla kernels with the 12-5-2003
dated bios version and not lock up." mean?

Ross's v3 patches for 2.6/2.61 are still running well here on 2.6.1. I'm
waiting for work to settle down before trying his new ones.

Craig

--=-jRt/AODbNISkcHOASdSS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAK/jNi+pIEYrr7mQRAhfzAJ9JHTC+wmAE+q/EcLqpo1dacHAlggCeLXdt
lcfpjVyxs1jDGT/vkcv3yYk=
=gRDz
-----END PGP SIGNATURE-----

--=-jRt/AODbNISkcHOASdSS--

