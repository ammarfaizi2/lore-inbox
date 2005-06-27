Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVF0QhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVF0QhZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 12:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbVF0PAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 11:00:35 -0400
Received: from ctb-mesg6.saix.net ([196.25.240.86]:18898 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S262078AbVF0NrB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 09:47:01 -0400
Subject: Re: [PATCH] 2/2 swap token tuning
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Rik Van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Song Jiang <sjiang@lanl.gov>
In-Reply-To: <Pine.LNX.4.61.0506270907110.18834@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0506261827500.18834@chimarrao.boston.redhat.com>
	 <Pine.LNX.4.61.0506261835000.18834@chimarrao.boston.redhat.com>
	 <1119877465.25717.4.camel@lycan.lan>
	 <Pine.LNX.4.61.0506270907110.18834@chimarrao.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RY7037GX8qTCBZH8iqaZ"
Date: Mon, 27 Jun 2005 15:47:36 +0200
Message-Id: <1119880056.10872.0.camel@lycan.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RY7037GX8qTCBZH8iqaZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-06-27 at 09:08 -0400, Rik Van Riel wrote:
> On Mon, 27 Jun 2005, Martin Schlemmer wrote:
>=20
> > -+				sem_is_read_locked(mm->mmap_sem))
> > +                               sem_is_read_locked(&mm->mmap_sem))
>=20
> Yes, you are right.  I sent out the patch before the weekend
> was over, before having tested it locally ;)
>=20
> My compile hit the error a few minutes after I sent out the
> mail, doh ;)
>=20
> Andrew has a fixed version of the patch already.
>=20

Ok, thanks - wanted to test it, and just wanted to verify that my
changes are OK.


Regards,

--=20
Martin Schlemmer


--=-RY7037GX8qTCBZH8iqaZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCwAN4qburzKaJYLYRAt5jAJ9hKGQ4Qgs9XKzjfjgqlKk4BqgMIACdHTMe
JNB+oyBcAw1YbPlyg/Qw0JY=
=CJMl
-----END PGP SIGNATURE-----

--=-RY7037GX8qTCBZH8iqaZ--

