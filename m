Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264242AbTEaI4t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 04:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264243AbTEaI4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 04:56:49 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:19182 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S264242AbTEaI4r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 04:56:47 -0400
Subject: Re: [PATCH RFC] 1/2 central workspace for zlib
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: "David S. Miller" <davem@redhat.com>, jmorris@intercode.com.au,
       linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>
In-Reply-To: <20030531075615.GA25089@wohnheim.fh-wedel.de>
References: <20030530174319.GA16687@wohnheim.fh-wedel.de>
	 <20030530.171410.104043496.davem@redhat.com>
	 <20030531064851.GA20822@wohnheim.fh-wedel.de>
	 <20030530.235505.23020750.davem@redhat.com>
	 <20030531075615.GA25089@wohnheim.fh-wedel.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WGyCU2SqoXTxuFsnq5WU"
Organization: Red Hat, Inc.
Message-Id: <1054372158.5259.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (1.3.92-1) (Preview Release)
Date: 31 May 2003 11:09:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WGyCU2SqoXTxuFsnq5WU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-05-31 at 09:56, J=C3=B6rn Engel wrote:
> CC List pruned a little.
>=20
> On Fri, 30 May 2003 23:55:05 -0700, David S. Miller wrote:
> >    From: J=C3=B6rn Engel <joern@wohnheim.fh-wedel.de>
> >   =20
> >    How about preemption?  zlib operations take their time, so at least =
on
> >    up, it makes sense to preempt them, when not in softirq context.  Ca=
n
> >    this still be done lockless?
> >=20
> > You'll need to disable preemption.
>=20
> My gut feeling claims that this would hurt interactivity.=20

the code is decompressing data that was 4096 bytes originally. I doubt
that will be anything close to some real wallclock time nowadays....

--=-WGyCU2SqoXTxuFsnq5WU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+2HE+xULwo51rQBIRAti2AJ9+42PNjQlhlXi7ID0200udIuYulgCbBDV+
vDobyg5RSQ2gy7x9qtzmKdo=
=fStp
-----END PGP SIGNATURE-----

--=-WGyCU2SqoXTxuFsnq5WU--
