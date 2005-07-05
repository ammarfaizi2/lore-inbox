Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbVGEWD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVGEWD2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 18:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVGEWBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 18:01:06 -0400
Received: from zlynx.org ([199.45.143.209]:58126 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S261946AbVGEVu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 17:50:56 -0400
Subject: Re: A "new driver model" and EXPORT_SYMBOL_GPL question
From: Zan Lynx <zlynx@acm.org>
To: Greg KH <greg@kroah.com>
Cc: Michal Jaegermann <michal@harddata.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050704054441.GA19936@kroah.com>
References: <20050703171202.A7210@mail.harddata.com>
	 <20050704054441.GA19936@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-D/wdGXQ6zgsL6Ts82/8Q"
Date: Tue, 05 Jul 2005 15:50:43 -0600
Message-Id: <1120600243.27600.75.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-D/wdGXQ6zgsL6Ts82/8Q
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-07-03 at 22:44 -0700, Greg KH wrote:
> On Sun, Jul 03, 2005 at 05:12:02PM -0600, Michal Jaegermann wrote:
[snip]
> Then take it up with them.  Users of those symbols have had many months
> advance notice that this was going to happen.
>=20
> > Was a decision to use EXPORT_SYMBOL_GPL deliberate and if yes then
> > what considerations dictated it, other then the patch author wrote
> > it that way, and what drivers in question are supposed to use when
> > this change will show up in the mainline?  It looks that 2.6.13
> > will do this.
>=20
> Please see the archives for the answers to these questions.

The archives say:
Greg KH wrote:
> I have been recently advised that I should not change these symbols,
> and so I will not.
>=20
> Sorry for the noise and wasted bandwidth, will not happen again.
>=20
> greg k-h

Sourced from here:
http://hulllug.principalhosting.net/archive/index.php/t-52440.html

That was the way it was as of 2.6.10-mm1 and it stayed that way through
2.6.12.  When did that decision change?  If it was there in the
archives, I missed it in the search.

If this was a Greg-only decision, perhaps a patch reversing the change
addressed to Linus would get a solid yes/no decision from the top.

=46rom what I gather in the archives, the last time this happened it was
just a leak from Greg's tree and not an official policy change.  It
isn't in the feature removal schedule, even though other _GPL changes
are listed there.
--=20
Zan Lynx <zlynx@acm.org>

--=-D/wdGXQ6zgsL6Ts82/8Q
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCywCzG8fHaOLTWwgRAmI7AKCh1qkxckpurmM3RDEt59ZSsi08uACeM9ld
1aGUFix9Xc3H5q1LuLLSOfw=
=9XOS
-----END PGP SIGNATURE-----

--=-D/wdGXQ6zgsL6Ts82/8Q--

