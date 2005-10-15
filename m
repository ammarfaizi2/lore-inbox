Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbVJOXC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbVJOXC6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 19:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbVJOXC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 19:02:58 -0400
Received: from smtp05.auna.com ([62.81.186.15]:4075 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S1751260AbVJOXC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 19:02:57 -0400
Date: Sun, 16 Oct 2005 01:04:59 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: hdparm almost burned my SATA disk
Message-ID: <20051016010459.0c9a2beb@werewolf.able.es>
In-Reply-To: <20051016010153.768d29d5@werewolf.able.es>
References: <20051016010153.768d29d5@werewolf.able.es>
X-Mailer: Sylpheed-Claws 1.9.15cvs48 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="Signature_Sun__16_Oct_2005_01_04_59_+0200_6uncjwr6hSI/Euh7";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.217.219] Login:jamagallon@able.es Fecha:Sun, 16 Oct 2005 01:02:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Sun__16_Oct_2005_01_04_59_+0200_6uncjwr6hSI/Euh7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 16 Oct 2005 01:01:53 +0200, "J.A. Magallon" <jamagallon@able.es> wr=
ote:

> Hi all...
>=20
> I have seen a very strange thing.=20
> I was trying hdparm -tT on a SATA disk, it did the buffered part OK,
> and hanged my box in the non-buffered measure. After waiting some minutes,
> I did a SysRQ-s-u-b, and the the disk began to give many read errors on
> sectors and could not boot because journal was not present and many other
> errors.
>=20
> After some warm and cold boots, finally the box came up correctly.
> I suspect that something that hdparm did left my disk dumb. But what ?
> I will keep away from hdparm for some time...
>=20
> Any idea ?
>=20

Oops I forgot.
Kernel is 2.6.14-rc2-mm2.
hdparm is v6.1
Filesystem is ext3 on a

werewolf:~/soft/kernel/patches/2.6.13-jam8# hdparm -I /dev/sda

/dev/sda:

ATA device, with non-removable media
        Model Number:       Maxtor 6L160M0                         =20
        Serial Number:      L40MRV4G           =20
        Firmware Revision:  BANC1G10



--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.13-jam8 (gcc 4.0.1 (4.0.1-5mdk for Mandriva Linux release 2006.0))

--Signature_Sun__16_Oct_2005_01_04_59_+0200_6uncjwr6hSI/Euh7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDUYsbRlIHNEGnKMMRAolKAJ9XBMgLDyIulOsV22GsFfHEZh4XFACcC7Yn
wdEOusbwiIH2R2tOOJtPsoU=
=51i4
-----END PGP SIGNATURE-----

--Signature_Sun__16_Oct_2005_01_04_59_+0200_6uncjwr6hSI/Euh7--
