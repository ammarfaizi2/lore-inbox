Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262323AbULOK6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbULOK6q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 05:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbULOK6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 05:58:18 -0500
Received: from macedonia.mhl.tuc.gr ([147.27.3.60]:59865 "HELO
	macedonia.mhl.tuc.gr") by vger.kernel.org with SMTP id S262323AbULOKyz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 05:54:55 -0500
Subject: Re: PCI interrupt lost
From: Dimitris Lampridis <labis@mhl.tuc.gr>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0412130755290.22212@montezuma.fsmlabs.com>
References: <1102941933.3415.14.camel@naousa.mhl.tuc.gr>
	 <Pine.LNX.4.61.0412130755290.22212@montezuma.fsmlabs.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lHOgQX8kp4IHi2WmPq2G"
Date: Wed, 15 Dec 2004 12:54:42 +0200
Message-Id: <1103108082.3565.5.camel@naousa.mhl.tuc.gr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lHOgQX8kp4IHi2WmPq2G
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-12-13 at 07:59 -0700, Zwane Mwaikambo wrote:
> > So, to make things short, my device is generating interrupts, my code
> > has a functioning and registered interrupt routine (/proc/interrupts
> > agrees as well but interrupt count is 0 for the specific IRQ), but no
> > interrupt is ever received from the PCI card.
>=20
> What does the PCI device report as the interrupt line? What do you=20
> register with request_irq?

No there's no problem there. I always register the correct interrupt
line (the one that is seen with lspci for example), without explicitly
requesting the number, but by using dev->irq after I've called
pci_enable_device()

>=20
> Ps. Isn't there already a driver for that controller?

Yep, and not only one I might add... But none of them is showing the
correct behaviour that a good driver should (in my humble opinion), and
the best efforts are for kernels 2.4

Anyway, thanks

--=20
Dimitris Lampridis <labis@mhl.tuc.gr>

--=-lHOgQX8kp4IHi2WmPq2G
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBwBfygMArLfy6HHMRAhq8AJ4sI/am2nFMQMPVlaD5Q4nvHQQP6ACfXWc2
eKC/wxvjIDXQFFAtkseD0P0=
=+Oth
-----END PGP SIGNATURE-----

--=-lHOgQX8kp4IHi2WmPq2G--

