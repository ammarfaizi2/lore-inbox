Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbTDVTnQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263409AbTDVTnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:43:16 -0400
Received: from ns1.canonical.org ([209.115.72.29]:48306 "EHLO
	panacea.canonical.org") by vger.kernel.org with ESMTP
	id S263460AbTDVTnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:43:14 -0400
Date: Tue, 22 Apr 2003 15:53:04 -0400
From: Jason Cook <jasonc@reinit.org>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel ring buffer accessible by users
Message-ID: <20030422195304.GQ11056@panacea.canonical.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <frodoid.frodo.87wuhmh5ab.fsf@usenet.frodoid.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V4yrq4dHtCqH+JvC"
Content-Disposition: inline
In-Reply-To: <frodoid.frodo.87wuhmh5ab.fsf@usenet.frodoid.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--V4yrq4dHtCqH+JvC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Julien Oster (frodo@dereference.de) wrote:
>=20
> Hello,
>=20
> it's been quite a while that I noticed that any ordinary user, not
> just root, can type "dmesg" to see the kernel ring buffer.
>=20
> My question now is: Why? I often saw things in the kernel ring buffer
> which I don't want every user to know (e.g. some telephone numbers with
> ISDN).
>=20
> Are there any problems in just letting root get the contents of the
> kernel ring buffer?
>=20
> Julien
> -

grsec has an option to do this:

http://www.grsecurity.net/

--=20
Jason Cook                 |  GnuPG Fingerprint: D531 F4F4 BDBF 41D1 514D
GNU/Linux Engineering Lead |                     F930 FD03 262E 5120 BEDD
evolServ Technology        |  Home page: http://reinit.org

cthread.  cthread_fork().  Fork, thread, fork!

--V4yrq4dHtCqH+JvC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj6lnaAACgkQ/QMmLlEgvt3W2QCcDEAyMRwcG60u13wMPrEiI7jS
1OQAnixHlXo23bWE8dhjA82uu7cnO0vA
=UGPl
-----END PGP SIGNATURE-----

--V4yrq4dHtCqH+JvC--
