Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbVBBHKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbVBBHKP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 02:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbVBBHKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 02:10:15 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:42720 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S262194AbVBBHKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 02:10:02 -0500
Date: Wed, 2 Feb 2005 09:10:01 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] SuperHyway bus support
Message-ID: <20050202071001.GB25641@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20041027075248.GA26760@pointless.research.nokia.com> <20050107072222.GB24441@kroah.com> <20050107094103.GA7408@pointless.research.nokia.com> <20050107162945.GA19043@pointless.research.nokia.com> <20050112081722.GA2745@kroah.com> <20050112124836.GA9315@pointless.research.nokia.com> <20050201220552.GA13994@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <20050201220552.GA13994@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 01, 2005 at 02:05:52PM -0800, Greg KH wrote:
> On Wed, Jan 12, 2005 at 02:48:36PM +0200, Paul Mundt wrote:
> > Yes, it would seem that way. Here we go again:
> >=20
> >  drivers/sh/Makefile                      |    6=20
> >  drivers/sh/superhyway/Makefile           |    7 +
> >  drivers/sh/superhyway/superhyway-sysfs.c |   45 ++++++
> >  drivers/sh/superhyway/superhyway.c       |  201 ++++++++++++++++++++++=
+++++++++
> >  include/linux/superhyway.h               |   79 ++++++++++++
> >  5 files changed, 338 insertions(+)
>=20
> Sorry for taking so long on this.  I've added it to my trees and it will
> show up in the next -mm releases.  After 2.6.11 is out I'll forward it
> on to Linus.
>=20
There's an older version of this patch currently still in -mm, so this
patch won't actually apply there directly. I can send an incremental -mm
patch that gets the current -mm implementation up to date with these
changes (or if Andrew can back out the current patch in -mm and apply this
one in place, that works too).

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCAHzJ1K+teJFxZ9wRAnNVAJ9ZYK5m8tr5ph2L0s4u8gb79KVdlwCfauIh
O1LYyTL4egCBqxvJXRZ0h6M=
=jz9N
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
