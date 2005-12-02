Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbVLBJBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbVLBJBW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 04:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbVLBJBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 04:01:21 -0500
Received: from populous.netsplit.com ([62.49.129.34]:10627 "EHLO
	mailgate.netsplit.com") by vger.kernel.org with ESMTP
	id S1750934AbVLBJBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 04:01:21 -0500
Subject: Re: Two module-init-
From: Scott James Remnant <scott@ubuntu.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, linux-input@atrey.karlin.mff.cuni.cz,
       vojtech@suse.cz
In-Reply-To: <1133482376.4094.11.camel@localhost.localdomain>
References: <1133359773.2779.13.camel@localhost.localdomain>
	 <1133482376.4094.11.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Mvs0HsEo+jeCopFFc8gv"
Date: Fri, 02 Dec 2005 09:01:14 +0000
Message-Id: <1133514074.20712.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Mvs0HsEo+jeCopFFc8gv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-12-02 at 11:12 +1100, Rusty Russell wrote:

> On Wed, 2005-11-30 at 14:09 +0000, Scott James Remnant wrote:
> > Hi Rusty,
> >=20
> > Attached are two patches to module-init-tools from Ubuntu.
> >=20
> > The first (input_table_size) is a catch-up with 2.6.15, it's adding an
> > extra field to the input_device_id struct; m-u-t needs updating to be
> > able to read the modules correctly.
>=20
> Unfortunately, it's not that simple.  Your patch will break previous
> kernels, which have a smaller structure.  I've had the discussion years
> ago with the input people on using module aliases, and it's not entirely
> trivial.  I will prepare another patch, however.
>=20
Are the modules.*map files intended to be deprecated entirely in favour
of aliases?  The problem this patch fixed was that the parser couldn't
read the tables, so produced invalid output for the modules (ie. an
empty modules.inputmap).

Scott
--=20
Scott James Remnant
scott@ubuntu.com

--=-Mvs0HsEo+jeCopFFc8gv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDkA1aSnQiFMl4yK4RAh+oAJ4tE9BMCnm2HdusAAIy/GFAl7ZOIACfVcmT
XjN6dLaYHzZPVVXZwC2JiR0=
=MpJH
-----END PGP SIGNATURE-----

--=-Mvs0HsEo+jeCopFFc8gv--

