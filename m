Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbTJAI4e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 04:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbTJAI4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 04:56:34 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:26607 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261704AbTJAI4d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 04:56:33 -0400
Subject: Re: Kernel includefile bug not fixed after a year :-(
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Paul Rolland <rol@as2917.net>
Cc: andersen@codepoet.org, "'Jens Axboe'" <axboe@suse.de>,
       "'David S. Miller'" <davem@redhat.com>,
       "'Andreas Steinmetz'" <ast@domdv.de>, schilling@fokus.fraunhofer.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <022901c387f8$d35c3320$4300a8c0@witbe>
References: <022901c387f8$d35c3320$4300a8c0@witbe>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8mzaYPW0wdCsrU7HOw4U"
Organization: Red Hat, Inc.
Message-Id: <1064998553.5182.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Wed, 01 Oct 2003 10:55:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8mzaYPW0wdCsrU7HOw4U
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-10-01 at 10:48, Paul Rolland wrote:
> Hello,
>=20
> > A classic recent example is iproute, which uses kernel headers
> > all over the place.  It compiled with earlier 2.4.x kernels, but
> > it no longer compiles 2.4.22.  I've not bothered to try and fix
> > it, but if it included its own set of sanitized kernel headers,
> > it would not have had a problem.
>=20
> And if some IOCTLs were changed in between, in the kernel and
> kernel headers ?=20
this is absolutely not allowed to happen. It's not allowed to break the
userspace ABI like this!

--=-8mzaYPW0wdCsrU7HOw4U
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/epaZxULwo51rQBIRAt2mAJ4/Ija1AzBoqr+Dk065ip8rLXSWswCgpO13
h7VGdRMA3jDCB02Os743OnU=
=rnTK
-----END PGP SIGNATURE-----

--=-8mzaYPW0wdCsrU7HOw4U--
