Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262526AbVBCEyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbVBCEyb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 23:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbVBCEya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 23:54:30 -0500
Received: from zlynx.org ([199.45.143.209]:64776 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S262844AbVBCEyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 23:54:17 -0500
Subject: Re: Please open sysfs symbols to proprietary modules
From: Zan Lynx <zlynx@acm.org>
To: Greg KH <greg@kroah.com>
Cc: Pavel Roskin <proski@gnu.org>, Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050203003010.GA15481@kroah.com>
References: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain>
	 <Pine.LNX.4.50.0502021520200.1538-100000@monsoon.he.net>
	 <20050202232909.GA14607@kroah.com>
	 <Pine.LNX.4.62.0502021851050.19621@localhost.localdomain>
	 <20050203003010.GA15481@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-c0OvfhsYUEjPxkGB7o+5"
Date: Wed, 02 Feb 2005 21:54:02 -0700
Message-Id: <1107406442.23059.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c0OvfhsYUEjPxkGB7o+5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-02-02 at 16:30 -0800, Greg KH wrote:
> On Wed, Feb 02, 2005 at 07:07:21PM -0500, Pavel Roskin wrote:
> > On Wed, 2 Feb 2005, Greg KH wrote:
> > >On Wed, Feb 02, 2005 at 03:23:30PM -0800, Patrick Mochel wrote:
> > >>
> > >>What is wrong with creating a (GPL'd) abstraction layer that exports
> > >>symbols to the proprietary modules?
> > >
> > >Ick, no!
> > >
> > >Please consult with a lawyer before trying this.  I know a lot of them
> > >consider doing this just as forbidden as marking your module
> > >MODULE_LICENSE("GPL"); when it really isn't.
> >=20
> > There will be a GPL'd layer, and it's likely that sysfs interaction wil=
l=20
> > be on the GPL'd side anyway, for purely technical reasons.  But it does=
=20
> > feel like circumvention of the limitations set in the kernel.
>=20
> It is.  And as such, it is not allowed.
[snip]

So, what's the magic amount of redirection and abstraction that cleanses
the GPLness, hmm?  Who gets to wave the magic wand to say what
interfaces are GPL-to-non-GPL and which aren't?

For example, the IDE drivers use GPL symbols but the VFS does not.  So
anyone can write a proprietary filesystem which eventually gets around
to driving the IDE layer.  That is okay, but this isn't?

If the trend of making everything _GPL continues, I don't see any choice
for binary module vendors but to join together to develop a stable
driver API and build it as a GPL/BSD module.  Do the same API for BSD
systems to prove modules using it are not GPL derived.  Watch Greg foam.
It'd be fun.
--
Zan Lynx <zlynx@acm.org>

--=-c0OvfhsYUEjPxkGB7o+5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCAa5qG8fHaOLTWwgRAlqbAJ92IvBoXRS2Wb31lug7z/PWtmKlkwCePkGe
MdXMC81dYKI+R2u3FZTiI+k=
=JN/R
-----END PGP SIGNATURE-----

--=-c0OvfhsYUEjPxkGB7o+5--

