Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUANTYA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbUANTVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:21:48 -0500
Received: from ce.fis.unam.mx ([132.248.33.1]:16525 "EHLO ce.fis.unam.mx")
	by vger.kernel.org with ESMTP id S263228AbUANTTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:19:40 -0500
Subject: Re: VIA and NVIDIA
From: Max Valdez <maxvalde@fis.unam.mx>
To: eddie tejeda <eddie@nailchipper.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1074106424.6839.15.camel@applehead>
References: <1074106424.6839.15.camel@applehead>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vR6/w549ojf6iGoeEdh0"
Message-Id: <1074107963.2346.22.camel@garaged.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 14 Jan 2004 13:19:24 -0600
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vR6/w549ojf6iGoeEdh0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I had the same problem with 2.6.x, not 2.4.x.

dmesg said that I needed to set in BIOS: "PNP disable", and "irq->hd
enable", or something like that.

After that, my nvidia works with nvidia.o in 2.6.x too

Hope it helps, take a look at dmesg output

Max
On Wed, 2004-01-14 at 12:53, eddie tejeda wrote:
> I have an NVidia Videocard with a VIA KT333 chipset motherboard..
>=20
> i am about to burst.. i am tried just about every bug-fix, workaround
> and hack, written everywhere in the internet.. to get the Nvidia driver
> to work on my machine. NV works fine.
>=20
> i've been trying this for 6months and finally caving and think that it
> has to be Linux's VIA support. which i've read there are some problems.
>=20
> I am willing to present all information needed.. but this is the post
> i've posted all over NVIDIA boards:
>=20
>=20
>=20
> ***********
>=20
>=20
> The screen used to go black, and flicker blue once, and stop responding.
> number lock works... i can SSH into machine to get logs.. if i try and
> kill X it crashes the machine hard... complete lock out...
>=20
> when i run ps aux i can see X is running 99% of CPU
>=20
> All the options enabled in XFConfig attached have been added and removed
> (when options are removed the flicker happens.. if not... I now get a
> screen with ASCII printed.. just junk.. no flicker.)
>=20
> I have:
> Athlon XP 2200
> Soyo Ultra Platinum, KT333
> PNY GeForce 3 Ti200
> Crucial 512 DDR-333
> ALL tested kernels (2.4.22+, 2.6.x)
> ALL distributions (Fedora, Redhat, Debian)
>=20
> I have tested with following kernel options on and off:
> ACPI/APM
> Fb-Nvidia/Riva
> Pre-empt
> AGPART
>=20
> i attached my XFConfig, XFree86.log and .config(2.6.0)
>=20
>=20
> ************
>=20
>=20
> i am almost certain it is linux.. because the cards work on windows
> machines perfect. and i have tried a few cards on this linux machine the
> same happens.
>=20
> also, most people who have the problems i described.... they get fixed
> with the OPTIONS that i have on my XF86Config. i have tested them all on
> and off.
>=20
>=20
> i would like to see linux do 3d.. one day. :o)...thanks in advance, i
> love the work you guys do and hope to contribute in the future..=20
>=20
>=20
> -eddie
--=20
Linux garaged 2.6.1-mm1 #3 SMP Sat Jan 10 13:18:40 CST 2004 i686 Pentium II=
I (Coppermine) GenuineIntel GNU/Linux
-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GS/S d- s: a-29 C++(+++) ULAHI+++ P+ L++>+++ E--- W++ N* o-- K- w++++ O- M-=
- V-- PS+ PE Y-- PGP++ t- 5- X+ R tv++ b+ DI+++ D- G++ e++ h+ r+ z**
------END GEEK CODE BLOCK------
gpg-key: http://garaged.homeip.net/gpg-key.txt

--=-vR6/w549ojf6iGoeEdh0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBABZY6NNkpVEFxW78RArALAKCafD/C1jLG3shxg+ZCqVzwF2OJDwCfdFyg
yvTwbzPKX2F4EeStaw7O7ZE=
=tY3r
-----END PGP SIGNATURE-----

--=-vR6/w549ojf6iGoeEdh0--

