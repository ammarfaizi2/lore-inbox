Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbTJEOjr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 10:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263122AbTJEOjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 10:39:47 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:55022 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263121AbTJEOjp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 10:39:45 -0400
Subject: Re: [PATCH] [2/2] posix message queues
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@mac.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org, bo.z.li@intel.com
In-Reply-To: <1065282666.2448.57.camel@picklock.adams.family>
References: <1065196646.3682.54.camel@picklock.adams.family>
	 <3F7DBCF6.3050407@colorfullife.com>
	 <1065282666.2448.57.camel@picklock.adams.family>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Zx3DynShoT4jFBRA+qJJ"
Organization: Red Hat, Inc.
Message-Id: <1065364766.5032.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Sun, 05 Oct 2003 16:39:26 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Zx3DynShoT4jFBRA+qJJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-10-05 at 14:42, Peter W=C3=A4chtler wrote:

> > What's the difference between remove_wait_queue() and=20
> > local_remove_wait_queue?
> >=20
>=20
> don't disable local_irq , because no irq involved
> don't know how expensive a local_irq_save is on SMP

like 5 to 7 cycles typically



--=-Zx3DynShoT4jFBRA+qJJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/gC0dxULwo51rQBIRAtu5AJ41yzvqLT5zUWxvrPPAD3+8XanwvwCfaAaB
VfVrtuJgDIsxuSRE/phuxFU=
=elYI
-----END PGP SIGNATURE-----

--=-Zx3DynShoT4jFBRA+qJJ--
