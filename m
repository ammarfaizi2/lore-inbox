Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbVBBHEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbVBBHEt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 02:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVBBHEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 02:04:48 -0500
Received: from smtp1.pp.htv.fi ([213.243.153.34]:17834 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S262112AbVBBHEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 02:04:45 -0500
Date: Wed, 2 Feb 2005 09:04:43 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SuperHyway bus support
Message-ID: <20050202070443.GA25641@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20041027075248.GA26760@pointless.research.nokia.com> <20050107072222.GB24441@kroah.com> <20050107094103.GA7408@pointless.research.nokia.com> <20050107162945.GA19043@pointless.research.nokia.com> <20050112081722.GA2745@kroah.com> <20050112124836.GA9315@pointless.research.nokia.com> <20050201220552.GA13994@kroah.com> <20050201222327.GA3200@mars.ravnborg.org> <20050201223008.GA14331@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20050201223008.GA14331@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 01, 2005 at 02:30:08PM -0800, Greg KH wrote:
> On Tue, Feb 01, 2005 at 11:23:27PM +0100, Sam Ravnborg wrote:
> > On Tue, Feb 01, 2005 at 02:05:52PM -0800, Greg KH wrote:
> > > >  drivers/sh/Makefile                      |    6=20
> > > >  drivers/sh/superhyway/Makefile           |    7 +
> > > >  drivers/sh/superhyway/superhyway-sysfs.c |   45 ++++++
> > > >  drivers/sh/superhyway/superhyway.c       |  201 ++++++++++++++++++=
+++++++++++++
> > > >  include/linux/superhyway.h               |   79 ++++++++++++
> > > >  5 files changed, 338 insertions(+)
> >=20
> > Why does it need a .h file in include/linux/?
> > Only use include/linux/* for .h files which is used by other parts of
> > the kernel.
> >=20
> > [I've lost the original mail - so cannot see the actual source].
>=20
> Other parts of the kernel will use that .h file when they register
> themselves with the sh bus.  Right Paul?
>=20
Yes, that's correct. Any driver with a SuperHyway device will need it,
and this will be on multiple architectures (sh and sh64).

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCAHuL1K+teJFxZ9wRAuWyAJ0ZxH6Y0qU/kPTvU750z2xSp4TZ/gCfdrNr
6V+y1gZ5H+4tD4vCebGv4Lk=
=rnP1
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
