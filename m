Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262564AbVCVIrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbVCVIrO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 03:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbVCVIrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 03:47:14 -0500
Received: from 13.2-host.augustakom.net ([80.81.2.13]:13451 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S262564AbVCVIrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 03:47:07 -0500
Date: Tue, 22 Mar 2005 09:47:01 +0100
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm3: SIS5513 DMA problem (set_drive_speed_status)
Message-ID: <20050322094701.1d17b401@phoebee>
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
 boundary="Signature_Tue__22_Mar_2005_09_47_01_+0100_=0FAmgMoLP_VqaZf";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Tue__22_Mar_2005_09_47_01_+0100_=0FAmgMoLP_VqaZf
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

ps.: just booted 2.6.12-rc1-mm1 and hdparm works now much better on boot
     than 2.6.11-mm3. ;)

--=20
MyExcuse:
We're upgrading /dev/null

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature_Tue__22_Mar_2005_09_47_01_+0100_=0FAmgMoLP_VqaZf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCP9uHmjLYGS7fcG0RApSCAJ40sKRmjYHRE/HqMfNR1djF3m1LtQCfcmzl
IksENmDtg/4PPljrseZN/oM=
=K8vS
-----END PGP SIGNATURE-----

--Signature_Tue__22_Mar_2005_09_47_01_+0100_=0FAmgMoLP_VqaZf--
