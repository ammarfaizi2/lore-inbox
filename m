Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbVJGFcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbVJGFcx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 01:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbVJGFcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 01:32:53 -0400
Received: from idefix.CeNTIE.NET.au ([202.9.6.83]:28314 "HELO idefix")
	by vger.kernel.org with SMTP id S932237AbVJGFcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 01:32:53 -0400
Subject: Re: Suspend to RAM broken with 2.6.13
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050923163200.GC8946@openzaurus.ucw.cz>
References: <1127347633.25357.49.camel@idefix.homelinux.org>
	 <20050923163200.GC8946@openzaurus.ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6/jURP4iUKOD4mmDLKE7"
Organization: =?ISO-8859-1?Q?Universit=E9?= de Sherbrooke
Date: Fri, 07 Oct 2005 15:32:25 +1000
Message-Id: <1128663145.14284.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6/jURP4iUKOD4mmDLKE7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I've done some further testing on suspend to RAM and it seems like it
got broken for me between 2.6.11 and 2.6.12. Does that help narrowing
down the problem?

	Jean-Marc

Le vendredi 23 septembre 2005 =E0 18:32 +0200, Pavel Machek a =E9crit :
> Hi!
>=20
> > I'm experiencing problems with suspend to RAM on my Dell D600 laptop.
> > When I run Ubuntu's 2.6.10 kernel I have no problem with suspend to RAM=
.
> > However, when I run 2.6.13, my laptop sometimes doesn't wake up. It
> > seems like the longer my uptime, the more likely the problem is to occu=
r
> > (which makes it hard to reproduce sometimes). This happens even with a
> > non-preempt kernel.
>=20
> Check if it works with minimal drivers and non-preemptible kernel...

--=-6/jURP4iUKOD4mmDLKE7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBDRghpdXwABdFiRMQRAqn0AJ44ZEpzoAkP5vJ5+Bwy1SO+HbdgFwCfckHW
5ImZpluNzp+Xwh4Jz6cU5YQ=
=bQHr
-----END PGP SIGNATURE-----

--=-6/jURP4iUKOD4mmDLKE7--
