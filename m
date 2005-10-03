Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932643AbVJCWFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbVJCWFt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 18:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbVJCWFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 18:05:48 -0400
Received: from mail.autoweb.net ([198.172.237.26]:16302 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S932643AbVJCWFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 18:05:47 -0400
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
	the kernel
From: Ryan Anderson <ryan@autoweb.net>
To: Tomasz =?iso-8859-2?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
Cc: Luben Tuikov <luben_tuikov@adaptec.com>, andrew.patterson@hp.com,
       Marcin Dalecki <dalecki.marcin@neostrada.pl>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, dougg@torque.net,
       Linus Torvalds <torvalds@osdl.org>, Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.BSO.4.62.0510032103380.28198@rudy.mif.pg.gda.pl>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com>
	 <1128105594.10079.109.camel@bluto.andrew>  <433D9035.6000504@adaptec.com>
	 <1128111290.10079.147.camel@bluto.andrew>  <433DA0DF.9080308@adaptec.com>
	 <1128114950.10079.170.camel@bluto.andrew> <433DB5D7.3020806@adaptec.com>
	 <9B90AC8A-A678-4FFE-B42D-796C8D87D65B@neostrada.pl>
	 <4341381D.2060807@adaptec.com>
	 <E93AC7D5-4CC0-4872-A5B8-115D2BF3C1A9@neostrada.pl>
	 <1128357350.10079.239.camel@bluto.andrew> <43415EC0.1010506@adaptec.com>
	 <Pine.BSO.4.62.0510032103380.28198@rudy.mif.pg.gda.pl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lYZfKBnkTQpkkNuDH3l1"
Date: Mon, 03 Oct 2005 18:04:35 -0400
Message-Id: <1128377075.23932.5.camel@ryan2.internal.autoweb.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lYZfKBnkTQpkkNuDH3l1
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-10-03 at 23:26 +0200, Tomasz K=B3oczko wrote:
> If (cytation from Linus) "a 'spec' is close to useless" ..
> Q: why the hell in kernel tree is included Documentation/ subdirectory ?
> Is it raly content of this directory is "close to useless" or maybe it no=
t
> contains some specyfications ? :>

Let me rephrase what Linus said, to help remove the misreading that
seems so common today.  I think a fair rewording would be, "A spec is a
guideline.  When it fails to match reality, continuing to follow it is a
tremendous mistake."

Additionally, I think the overall LKML feeling on hardware specs and the
corresponding software abstractions to deal with it can be summarized
something like this:

When the spec provides a software design that doesn't fit into the
overall structure of the Linux kernel, the spec should be treated as a
suggestion for a software design.  The *interface* that the spec
documents should be followed, where it moves out of the overall
structure, but internally, a design that fits into the Linux kernel is
more important than following a spec that doesn't fit.

--=20
Ryan Anderson
AutoWeb Communications, Inc.
email: ryan@autoweb.net


--=-lYZfKBnkTQpkkNuDH3l1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDQarzIEfEr9d71YgRAnWLAKCS5Mjwkk2A6AfQ/FWYMjyl4cUJjQCeJP7r
AHaVJ/elXKe3OrF136lWhQQ=
=AzW1
-----END PGP SIGNATURE-----

--=-lYZfKBnkTQpkkNuDH3l1--
