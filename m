Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAIWmn>; Tue, 9 Jan 2001 17:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129835AbRAIWme>; Tue, 9 Jan 2001 17:42:34 -0500
Received: from munch-it.turbolinux.com ([38.170.88.129]:36603 "EHLO
	mail.us.tlan") by vger.kernel.org with ESMTP id <S129431AbRAIWmb>;
	Tue, 9 Jan 2001 17:42:31 -0500
Date: Tue, 9 Jan 2001 14:42:24 -0800
From: Prasanna P Subash <psubash@turbolinux.com>
To: Taner Halicioglu <taner@taner.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 and EMU10K1 problems...
Message-ID: <20010109144224.C410@turbolinux.com>
In-Reply-To: <20010108135629.S3871@boom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <20010108135629.S3871@boom.net>; from Taner Halicioglu on Mon, Jan 08, 2001 at 01:56:29PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

remember seeing something about this on the list.
Build it as a module, and not into the kernel and it should work.
--=20
Prasanna Subash   ---   psubash@turbolinux.com   ---     TurboLinux, INC
------------------------------------------------------------------------
Linux, the choice          | Actually, what I'd like is a little toy
of a GNU generation   -o)  | spaceship!!=20
Kernel 2.4.0-test11   /\\  |=20
on a i686            _\\_v |=20
                           |=20
------------------------------------------------------------------------

On Mon, Jan 08, 2001 at 01:56:29PM -0800, Taner Halicioglu wrote:
> (please cc me if you reply - thanks :)
>=20
> I probably missed a message or note or something about this, but when I w=
ent
> from 2.2.17 to 2.2.18, my sound card (SB Live!) stopped working.  It seems
> that in 2.2.18, it gets detected TWICE:
>=20
> --------------------------------
> kernel: Linux version 2.2.18
> [...]
> kernel: Creative EMU10K1 PCI Audio Driver, version 0.7, 20:05:23 Jan  7 2=
001=20
> kernel: emu10k1: EMU10K1 rev 5 model 0x21 found, IO at 0xb400-0xb41f, IRQ=
 10=20
> [... IDE, floppy, SCSI, eth0, partition check ...]
> kernel: Creative EMU10K1 PCI Audio Driver, version 0.7, 20:05:23 Jan  7 2=
001=20
> --------------------------------
>=20
> This is what it normally does:
>=20
> --------------------------------
> kernel: Linux version 2.2.17
> [...]
> kernel: Creative EMU10K1 PCI Audio Driver, version 0.6, 20:25:53 Jan  7 2=
001=20
> kernel: emu10k1: EMU10K1 rev 5 model 0x21 found, IO at 0xb400-0xb41f, IRQ=
 10=20
> [...]
> --------------------------------
>=20
> In the 2.2.18 case, /proc/interrupts doesn't show anything on int 10.
>=20
> I guess I should (and will) take this up with the EMU10k people, but I was
> just wondering if anyone here has seen this problem before?  I'm curious =
how
> a broken driver would have made it into .18 like that ;-)  ...unless I'm =
the
> one that is broken :)
>=20
> Thanks,
>=20
> 	-Taner
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/



--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6W5PQ5UrYeFg/7bURAsLkAJ9VxjTEgV02uyZzqtuL+x55g8v/IwCgsh2c
J//Ib7YbZT5Snx1jKEYaeQ8=
=I3xg
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
