Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbUCDRQO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 12:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbUCDRQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 12:16:14 -0500
Received: from nef.ens.fr ([129.199.96.32]:41483 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id S262038AbUCDRQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 12:16:05 -0500
Date: Thu, 4 Mar 2004 18:15:56 +0100
From: Nicolas George <nicolas.george@ens.fr>
To: linux-kernel@vger.kernel.org
Subject: PF_PACKET to self
Message-ID: <20040304171556.GA27551@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

As far as I can see, frames sent on an ethernet network using a
PF_PACKET are not seen by the originating host itself: for example I can
send an ARP request and get an answer from another host on the network,
but I can not get an answer from my own host.

Is there a way to turn such a loopback on?

I already had the suggestion to use a tun/tap device and copy all frames
to/from the real ethernet interface, but I would rather use a lighter
solution if there is one.

Regards,

--=20
  Nicolas George

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (SunOS)

iD8DBQFAR2RLsGPZlzblTJMRAtm5AJwM6mVUzAFkxhqj7NlRDz0T6PMjQQCgz5x8
U2b54JOrilwSkKam9tRoEiI=
=Ovev
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
