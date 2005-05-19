Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVESSo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVESSo5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 14:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVESSo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 14:44:56 -0400
Received: from zak.futurequest.net ([69.5.6.152]:23723 "HELO
	zak.futurequest.net") by vger.kernel.org with SMTP id S261214AbVESSoy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 14:44:54 -0400
Date: Thu, 19 May 2005 12:44:49 -0600
From: Bruce Guenter <bruceg@em.ca>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: How to diagnose a kernel memory leak
Message-ID: <20050519184449.GK6103@em.ca>
Mail-Followup-To: Alexander Nyberg <alexn@dsv.su.se>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20050509035823.GA13715@em.ca> <1115627361.936.11.camel@localhost.localdomain> <20050511193726.GA29463@em.ca> <20050512171825.12599c1e.akpm@osdl.org> <20050513212816.GA29230@em.ca> <1116441173.23209.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fNagykWcDoSVAmSd"
Content-Disposition: inline
In-Reply-To: <1116441173.23209.17.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fNagykWcDoSVAmSd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 18, 2005 at 08:32:53PM +0200, Alexander Nyberg wrote:
> > > It all looks pretty innocent.  Please send the contents of /proc/memi=
nfo
> > > rather than the `free' output.  /proc/meminfo has much more info.=20
> >=20
> > Here are the current meminfo numbers:
>=20
> What's happening with this? It's been a week now so I'm curious.

It appears the memory consumption I thought I was seeing is now gone,
and only conclusively appeared with the Gentoo kernels.  I will take
this back to their bug tracker.  Sorry for the false alarm.
--=20
Bruce Guenter <bruceg@em.ca> http://em.ca/~bruceg/ http://untroubled.org/
OpenPGP key: 699980E8 / D0B7 C8DD 365D A395 29DA  2E2A E96F B2DC 6999 80E8

--fNagykWcDoSVAmSd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCjN6h6W+y3GmZgOgRAnJdAJ45FCNWGIQC4gi4TBhZnlxvVRtI6QCbB4c3
9YISW6wIQPxkYyFa82QezxQ=
=HuUz
-----END PGP SIGNATURE-----

--fNagykWcDoSVAmSd--
