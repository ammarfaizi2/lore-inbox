Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbTKIOOl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 09:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbTKIOOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 09:14:41 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:51392 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S262456AbTKIOOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 09:14:39 -0500
Subject: Re: [PATCH 2.4] forcedeth
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <3FAE0D35.40908@colorfullife.com>
References: <3FAE0D35.40908@colorfullife.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Qd9R0akF2exnMQqfWdz8"
Message-Id: <1068387273.14427.13.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 09 Nov 2003 16:14:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Qd9R0akF2exnMQqfWdz8
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

usually when I boot up it mount's the remote filesystems, now it just
failed, and I tryed to ping lan/internet IP's they failed. And I noticed
that none of my cards were working. this is the output of lspci for the
card that works without forcedeth support in kernel and does not work if
forcedeth is enabled:=20
01:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
That's the main card that I use for lan/internet. ifconfig in the other
hand told me that I had two working cards. first on had ip 192.168.0.2
(that's right) and the new card had 192.168.1.1.
su, 2003-11-09 kello 11:47, Manfred Spraul kirjoitti:
> > And it broke the
> >other card too, ifconfig was right, now there was this card too, but no
> >one from them worked. Thanks anyway.
> >
> Which other card? I'm interested in more details, please explain.
>=20
> So far I received two bug reports:
> - smp locking is broken (stupid bug, I have a fix)
> - sometimes a wrong mac address is used (unresolved)
Regards,
	Markus
--=20
"Software is like sex, it's better when it's free."
Markus H=E4stbacka <midian at ihme.org>

--=-Qd9R0akF2exnMQqfWdz8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Digitaalisesti allekirjoitettu viestin osa

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/rkvJ3+NhIWS1JHARAlqWAKCQDH0P+TjwF0kUsVneypngkiGYmQCg58CV
Ripn9cySHk1WIKshwusSV+Q=
=AbsJ
-----END PGP SIGNATURE-----

--=-Qd9R0akF2exnMQqfWdz8--

