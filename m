Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263537AbTJVLOg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 07:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263538AbTJVLOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 07:14:36 -0400
Received: from 24-216-47-96.charter.com ([24.216.47.96]:50828 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S263537AbTJVLO1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 07:14:27 -0400
Date: Wed, 22 Oct 2003 07:14:27 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8, oops, [__remove_from_page_cache+36/112] __remove_from_page_cache+0x24/0x70
Message-ID: <20031022111427.GL2617@rdlg.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031022084413.GA2773@finwe.eu.org> <20031022085611.GA1848@finwe.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p7S+EREVcBHk3zUG"
Content-Disposition: inline
In-Reply-To: <20031022085611.GA1848@finwe.eu.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--p7S+EREVcBHk3zUG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



This sounds like what mine was doing, the oops looked similar as well
(with the null pointer part atleast).  Reboot and I bet it'll run fine
for a while and then start up again.  For me it seemed to start faulting
when "free" showed over 250 Megs used.


Thus spake Jacek Kawa (jfk@zeus.polsl.gliwice.pl):

> Jak podaj? anonimowe ?r?d?a, przepowiedziano, ?e Jacek Kawa napisze:
>=20
> > This machine has new RAM, but after about 7 hours of testing,=20
> > memtest.86 didn't show any errors...=20
>=20
> Well, it's RAM anyway... I've just got few segfaults in vim...
>=20
> bye
>=20
> --=20
> Jacek Kawa
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--p7S+EREVcBHk3zUG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/lmaT8+1vMONE2jsRAiyMAKCwfCux8EJNeIz6KdvhYIsvmjRh4QCgzw2R
nFOkKuZbjikzvovIFGhztKE=
=ywmq
-----END PGP SIGNATURE-----

--p7S+EREVcBHk3zUG--
