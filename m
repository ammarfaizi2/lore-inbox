Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264183AbUFSQKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbUFSQKA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 12:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264191AbUFSQKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 12:10:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45958 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264183AbUFSQJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 12:09:53 -0400
Subject: Re: [PATCH] Stop printk printing non-printable chars
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: matthew-lkml@newtoncomputing.co.uk
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20040619154907.GE5286@newtoncomputing.co.uk>
References: <20040618205355.GA5286@newtoncomputing.co.uk>
	 <1087643904.5494.7.camel@imladris.demon.co.uk>
	 <20040619154907.GE5286@newtoncomputing.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-T0EEnDn3qhaA4FbaF3BW"
Organization: Red Hat UK
Message-Id: <1087661385.15190.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 19 Jun 2004 18:09:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-T0EEnDn3qhaA4FbaF3BW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-06-19 at 17:49, matthew-lkml@newtoncomputing.co.uk wrote:
> On Sat, Jun 19, 2004 at 12:18:24PM +0100, David Woodhouse wrote:
> > On Fri, 2004-06-18 at 21:53 +0100, matthew-lkml@newtoncomputing.co.uk
> > wrote:
> > > The main problem seems to be in ACPI, but I don't see any reason for
> > > printk to even consider printing _any_ non-printable characters at al=
l.
> > > It makes all characters out of the range 32..126 (except for newline)
> > > print as a '?'.
> >=20
> > Please don't do that -- it makes printing UTF-8 impossible. While I'd
> > not argue that now is the time to start outputting UTF-8 all over the
> > place, I wouldn't accept that it's a good time to _prevent_ it either,
> > as your patch would do.
>=20
> Please forgive me if I'm wrong on this, but I seem to remember reading
> something a while ago indicating that the kernel is and always will be
> internally English (i.e. debugging messages and the like) as there is no
> need to bloat it with many different languages (that can be done in
> userspace). As printk is really just a log system, I personally don't
> see any way that it should ever print anything other than ASCII.

english !=3D no-UTF8.

Names of people and things still can be UTF8 ....


--=-T0EEnDn3qhaA4FbaF3BW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA1GVIxULwo51rQBIRAqvZAJ9OdeOiMDVRj+IIqsJ3Sn0Jx4DFNQCfRPBN
mFhsTulNJECKxKUaxn3SkUQ=
=5K4J
-----END PGP SIGNATURE-----

--=-T0EEnDn3qhaA4FbaF3BW--

