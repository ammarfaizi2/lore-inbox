Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265043AbUFBHPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265043AbUFBHPJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 03:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265091AbUFBHPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 03:15:09 -0400
Received: from zeus.kernel.org ([204.152.189.113]:29359 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265043AbUFBHPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 03:15:01 -0400
Date: Wed, 2 Jun 2004 03:14:49 -0400
To: Netdev <netdev@oss.sgi.com>
Cc: hostap@shmoo.com, prism54-devel@prism54.org,
       Jeff Garzik <jgarzik@pobox.com>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Prism54 WPA Support - wpa_supplicant - Linux general wpa support
Message-ID: <20040602071449.GJ10723@ruslug.rutgers.edu>
Mail-Followup-To: Netdev <netdev@oss.sgi.com>, hostap@shmoo.com,
	prism54-devel@prism54.org, Jeff Garzik <jgarzik@pobox.com>,
	Jean Tourrilhes <jt@bougret.hpl.hp.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
From: mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


So WPA is now a priority for prism54 development. Here's where we're at.=20
Long ago in January Jouni had added some wpa supplicant support into=20
prism54. It's not until today when I started looking into
wpa_supplicant.

I'm glad wpa_supplicant exists :). Interacting with it *is* our missing
link to getting full WPA support (great job Jouni). In wpa_supplicant=20
cvs I see a base code for driver_prism54.c (empty routines, just providing =
skeleton).
Well I'll be diving in it now and see where I can get. If anyone else is
interested in helping with WPA support for prism54, working with
wpa_supplicant is the way to go.

I'm curious though -- wpa_supplicant is pretty much userspace. This was
done with good intentions from what I read but before we get dirty=20
with wpa_supplicant I'm wondering if we should just integrate a lot of=20
wpa_supplicant into kernel space (specifically wireless tools).
Regardless, as Jouni points out, there is still a framework for WPA that ne=
eds
to be written for all linux wireless drivers, whether it's to assist
wpa_supplicant framework or to integrate wpa_supplicant into kernel space.

What's the plan?

	Luis

--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAvX5pat1JN+IKUl4RAryQAJ4tsfPhMRmq85oWK85LGz5PE0XK1ACfSpIO
S4LRkAtZVTbKdKpKb3oZ0e4=
=XKLg
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
