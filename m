Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135331AbRDXKj3>; Tue, 24 Apr 2001 06:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135528AbRDXKjO>; Tue, 24 Apr 2001 06:39:14 -0400
Received: from cdsl18.ptld.uswest.net ([209.180.170.18]:27499 "HELO
	galen.magenet.net") by vger.kernel.org with SMTP id <S135331AbRDXKis>;
	Tue, 24 Apr 2001 06:38:48 -0400
Date: Tue, 24 Apr 2001 03:39:22 -0700
From: Joseph Carter <knghtbrd@debian.org>
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
Cc: "Mike A. Harris" <mharris@opensourceadvocate.org>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Semi-OT] Dual Athlon support in kernel
Message-ID: <20010424033922.A5878@debian.org>
In-Reply-To: <Pine.LNX.4.33.0104240115050.21785-100000@asdf.capslock.lan> <3AE52C2C.C6B2B472@mountain.net> <20010424131857.F3529@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010424131857.F3529@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Tue, Apr 24, 2001 at 01:18:57PM +0300
X-Operating-System: Linux galen 2.4.3-ac12
X-No-Junk-Mail: Spam will solicit a hostile reaction, at the very least.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2001 at 01:18:57PM +0300, Ville Herva wrote:
> There's also AthlonLinux http://athlonlinux.org/ and AthlonGCC
> http://athlonlinux.org/agcc/about.shtml, but I have no experience with th=
ose
> (I have no Athlon ;( ).

A warning about agcc, I've discovered that it does not always compile code
quite the way you expect it.  This is unsurprising given it's based on
pgcc which is known to change alignments on you in ways that sometimes
break things subtly.


I do not know if agcc actually can produce code which simply does not work
as is reported with pgcc (I suspect the alignment differences account for
many of those cases), but I recall reading in the past few days that agcc
is not supported for compiling the kernel.

It also fails to properly compile certain other programs, notably anything
that includes asm functions.  As a result, my own experience suggests you
consider agcc in the same class as gcc 3.0 at the moment - experimental.
Hopefully the k7 optimizations that work well will find their way into a
nice athlon subarch options in standard gcc and agcc won't be necessary.

--=20
Joseph Carter <knghtbrd@debian.org>                Free software developer

Guns don't kill people.  It's those damn bullets.  Guns just make them go
really really fast.
        -- Jake Johanson


--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: 1024D/DCF9DAB3  20F6 2261 F185 7A3E 79FC  44F9 8FF7 D7A3 DCF9 DAB3

iEYEARECAAYFAjrlV9oACgkQj/fXo9z52rOFSQCeNv7/mUDf+hLG1JTruT0KsSLy
SeUAniChWQCjlAei9oKkc2uBb/x5qbdC
=1iur
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
