Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTEKIzL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 04:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbTEKIzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 04:55:11 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:24558 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261188AbTEKIzJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 04:55:09 -0400
Subject: Re: irq balancing: performance disaster
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Jos Hulzink <josh@stack.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200305110118.10136.josh@stack.nl>
References: <200305110118.10136.josh@stack.nl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-w+ycHDmHaisHxQoP0Kyx"
Organization: Red Hat, Inc.
Message-Id: <1052644067.1371.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 11 May 2003 11:07:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-w+ycHDmHaisHxQoP0Kyx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-05-11 at 01:18, Jos Hulzink wrote:
> Hi,
>=20
> While tackling bug 699, it became clear to me that irq balancing is the c=
ause=20
> of the performance problems I, and all people using the SMP kernel Mandra=
ke=20
> 9.1 ships, are dealing with. I got the problems with 2.5.69 too. After=20
> disabling irq balancing, the system is remarkably faster, and much more=20
> responsive.=20
>=20
> For those interested in the issue, please look at bug 699.

please try the following app instead:

http://people.redhat.com/arjanv/irqbalance/

the in kernel irqbalancer in 2.4 kernels has some worst case behaviors
at least, and the userspace implementation avoids those.

--=-w+ycHDmHaisHxQoP0Kyx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+vhLjxULwo51rQBIRAoGsAJ93UZYFqryuQuOhvQO2bBaJTVFFxgCfRt4G
uYMdAmRZ9FLBJgbPmfbtxlY=
=DBNa
-----END PGP SIGNATURE-----

--=-w+ycHDmHaisHxQoP0Kyx--
