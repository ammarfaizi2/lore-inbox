Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269518AbUJLIXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269518AbUJLIXr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 04:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269523AbUJLIXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 04:23:47 -0400
Received: from 221-169-69-23.adsl.static.seed.net.tw ([221.169.69.23]:41922
	"EHLO cola.voip.idv.tw") by vger.kernel.org with ESMTP
	id S269518AbUJLIXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 04:23:41 -0400
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T5
From: Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>, Ingo Molnar <mingo@elte.hu>,
       Mark_H_Johnson@Raytheon.com, Andrew Morton <akpm@osdl.org>,
       Daniel Walker <dwalker@mvista.com>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <1097542369.1453.113.camel@krustophenia.net>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	 <20041011215909.GA20686@elte.hu> <20041012005754.1d49a074@mango.fruits.de>
	 <20041012011447.3e7669f8@mango.fruits.de>
	 <1097542369.1453.113.camel@krustophenia.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FaTFBBcrZHVwr/brPf11"
Message-Id: <1097569341.6157.21.camel@libra>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 12 Oct 2004 16:22:22 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FaTFBBcrZHVwr/brPf11
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Lee Revell wrote:
> On Mon, 2004-10-11 at 19:14, Florian Schmidt wrote:
> > On Tue, 12 Oct 2004 00:57:54 +0200
> > Florian Schmidt <mista.tapas@gmx.net> wrote:
> >=20
> > > hi,
> > >=20
> > > i still can't build it. Fist i reverse applied T4, then applied T5 an=
d tried
> > > a make bzImage. I'll try from scratch though to make sure, cause thes=
e
> > > errors look identical to the T4 ones.
> > >=20
> >=20
> > same errors.. Both with the preemptible real time thingy and without..
> >=20
>=20
> Try building for SMP.  I suspect this is a UP build problem.

I got same errors...
Struct mutex_t is defined in include/asm-i386/spinlock.h. It's only
included in include/linux/spinlock.h if CONFIG_SMP is set, but mutex_t
is used at include/linux/spinlock.h:419. Set CONFIG_SMP=3Dy then kernel
builds successfully here.

--=20
Best Regards,
Wen-chien Jesse Sung

--=-FaTFBBcrZHVwr/brPf11
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: 	=?UTF-8?Q?=E9=80=99=E6=98=AF=E6=95=B8=E4=BD=8D=E5=8A=A0=E7=B0=BD?=
	=?UTF-8?Q?=E7=9A=84=E9=83=B5?= =?UTF-8?Q?=E4=BB=B6?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBa5Q9lZ/JOHsLIwgRArvDAJ0XL6BYMnbmh+o7LfXjPCOUx+9WQgCg2isl
Lt2pg1KaJRDSTpCFRch1j+8=
=f+7i
-----END PGP SIGNATURE-----

--=-FaTFBBcrZHVwr/brPf11--

