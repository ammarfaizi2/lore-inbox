Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265866AbTFVUcE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 16:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265873AbTFVUcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 16:32:04 -0400
Received: from iucha.net ([209.98.146.184]:30822 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S265866AbTFVUcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 16:32:02 -0400
Date: Sun, 22 Jun 2003 15:46:08 -0500
To: Greg KH <greg@kroah.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.73
Message-ID: <20030622204607.GA16386@iucha.net>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com>
X-message-flag: Microsoft: Where do you want to go today? Nevermind, you are coming with us!
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.4i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

drivers/built-in.o(.text+0x3106): In function `pci_remove_bus_device':
: undefined reference to `pci_destroy_dev'

pci_destroy_dev is defined under CONFIG_HOTPLUG and used outside.

florin

PS: I think changeset referenced in 10560659712069@kroah.com
causes the problem.

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+9hWPNLPgdTuQ3+QRAoX0AKCR77o9SwPbDCWKJuwgEJZfj4RGYwCfaFZZ
uiFJGFe3mSDcZUwUNcgm5Jk=
=cIKi
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
