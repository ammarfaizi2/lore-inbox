Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbULLNjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbULLNjn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 08:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbULLNjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 08:39:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:47554 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262074AbULLNi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 08:38:29 -0500
X-Authenticated: #3340650
Subject: Re: [<02282da7>] (usb_hcd_irq+0x0/0x4b) Disabling IRQ #5 - USB
	Devices do not work
From: Florian Krammel <florian_kr@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel-list <linux-kernel@vger.kernel.org>
In-Reply-To: <1102503828.23635.1.camel@localhost.localdomain>
References: <1102333735.5095.4.camel@orange-bud>
	 <1102339694.13485.26.camel@localhost.localdomain>
	 <1102450409.7531.10.camel@orange-bud> <1102452729.7531.29.camel@orange-bud>
	 <1102503828.23635.1.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7VgmpjXwzXjIqSZSntIN"
Date: Sun, 12 Dec 2004 14:38:26 +0100
Message-Id: <1102858706.9524.4.camel@orange-bud>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7VgmpjXwzXjIqSZSntIN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mittwoch, den 08.12.2004, 11:03 +0000 schrieb Alan Cox:
> On Maw, 2004-12-07 at 20:52, Florian Krammel wrote:
> > > > Ditto, and this is quite possibly the root cause. That suggests the=
 BIOS
> > > > handover code for EHCI is insufficient for some cases (and it appea=
rs to
> > > > be looking at the code quickly - it should register IRQ 5 before do=
ing a
> > > > handover which it does but it probably needs to just ack and mask I=
RQ 5
> > > > during the handover. It could be another device breaking IRQ5 howev=
er)
> > > >=20
> > > >=20
> > > > What occurs if you build a kernel with EHCI disabled, ditto what oc=
curs
> > > > if you boot with init=3D/bin/sh and then load ohci before ehci ?
> >=20
> > I don't tested this because "irqpoll" solve my problem. Are you
> > interested in the result? I can try it.
>=20
> I would be very interested to know if this makes a difference yes

today I've tested this and there is no difference...

maybe it is the unsopported ATI chip?

=20

--=-7VgmpjXwzXjIqSZSntIN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBvEnRm9XQAcbR/eIRApXQAJ9S5NXq6P1T7soFXeV1zBWlhH3fggCeNGu6
8NlNxN5pT03WM7Y4Z0V8mWo=
=lKyB
-----END PGP SIGNATURE-----

--=-7VgmpjXwzXjIqSZSntIN--

