Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262444AbVCDGob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbVCDGob (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 01:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbVCDGoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 01:44:30 -0500
Received: from iucha.net ([209.98.146.184]:19615 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S262444AbVCDGk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 01:40:59 -0500
Date: Fri, 4 Mar 2005 00:40:53 -0600
To: linux-kernel@vger.kernel.org
Subject: are the io-schedulers per-device?
Message-ID: <20050304064053.GC10507@iucha.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline
X-message-flag: Microsoft: Where do you want to go today? Nevermind, you are coming with us!
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.6+20040907i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

For a semester project I am experimenting with a new IO scheduler and I
was trying to set my scheduler to control a single device, to ease the
development and debugging, by using
   echo "foo" > /sys/block/ubdc/queue/scheduler
Much to my suprise, this sets the scheduler for the other block
devices as well! Does this happen only to UML block devices? Do I need
to do anything to allow a per-device scheduler? Is the functionality
there, or is it in-progress? Am I reading too much in the fact that
the queue/scheduler is defined under each block device?

Thank you,
florin

PS: Please Cc: me as I am not subscribed.

--=20

Don't question authority: they don't know either!

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCKAL1NLPgdTuQ3+QRAvfDAJ9NQfWj2gSLrFZPRt0D9B/OXO1dngCgnm0T
HLVaYOIsdWISvhH+IDJ4nYs=
=uNjp
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--
