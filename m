Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269206AbUHZQn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269206AbUHZQn5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 12:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269185AbUHZQky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 12:40:54 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:37278 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S269184AbUHZQji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 12:39:38 -0400
Subject: Re: reiser4 plugins (was: silent semantic changes with reiser4)
From: Christophe Saout <christophe@saout.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@osdl.org>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com
In-Reply-To: <20040826172528.A21345@infradead.org>
References: <20040826130718.GB820@lst.de>
	 <1093526273.11694.8.camel@leto.cs.pocnet.net>
	 <20040826132439.GA1188@lst.de>
	 <1093527307.11694.23.camel@leto.cs.pocnet.net>
	 <20040826134034.GA1470@lst.de>
	 <1093528683.11694.36.camel@leto.cs.pocnet.net>
	 <20040826153748.GA3700@lst.de> <1093535334.5482.1.camel@leto.cs.pocnet.net>
	 <20040826160601.GB4326@lst.de>
	 <1093536859.5482.13.camel@leto.cs.pocnet.net>
	 <20040826172528.A21345@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4Qlg4upLtOSiF4GR7uz6"
Date: Thu, 26 Aug 2004 18:39:24 +0200
Message-Id: <1093538364.5482.17.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4Qlg4upLtOSiF4GR7uz6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Donnerstag, den 26.08.2004, 17:25 +0100 schrieb Christoph Hellwig:

> > Looking at the code this could be done. The wrappers that dispatch the
> > operations are really small and call the plugin that is registered with
> > the inode of the mapping. Instead it could have directly set the
> > corresponding operations. Right. The wrappers are doing a few things
> > before calling the plugin. That could be done the other way round too.
> > But that's more of an implementation issue and could still be changed.
>=20
> I agree that it's an implementation issue.  But it's also a good proof
> for how Hans tries to ignore all the existing infrastructure for various
> reasons.

I definitely agree with you on that one.

It bugged me from the beginning because things like these are very
likely to suffer from unnecessary problems that have been solved in the
common code or might be solved when correctly done in the common code in
the future.


--=-4Qlg4upLtOSiF4GR7uz6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBLhI8ZCYBcts5dM0RAoZWAJ4oW3Q6GVYrSAKCxfovL0qOTn8UUgCcDOwq
5I37yGCprEV2EZisvrKFIrg=
=Tj9X
-----END PGP SIGNATURE-----

--=-4Qlg4upLtOSiF4GR7uz6--

