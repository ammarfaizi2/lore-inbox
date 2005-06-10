Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVFJU4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVFJU4f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 16:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVFJU4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 16:56:35 -0400
Received: from koris.mail.t-online.hu ([195.228.240.90]:2007 "EHLO
	koris.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S261239AbVFJU4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 16:56:22 -0400
Subject: hackbench: 2.6.12-rc6 vs.  2.6.12-rc6-RT-V0.7.48-06
From: Gabor MICSKO <gmicsko@szintezis.hu>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vMdI8F2v+vPmt8YWlRE+"
Date: Fri, 10 Jun 2005 22:56:15 +0200
Message-Id: <1118436975.1702.11.camel@alderaan.trey.hu>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
X-VBMilter: scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vMdI8F2v+vPmt8YWlRE+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi!

I made some test with 2.6.12-rc6-RT-V0.7.48-06 and 2.6.12-rc6 kernels.
Here is my results:

2.6.12-rc6-RT-V0.7.48-0			       2.6.12-rc6
------------------------------------			    ----------------=09

./hackbench 30

1st run:  6.139					    5.110=09
2nd run: 6.119					   4.946
3rd run: 6.135					    5.168

./hackbench 100

1st run:  23.254				   16.603=09
2nd run: 23.481					  16.478
3rd run:  23.790				   16.387

./hackbench 130

1st run:  33.395				   21.731=09
2nd run: 32.652					  21.821
3rd run:  32.517				   21.698

./hackbench 150

1st run:  89.100				   47.862=09
2nd run: 39.308					  25.121
3rd run:  90.157				   25.125

It seems to me 2.6.12-rc faster than 2.6.12-rc6-RT-V0.7.48-0. It is
normal?=20

thanks,

-
mg

--=-vMdI8F2v+vPmt8YWlRE+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ez az =?ISO-8859-1?Q?=FCzenetr=E9sz?=
	=?ISO-8859-1?Q?_digit=E1lis?= =?ISO-8859-1?Q?_al=E1=EDr=E1ssal?= van
	=?ISO-8859-1?Q?ell=E1tva?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCqf5vo75Oas+VX1ARAtNcAJ4ig99PO2m8Bt1oDUYytX/A0zqMwQCeMTtk
UdhcNQKTHb4eojISt2bV4Iw=
=i16q
-----END PGP SIGNATURE-----

--=-vMdI8F2v+vPmt8YWlRE+--

