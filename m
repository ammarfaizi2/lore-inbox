Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269640AbUJLLgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269640AbUJLLgP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 07:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269624AbUJLLgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 07:36:15 -0400
Received: from 221-169-69-23.adsl.static.seed.net.tw ([221.169.69.23]:15564
	"EHLO cola.voip.idv.tw") by vger.kernel.org with ESMTP
	id S269640AbUJLLdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 07:33:35 -0400
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T6
From: Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com
In-Reply-To: <20041012103512.GA24836@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	 <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu>
	 <1097573492.6157.26.camel@libra>  <20041012103512.GA24836@elte.hu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZF42KLmiKr1kYtuv6b6y"
Message-Id: <1097580757.6157.32.camel@libra>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 12 Oct 2004 19:32:37 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZF42KLmiKr1kYtuv6b6y
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Ingo Molnar wrote:
> * Wen-chien Jesse Sung <jesse@cola.voip.idv.tw> wrote:
>=20
> > > this should fix the UP build issues reported by many. -T6 also brings
> > > back the ->break_lock framework and converts a few more locks to raw.
> >=20
> > UP build is still failed:=20
> >  arch/i386/kernel/vm86.c:707: error: `__RAW_SPIN_LOCK_UNLOCKED'
> > undeclared here (not in a function)
>=20
> ok, fixed this one too and re-uploaded -T6 - please check whether it
> builds for you now.

Yes, it works now! Thanks a lot! :)

--=20
Best Regards,
Wen-chien Jesse Sung

--=-ZF42KLmiKr1kYtuv6b6y
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: 	=?UTF-8?Q?=E9=80=99=E6=98=AF=E6=95=B8=E4=BD=8D=E5=8A=A0=E7=B0=BD?=
	=?UTF-8?Q?=E7=9A=84=E9=83=B5?= =?UTF-8?Q?=E4=BB=B6?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBa8DUlZ/JOHsLIwgRAnx7AKCfN9PaCF6a+MFkl7qVfj8JQeViawCfYx4X
nXUmz6hUl3wXFkwAVReuoyg=
=ltDj
-----END PGP SIGNATURE-----

--=-ZF42KLmiKr1kYtuv6b6y--

