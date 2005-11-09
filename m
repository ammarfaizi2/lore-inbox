Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbVKIBrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbVKIBrI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 20:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbVKIBrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 20:47:08 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:57785 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S964987AbVKIBrH (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 20:47:07 -0500
X-IronPort-AV: i="3.97,306,1125871200"; 
   d="asc'?scan'208"; a="8692195:sNHT30052674"
Subject: Re: New Linux Development Model
From: Ian Kumlien <pomac@vapor.com>
Reply-To: pomac@vapor.com
To: Linux-kernel@vger.kernel.org
Cc: fawadlateef@gmail.com, s0348365@sms.ed.ac.uk, hostmaster@ed-soft.at,
       jerome.lacoste@gmail.com, carlsj@yahoo.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6cDcL6wgwCPqCeB8ehsQ"
Date: Wed, 09 Nov 2005 02:47:48 +0100
Message-Id: <1131500868.2413.63.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6cDcL6wgwCPqCeB8ehsQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi, posting from the outside so, no nice quotes and stuff.

Anyways, I was also miffed that the kernel folks merged a 'ancient'
version of ipw2200 and ieee802.11, if they had merged something more
current everything would have worked out of the box and all the cleanups
would have been easier to cope with. Ie, the intel ppl could release
straight patches to the in kernel version. I dunno if they have changed
the way their driver works now.

Atm, the 'ancient' ieee802.11 is what breaks the ipw2200 build. So,
basically all testing of cutting edge kernels gets very tedious due to
the ieee802.11 package removing the offending .h file and making
reversing -gitX and applying -gitY a real PITA.

Also, I dunno if it says what version of the firmware it should have...

Anyways, current state of ipw2200 is sad, and ieee802.11 is more
developed out of tree. So imho at least ieee802.11 should be merged more
closely and then generalized if needed (i think i saw some patches like
that) and preferably ipw2200 should be merged as well.

This b0rkage has actually kept me from using wlan AND testing kernel.org
kernels.

PS. Above, wrt merging, i assume that the API isn't quite 'stable' and
that changing any drivers using them should be simple and
straightforward.

stable as in, used all over and require major rewrites to change =3D)
DS.

PPS. Why merge a outdated version of a driver/protocol/thingy at all?
DS.

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-6cDcL6wgwCPqCeB8ehsQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iD8DBQBDcVVE7F3Euyc51N8RAt7zAKCMaQ+KUXG6VLXbWE/a3kKwNYLumQCfQjEs
Ljqc1Svbn1ktHkSxXWjwoSk=
=QNwZ
-----END PGP SIGNATURE-----

--=-6cDcL6wgwCPqCeB8ehsQ--
