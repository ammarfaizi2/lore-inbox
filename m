Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbTEUUDE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 16:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbTEUUDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 16:03:04 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:13811 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262253AbTEUUDC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 16:03:02 -0400
Subject: Re: userspace irq balancer
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1053534694.1681.10.camel@mulgrave>
References: <1053534694.1681.10.camel@mulgrave>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gOLg9llFQ0X4u/64pHsq"
Organization: Red Hat, Inc.
Message-Id: <1053548160.1301.10.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 21 May 2003 22:16:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gOLg9llFQ0X4u/64pHsq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-05-21 at 18:31, James Bottomley wrote:
> I'm interested in using this for voyager.  However, I have a problem in
> that voyager may have CPUs that can't accept interrupts (this is global
> on voyager, but may be per-interrupt on NUMA like systems).  I think
> before we move to a userspace solution, some thought about how to cope
> with this is needed.
>=20
> I have several suggestions:
>=20
> 1. Place the masks into /proc/irq/<n>/smp_affinity at start of day and
> have the userspace irqbalancer take this as the maximal mask
>=20
> 2. Have a separate file /proc/irq/<n>/mask(?) to expose the mask always
>=20
> 3. Some other method...

I would prefer the second method.


--=-gOLg9llFQ0X4u/64pHsq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+y96AxULwo51rQBIRAsr0AKCKTznvHPgPEc7W9aTN8Rd0Vu4SQgCfRksV
V6my+OA4FIGNuXuIj9t82H4=
=Dmpm
-----END PGP SIGNATURE-----

--=-gOLg9llFQ0X4u/64pHsq--
