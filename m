Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269859AbUIDJwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269859AbUIDJwi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 05:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269865AbUIDJwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 05:52:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11988 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269859AbUIDJtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 05:49:08 -0400
Subject: Re: New proposed DRM interface design
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Dave Airlie <airlied@linux.ie>
Cc: Christoph Hellwig <hch@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0409041031370.25475@skynet>
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com>
	 <Pine.LNX.4.58.0409040145240.25475@skynet>
	 <20040904102914.B13149@infradead.org>
	 <Pine.LNX.4.58.0409041031370.25475@skynet>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-heHp7ldn0ijUvQsH46FJ"
Organization: Red Hat UK
Message-Id: <1094291327.2801.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 04 Sep 2004 11:48:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-heHp7ldn0ijUvQsH46FJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-09-04 at 11:43, Dave Airlie wrote:
> >
> > Umm, the Linux kernel isn't about minimizing interfaces.  We don't link=
 a
> > copy of scsi helpers into each scsi driver either, or libata into each =
sata
> > driver.
>=20
> true but the DRM isn't only about the Linux kernel, the DRM is a lowlevel
> component of a much larger system, of which the DRM just has to reside in
> the kernel,


you seem to be confusing 2 things.

The kernel<->userspace interface is supposed to be stable, and it should
be so that you can basically decouple X and kernel versions.

Within the kernel you should go for the best interface (where "best" is
a notion that is flexible over time) because 1) you can and 2) you are
suboptimal in both performance and maintenance if you don't


--=-heHp7ldn0ijUvQsH46FJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBOY9/xULwo51rQBIRAkmJAKClwpgbncTRN415Jdqq/A3Gy643uQCeJ85P
lEMxqlVJYADeJE6W98BOxNQ=
=r6b8
-----END PGP SIGNATURE-----

--=-heHp7ldn0ijUvQsH46FJ--

