Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161228AbWASPKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161228AbWASPKc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 10:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161229AbWASPKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 10:10:32 -0500
Received: from mail.gmx.net ([213.165.64.21]:43949 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161228AbWASPKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 10:10:32 -0500
X-Authenticated: #5082238
Date: Thu, 19 Jan 2006 17:10:33 +0100
From: Carsten Otto <c-otto@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Kernel BUG at include/linux/gfp.h:80
Message-ID: <20060119161033.GB12518@carsten-otto.halifax.rwth-aachen.de>
Reply-To: c-otto@gmx.de
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
X-GnuGP-Key: http://c-otto.de/pubkey.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi there!

My kernel panics at every boot, see screenshot[1].

I upgraded my CPU to an Opteron 175 (Dual Core) and enabled SMP in the
kernel. With "nosmp" the kernel boots (but has problems finding one hard
disk later on, some IRQ timeout?). The kernel version is 2.6.15.1,
config see here[2].

With my current non-SMP-kernel (2.6.14.4) everything works.

Please tell me what that BUG message means and how I can get my system
running.

Addition information regarding the hardware can be found here[3].

Thanks a lot,
Carsten

[1]: http://c-otto.de/panic.jpg
[2]: http://c-otto.de/config.txt
[3]: http://c-otto.de/index.php?x=3Dhardware#teile
--=20
Carsten Otto
c-otto@gmx.de
www.c-otto.de

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDz7n5jUF4jpCSQBQRAstbAJ94VBacHAcmxro8iUFoT8A9SOz25ACbBu8V
OYepac92xk7s9RDeeaEpRMQ=
=KGiE
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
