Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269285AbUIYIWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269285AbUIYIWO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 04:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269284AbUIYIWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 04:22:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27787 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269283AbUIYIWI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 04:22:08 -0400
Subject: Re: [RFC] put symbolic links between drivers and modules in the
	sysfs tree
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: viro@parcelfarce.linux.theplanet.co.uk, James.Bottomley@steeleye.com,
       greg@kroah.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <E1CB7YE-0004cA-00@gondolin.me.apana.org.au>
References: <E1CB7YE-0004cA-00@gondolin.me.apana.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iBxiXwrs1lVnFT8XtWjP"
Organization: Red Hat UK
Message-Id: <1096100492.17155.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 25 Sep 2004 10:21:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iBxiXwrs1lVnFT8XtWjP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-09-25 at 10:05, Herbert Xu wrote:

> BTW, I'm very glad that this is being worked on and that table in Debian'=
s
> mkinitrd can finally die.

btw does that mkinitrd already use=20
readlink /sys/block/sda/device/block/device

(which gives
../../devices/pci0000:00/0000:00:06.0/0000:03:0b.0/host1/1:0:0:0
as output)

the pci path that gives can easily be matched to modules.pcimap to find
the information in case of a PCI device, so at least the table in your
mkinitrd doesn't need to contain PCI devices.....

--=-iBxiXwrs1lVnFT8XtWjP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBVSqMxULwo51rQBIRAm1qAJ9ohY+2Vr7pGxNLH8AEwX6WZqJK3QCeLTgk
UiAR1b61gZQBgVlpHVWbdU4=
=89pR
-----END PGP SIGNATURE-----

--=-iBxiXwrs1lVnFT8XtWjP--

