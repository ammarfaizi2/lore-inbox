Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbTEDNC5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 09:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbTEDNC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 09:02:57 -0400
Received: from dsl-62-3-122-162.zen.co.uk ([62.3.122.162]:1437 "EHLO
	marx.trudheim.com") by vger.kernel.org with ESMTP id S263591AbTEDNC4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 09:02:56 -0400
Subject: RE: comparison between signed and unsigned
From: Anders Karlsson <anders@trudheim.com>
To: Riley Williams <Riley@Williams.Name>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <BKEGKPICNAKILKJKMHCACEFGCKAA.Riley@Williams.Name>
References: <BKEGKPICNAKILKJKMHCACEFGCKAA.Riley@Williams.Name>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vxyukWO8qIkN9fKbKlvi"
Organization: Trudheim Technology Limited
Message-Id: <1052054117.31300.13.camel@marx>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4Rubber Turnip 
Date: 04 May 2003 14:15:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vxyukWO8qIkN9fKbKlvi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello there Riley,

[snip: compile warnings compare signed to unsigned]

> The obvious question is this: How many of those warnings also occur
> with the pristine source - i.e., the -rc1 without the -ac4 source. It
> would probably be best to wade through the -rc1 sources fixing those
> first, then worry about the -ac* sources once those have been merged
> in.

If I make an estimate, I would say that a great majority of the warnings
are present wether I compile 2.4.20-SuSE, 2.4.21-rc1 or 2.4.21-rc1-ac4.
This seems to be a common (deliberate?) theme throughout parts of the
kernel tree.

I could quite well go through and start fixing things (despite me not
knowing C particularly well) but I would, by someone who knows the
kernel quite well, appreciate an estimate of how likely the result is to
be horribly broken.

As I see it, there might be instances where the comparision between a
signed value and an unsigned value could produce a defect. If people
think this is a good thing to fix and there are people that would accept
patches in normal diff -u format, I could spend some time trying to fix
part of this.

Regards,

/Anders

--=-vxyukWO8qIkN9fKbKlvi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+tRJlLYywqksgYBoRAhDhAKCl9oH02UO93VhR/I8hlMetsJ1VqACeJth/
1cpHofyLID+abQXzaTT883w=
=u8W8
-----END PGP SIGNATURE-----

--=-vxyukWO8qIkN9fKbKlvi--

