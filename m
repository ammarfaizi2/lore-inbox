Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279190AbRKFMZ0>; Tue, 6 Nov 2001 07:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279180AbRKFMZH>; Tue, 6 Nov 2001 07:25:07 -0500
Received: from [194.51.220.145] ([194.51.220.145]:64854 "EHLO emeraude")
	by vger.kernel.org with ESMTP id <S279156AbRKFMY7>;
	Tue, 6 Nov 2001 07:24:59 -0500
Date: Tue, 6 Nov 2001 13:24:37 +0100
From: Stephane Jourdois <stephane@tuxfinder.org>
To: Juri Haberland <juri@koschikode.com>
Cc: Massimo Dal Zotto <dz@debian.org>, LKLM <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMM BIOS on Dell i8100
Message-ID: <20011106132437.A626@emeraude.kwisatz.net>
Reply-To: stephane@tuxfinder.org
In-Reply-To: <3BE6B869.D79E93B1@mandrakesoft.com> <20011105231759.02B541195E@a.mx.spoiled.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <20011105231759.02B541195E@a.mx.spoiled.org>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.4.14-pre8
X-Send-From: emeraude
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 06, 2001 at 12:17:59AM +0100, Juri Haberland wrote:
> In article <3BE6B869.D79E93B1@mandrakesoft.com> you wrote:
> > Stephane Jourdois wrote:
> >> I've got a Dell Inspiron 8100, which seems to differ slightly from
> >> i8000. Here is a patch that fixes that. Please do not hesitate to ask =
me
> >> to test some new code or anything on my laptop.
> > Has this been tested in I8000?  You are changing a lot of magic numbers
> > in the code, and noone but you/Massimo know whether that is ok or not...
> Actually, I just tried plain 2.4.14-pre8 and the i8k-module *didn't*
> work with my i8000, but with the patch from Stephane it *does* ;)

> PS: BIOS verion A17 if that matters

mmm I have a i8100 with A04 BIOS...

But that confirms that multiple versions of SMM BIOS exists, and that we
have to test only 4 lighter bits, even on i8000.

Does anybody have a Dell Inspiron around there that still doesn't work ?
i8x00 should work, but perhaps others Inspirons have quite the same SMM
BIOS ?

Stephane.

--=20
 ///  Stephane Jourdois        	/"\  ASCII RIBBON CAMPAIGN \\\
(((    Ing=E9nieur d=E9veloppement 	\ /    AGAINST HTML MAIL    )))
 \\\   6, av. de la Belle Image	 X                         ///
  \\\  94440 Marolles en Brie  	/ \    +33 6 8643 3085    ///

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjvn1oUACgkQk2dpMN4A2NM2/QCeLBH4Y8ePbw8pg0x4uA5y88Qz
jCQAn0QSRPB6bcDlJkZhHBo5rzX7kmX7
=JXKo
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
