Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTHJMFX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 08:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263952AbTHJMFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 08:05:23 -0400
Received: from 4demon.com ([217.160.186.4]:17577 "EHLO pro-linux.de")
	by vger.kernel.org with ESMTP id S263930AbTHJMFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 08:05:16 -0400
Date: Sun, 10 Aug 2003 14:05:12 +0200
From: Hans-Joachim Baader <hjb@pro-linux.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3: drivers/ide/setup-pci.c
Message-ID: <20030810120511.GA883@kiwi.hjbaader.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

drivers/ide/setup-pci.c ca. line 710:

if (noisy)
	printk(KERN_INFO "%s: not 100%% native mode: "
		"will probe irqs later\n", d->name);

The two %% will be printed as such at least on my system (i386, VGA console,
no framebuffer):

AMD7411: not 100%% native mode:

Regards,
hjb
--=20
Pro-Linux - Germany's largest volunteer Linux support site
http://www.pro-linux.de/          Public Key ID 0x3DDBDDEA

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/NjT3LbySPj3b3eoRAvtAAJ0fHn2JMYsQj/iEgZVScX48Y3g1HQCfYheY
Ri5gwn0jpsOM294Xbb2tP3w=
=PjAq
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
