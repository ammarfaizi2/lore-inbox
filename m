Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292330AbSBYUDC>; Mon, 25 Feb 2002 15:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292327AbSBYUCv>; Mon, 25 Feb 2002 15:02:51 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:41416 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S292323AbSBYUCl>; Mon, 25 Feb 2002 15:02:41 -0500
Date: Mon, 25 Feb 2002 15:00:56 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: linux-pm-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Cc: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
Subject: suspend/resume and 3c59x
Message-ID: <20020225200056.GW12719@ufies.org>
Mail-Followup-To: linux-pm-devel@lists.sourceforge.net,
	lkml <linux-kernel@vger.kernel.org>,
	christophe =?iso-8859-15?Q?barb=E9?= <christophe.barbe.ml@online.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mz5eWKkhz39mMVQV"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: debian SID Gnu/Linux 2.4.17 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mz5eWKkhz39mMVQV
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I use the kernel 2.4.17 and the hotplug facilities for my 3com cardbus
(driver 3c59x). It works well when I insert and remove the card.  =20
But If I don't remove the card before suspending (apm -s) my laptop,
The card is in a bad state when I resume the laptop and I need to remove
and insert the card to get it back. I have tried to ifdown and rmmod
before suspending but the result is the same.

Am i missing something ?

I understand it is a resume/suspend issue (not a hotplug issue).
What need to be done in the driver to support the suspending of the
card ?

Christophe

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

There is no snooze button on a cat who wants breakfast.

--mz5eWKkhz39mMVQV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8epf4j0UvHtcstB4RAhUcAJ9l4hgoSEvdBNHSWlKGp29DeFlhYwCfdxJw
kTf5TV6XtY/kuxc3QNAqOTE=
=z35t
-----END PGP SIGNATURE-----

--mz5eWKkhz39mMVQV--
