Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131811AbRA3SQP>; Tue, 30 Jan 2001 13:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131832AbRA3SPz>; Tue, 30 Jan 2001 13:15:55 -0500
Received: from chmls05.mediaone.net ([24.147.1.143]:11002 "EHLO
	chmls05.mediaone.net") by vger.kernel.org with ESMTP
	id <S131811AbRA3SPx>; Tue, 30 Jan 2001 13:15:53 -0500
Date: Tue, 30 Jan 2001 13:15:11 -0500
From: Jon Anderson <andersoj@mediaone.net>
To: Ronald Lembcke <es186@fen-net.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: no boot with 2.4.x
Message-ID: <20010130131511.D22358@mediaone.net>
In-Reply-To: <98087051420864-30100120864rhairyes@lee.k12.nc.us> <20010130172428.A4899@defiant.crash>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010130172428.A4899@defiant.crash>; from es186@fen-net.de on Tue, Jan 30, 2001 at 05:24:28PM +0100
X-Operating-System: Linux tornado 2.4.0-test10 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


After compiling 2.4 and 2.4ac11 I got failed boots as well, getting=20
either=20

  LI

or=20

  LIL

And then nothing.  This is a K6-2 450 machine, all previous (2.4.0-test*)=
=20
kernels worked fine.  The correct processor is selected...

# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
CONFIG_MK6=3Dy
# CONFIG_MK7 is not set

Running an up to date debian woody distribution.
Switching back to the 2.4.0-test10 kernel and boot sector (using
debian's kernel package) made everything happy again.   Let me know
if a newbie can do anything to help.

JA

On Tue, Jan 30, 2001 at 05:24:28PM +0100, Ronald Lembcke wrote:
> Hi!
>=20
>=20
> On Tue, Jan 30, 2001 at 04:01:54PM +0000, Ryan Hairyes wrote:
> > I compiled the 2.4 kernel on my laptop last night.
> > After editing lilo, I rebooted the machine. I selected
> > this new kernel and when it began to boot, it told me
> > that it was uncompressing the kernel and that the=20
> > kernel uncompression was ok.  Then it just froze.  Any
> > ideas?
>=20
> The same happened to me (not on a laptop) when I forgot to select
> the right CPU-Type (AMD K6-2) and Pentium 3 was still selected.
>=20
> Und weg...=20
>            Roni

--=20
Jonathan Anderson               http://users.rcn.com/~andersoj
andersoj@enc.edu

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjp3BK8ACgkQQTa/MyVvLDjuOACZARQSqRhJ2KOr5vR+ZzytvaS0
tbIAnjcHPbueoLzBt0kjwIhhBAV+aEi7
=CDbU
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
