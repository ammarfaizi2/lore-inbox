Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUJET3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUJET3y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 15:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbUJET3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 15:29:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33979 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264386AbUJET3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 15:29:32 -0400
Subject: Re: Linux-2.6.5-1.358 and Fedora
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: "Johnson, Richard" <rjohnson@analogic.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0410052100110.2913@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.53.0410051413520.3024@quark.analogic.com>
	 <Pine.LNX.4.61.0410052100110.2913@dragon.hygekrogen.localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5mk8A8hGYCZ5ENTfpEPB"
Organization: Red Hat UK
Message-Id: <1097004565.9975.25.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 05 Oct 2004 21:29:26 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5mk8A8hGYCZ5ENTfpEPB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-10-05 at 21:15, Jesper Juhl wrote:
> On Tue, 5 Oct 2004, Johnson, Richard wrote:

> Only do that if you are sure your systems bootloader configuration is abl=
e=20
> to deal with it. Maybe Fedora is configured so that "make install" can=20
> work, I wouldn't know I'm a Slackware user myself.

on Fedora, make install will do the bootloader thing automatically


> Could it be you accidentally installed your new modules in the same=20
> location as the old ones or that your initrd holds modules compiled for a=
=20
> different kernel than the one you just build - did you remember to update=
=20
> your initrd?

it can't be an accident; the kernel source that ship in Fedora have a
special "custom" added to the EXTRAVERSION to prevent accidents where
people who are learning and follow a kernel building howto overwrite the
"known good" kernel, but instead things get installed in a parallel dir
with a different EXTRAVERSION.

If Richard overwrote his modules anyway he must have hacked the Makefile
himself to deliberately cause this, at which point... well saw wind
harvest storm ;)



--=-5mk8A8hGYCZ5ENTfpEPB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBYvYVpv2rCoFn+CIRAgqRAJ0UVVCueCmClB+m7SLCSGzMeLeOAwCgkmUR
5pzgGU24gzjVOsfCHH3SS9Y=
=pmWK
-----END PGP SIGNATURE-----

--=-5mk8A8hGYCZ5ENTfpEPB--

