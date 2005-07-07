Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262429AbVGGWwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbVGGWwX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 18:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVGGWtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 18:49:49 -0400
Received: from goliat.kalisz.mm.pl ([217.96.42.226]:741 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S262383AbVGGWsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 18:48:51 -0400
Date: Fri, 8 Jul 2005 00:48:46 +0200
From: Radoslaw "AstralStorm" Szkodzinski <astralstorm@gorzow.mm.pl>
To: Rudo Thomas <rudo@matfyz.cz>
Cc: kernel@kolivas.org, linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: Re: [ck] Re: 2.6.12-ck3
Message-Id: <20050708004846.7c6abf61.astralstorm@gorzow.mm.pl>
In-Reply-To: <20050707213034.GA9306@ss1000.ms.mff.cuni.cz>
References: <200506301241.00593.kernel@kolivas.org>
	<20050704091648.GA14759@ss1000.ms.mff.cuni.cz>
	<20050707213034.GA9306@ss1000.ms.mff.cuni.cz>
X-Mailer: Sylpheed version 2.0.0beta4 (GTK+ 2.6.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__8_Jul_2005_00_48_46_+0200_ssW4.5r0bN=d7RqE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__8_Jul_2005_00_48_46_+0200_ssW4.5r0bN=d7RqE
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Jul 2005 23:30:34 +0200
Rudo Thomas <rudo@matfyz.cz> wrote:

> Hi again.
>=20
> > Time seems to pass very fast with this kernel.
>=20
> dmesg output has not revealed anything extraordinary...
>=20
> Am I the only one who gets this strange behaviour? Kernel's notion of
> time seems to be about 30 times faster than real time.
>=20
> I will gladly provide any information that will help sorting this
> problem out.
>=20

I've seen something like this with some VIA mainboards.
But that was happening on all kernels.

The problem was broken TSC I think.
The solution was to enable HPET and/or enable ACPI PM Timer.


--=20
AstralStorm

GPG Key ID =3D 0xD1F10BA2
GPG Key fingerprint =3D 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2
Please encrypt if you can.

--Signature=_Fri__8_Jul_2005_00_48_46_+0200_ssW4.5r0bN=d7RqE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iD8DBQFCzbFOlUMEU9HxC6IRAhGRAJ9HxB23wgp/YFtLn4TN0N7uOh2PrwCbBPQS
avulcRUS58QmJcgyv0KBoBA=
=fHGD
-----END PGP SIGNATURE-----

--Signature=_Fri__8_Jul_2005_00_48_46_+0200_ssW4.5r0bN=d7RqE--
