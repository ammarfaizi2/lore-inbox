Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263011AbVAFUSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbVAFUSO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 15:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbVAFUQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 15:16:57 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:2012 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S263023AbVAFUOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 15:14:48 -0500
Subject: Re: Problem with irqrouting and resume
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org, "Barry K. Nathan" <barryn@pobox.com>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <1105040822.22985.29.camel@eeyore>
References: <1103474172.4219.26.camel@localhost.localdomain>
	 <1105040822.22985.29.camel@eeyore>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-48v+rCOKHwXH13PEw3+h"
Date: Thu, 06 Jan 2005 21:14:45 +0100
Message-Id: <1105042485.1087.19.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-48v+rCOKHwXH13PEw3+h
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-01-06 at 12:47 -0700, Bjorn Helgaas wrote:

Hi Bjorn

> Can you try these patches please:
>=20
>     http://www.ussg.iu.edu/hypermail/linux/kernel/0501.0/0284.html
>     http://www.ussg.iu.edu/hypermail/linux/kernel/0501.0/0548.html
>=20
> I suspect that they will fix the problem; let me know either way.

I had in fact just rebooted with these patches when I got your mail.

And they do indeed fix the problem, 2.6-bk + these two patches suspends
and resumes fine and the e1000 interface works again after resume. I
tested without these patches as well and then it's the same as before,
only a few interrupts get through once in a while.

Thanks everyone.

--=20
/Martin

--=-48v+rCOKHwXH13PEw3+h
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB3Zw0Wm2vlfa207ERAmKbAKDAF6isJLDWuO6tL+uGechaozMwTACdFsim
BKx8lbeD6KlXGU59qMC9McE=
=kxTv
-----END PGP SIGNATURE-----

--=-48v+rCOKHwXH13PEw3+h--
