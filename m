Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317559AbSGEUVK>; Fri, 5 Jul 2002 16:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317552AbSGEUVJ>; Fri, 5 Jul 2002 16:21:09 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:61190 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S317559AbSGEUVI>; Fri, 5 Jul 2002 16:21:08 -0400
Date: Fri, 5 Jul 2002 22:23:40 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IBM Desktar disk problem?
Message-ID: <20020705202340.GG28569@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1025873421.16768.20.camel@sonja.de.interearth.com> <Pine.LNX.4.44.0207050801190.10105-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3607uds81ZQvwCD0"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207050801190.10105-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3607uds81ZQvwCD0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 05 Jul 2002, Thunder from the hill wrote:

> ...and tell all the people who got a DTLA (because it's not as expensive=
=20
> as others in some countries, mind France, USA, Germany) to drop their=20
> disks if they want to use Linux, because we're too lazy to find a=20
> solution. That might be cool to you, but we want HARDWARE SUPPORT for=20
> Linux! That's why we're here.
>=20
> There _is_ a solution, we just have to find it.

Might just be that "coincidence" happens more often as "incident"
happens more often. Means: the more drives of that type fails, the more
likely it is someone shows up with a report that the failure is related
to this-and-that. Until someone can reproduce this, assume the TCQ is
Not Guilty in respect to your DTLA failure. Assume it has died a natural
death.

And the "incident often" seems to hold for 75GXP series drives (IBM
DTLA-3070xx).  Out of seven DTLA-307045 (all bought approx. Feb. 2001,
in two different stores) I look after I am getting a MTBF(*) of around
28,000 hours -- which is way lower than what IBM claims.  Two died after
9 months, another one after 16 months. Other IBM drives, DJNA, DPTA, are
way more reliable -- but these are no longer sold.

(S=F8ren Schmidt, FreeBSD ata(4) driver maintainer, says that IBM
acknowledged that DJNA have broken TCQ, sometimes forget to flush a
block -- this will then probably also affect the WDC-420400 and 418....
20G 5400/min and 18G 7200/min drives).


(*) Using Fujitsu's formula:

        total hours of service of all drives
MTBF =3D --------------------------------------
           number of failed drives to date

--3607uds81ZQvwCD0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9JgBMFmbjPHp/pcMRAmktAJ0QFO9VCM9tdVZUizBTXOE46xvdUACfeWes
/B9adT6+1c3oH8B2Jnr94c4=
=27ry
-----END PGP SIGNATURE-----

--3607uds81ZQvwCD0--
