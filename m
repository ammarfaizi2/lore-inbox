Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbTE0IyY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 04:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbTE0IyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 04:54:24 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:21230 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262855AbTE0IyV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 04:54:21 -0400
Subject: Re: userspace irq balancer
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030526.181734.68129361.davem@redhat.com>
References: <20030526.174841.116378513.davem@redhat.com>
	 <20030527010903.GF3767@dualathlon.random> <20030527011620.GB7135@suse.de>
	 <20030526.181734.68129361.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3PrDq+YCsN1+dHpk63bA"
Organization: Red Hat, Inc.
Message-Id: <1054026451.5301.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (1.3.3-2) (Preview Release)
Date: 27 May 2003 11:07:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3PrDq+YCsN1+dHpk63bA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-05-27 at 03:17, David S. Miller wrote:

> This is an important issue, for another reason.
>=20
> The networking packet scheduler layer wants an accurate (but
> cheap) high frequency time source too.
>=20
> I keep forgetting to go back and deal with fixing up all of
> those hairy macros in pkt_sched.h, I've added this to my TODO
> list.

I have a 2.4 patch to use the acpitimer for things like this. That (when
present) provides accurate high frequency time info.

--=-3PrDq+YCsN1+dHpk63bA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+0yrTxULwo51rQBIRAnFLAKCkhQDnOWggyBc5ukpEm/R3Wk9GNQCeLKY1
rpdAkgQWolCJDfBaDS7nsnU=
=lXFf
-----END PGP SIGNATURE-----

--=-3PrDq+YCsN1+dHpk63bA--
