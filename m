Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbVCOJ1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbVCOJ1h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 04:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbVCOJ1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 04:27:37 -0500
Received: from 13.2-host.augustakom.net ([80.81.2.13]:64899 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S262357AbVCOJ1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 04:27:33 -0500
Date: Tue, 15 Mar 2005 10:27:29 +0100
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm3: SIS5513 DMA problem (set_drive_speed_status)
Message-ID: <20050315102729.1c180edf@phoebee>
In-Reply-To: <20050314211755.5e686c50.akpm@osdl.org>
References: <20050314161528.575f3a77@phoebee>
	<20050314211755.5e686c50.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 0.9.12cvs53 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=Signature_Tue__15_Mar_2005_10_27_29_+0100_D6jVWO8mfCq8yTX4;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Tue__15_Mar_2005_10_27_29_+0100_D6jVWO8mfCq8yTX4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Mar 2005 21:17:55 -0800
Andrew Morton <akpm@osdl.org> bubbled:

> Martin Zwickel <martin.zwickel@technotrend.de> wrote:
> >
> > Hi,
> >=20
> > just tried the 2.6.11-mm3 and at boot-time my start scripts try to
> > enable DMA on my disk (hdparm -m16 -c1 -u1 -X69 /dev/hda).
> >=20
> > But while running hdparm, the kernel waits many seconds and gives me
> > some DMA warnings/errors:
> >
> > ...
> >
> > hda: set_drive_speed_status: status=3D0xd0 { Busy }
> >=20
> > ide: failed opcode was: unknown
> > hda: dma_timer_expiry: dma status =3D=3D 0x41
> > hda: DMA timeout error
> > hda: dma timeout error: status=3D0xd0 { Busy }
> > ...
> >=20
> > That happened also with 2.6.11-rc3 since I thought I should switch
> > away from my 2.6.8-rc2-mm1 (the best kernel ever ;)).
>=20
> Could you please check whether 2.6.11-rc1 does this?  It should be
> released mid-week.  Thanks.

Hi Andrew,

you mean 2.6.12-rc1, right?

Regards,
Martin

--=20
MyExcuse:
it has Intel Inside

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature_Tue__15_Mar_2005_10_27_29_+0100_D6jVWO8mfCq8yTX4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCNqqBmjLYGS7fcG0RAldfAJ9UggoXFBIs8r/1/Yk6wPzJHIT/1wCfX4r0
/t64j2/V0trxY7p9UvNdKCU=
=Lk76
-----END PGP SIGNATURE-----

--Signature_Tue__15_Mar_2005_10_27_29_+0100_D6jVWO8mfCq8yTX4--
