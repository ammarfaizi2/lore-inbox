Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVCNP4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVCNP4w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 10:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVCNP4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 10:56:51 -0500
Received: from 13.2-host.augustakom.net ([80.81.2.13]:33495 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S261562AbVCNPzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 10:55:54 -0500
Date: Mon, 14 Mar 2005 16:55:49 +0100
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Evgeniy <shubin_evgeniy@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug in kernel
Message-ID: <20050314165549.6985fff2@phoebee>
In-Reply-To: <200503141748.05661.shubin_evgeniy@mail.ru>
References: <200503141748.05661.shubin_evgeniy@mail.ru>
X-Mailer: Sylpheed-Claws 0.9.12cvs53 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=Signature_Mon__14_Mar_2005_16_55_49_+0100_Ch1hx5nTTuVOzH0V;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Mon__14_Mar_2005_16_55_49_+0100_Ch1hx5nTTuVOzH0V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Mar 2005 17:48:05 +0300
Evgeniy <shubin_evgeniy@mail.ru> bubbled:

> Here is a simple program.
>=20
> #include <stdio.h>
> #include <errno.h>
> main(){
>   int err;
>   err=3Dread(0,NULL,6);
>   printf("%d %d\n",err,errno);
> }

Results:
# ./a < /dev/zero=20
read(0, 0, 6)                           =3D -1 EFAULT (Bad address)
-1 14 Bad address

So everything is fine...

Regards,
Martin

--=20
MyExcuse:
I'd love to help you -- it's just that the Boss won't let me near the
computer.

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature_Mon__14_Mar_2005_16_55_49_+0100_Ch1hx5nTTuVOzH0V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCNbQFmjLYGS7fcG0RAqYyAJsE+Vzsq+d9Lwp5qj1CYTwzTk5gswCeK0gV
s/+iZMqjoBiVs/W07bh8bvA=
=pG0m
-----END PGP SIGNATURE-----

--Signature_Mon__14_Mar_2005_16_55_49_+0100_Ch1hx5nTTuVOzH0V--
