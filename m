Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131526AbRAaRAg>; Wed, 31 Jan 2001 12:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131795AbRAaRA0>; Wed, 31 Jan 2001 12:00:26 -0500
Received: from munch-it.turbolinux.com ([38.170.88.129]:50164 "EHLO
	mail.us.tlan") by vger.kernel.org with ESMTP id <S131526AbRAaRAX>;
	Wed, 31 Jan 2001 12:00:23 -0500
Date: Wed, 31 Jan 2001 08:59:48 -0800
From: Prasanna P Subash <psubash@turbolinux.com>
To: Gerd Knorr <kraxel@goldbach.in-berlin.de>
Cc: msg2@po.cwru.edu, John Jasen <jjasen1@umbc.edu>,
        linux-kernel@vger.kernel.org, AmNet Computers <amnet@amnet-comp.com>
Subject: Re: bttv problems in 2.4.0/2.4.1
Message-ID: <20010131085948.A26240@turbolinux.com>
In-Reply-To: <Pine.SGI.4.31L.02.0101301951040.887333-100000@irix2.gl.umbc.edu> <Pine.LNX.4.32.0101302004420.1138-100000@cheetah.STUDENT.cwru.edu> <200101310741.f0V7fj600833@bogomips.masq.in-berlin.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101310741.f0V7fj600833@bogomips.masq.in-berlin.de>; from Gerd Knorr on Wed, Jan 31, 2001 at 08:41:45AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


My bttv is at IRQ 3 and it still hangs the machine :(
I dont even have acpi built in.

btw I am testing with 2.4.1-pre9
--=20
Prasanna Subash   ---   psubash@turbolinux.com   ---     TurboLinux, INC
------------------------------------------------------------------------
Linux, the choice          | When the sun shineth, make hay.   -- John
of a GNU generation   -o)  | Heywood=20
Kernel 2.4.0-ac4      /\\  |=20
on a i686            _\\_v |=20
                           |=20
------------------------------------------------------------------------

On Wed, Jan 31, 2001 at 08:41:45AM +0100, Gerd Knorr wrote:
> > > > I have sent all this info to Gerd Knorr but, as far as I know, he h=
asn't
> > > > been able to track down the bug yet.  I thought that by posting her=
e,
> > > > more eyes might at least make more reports of similar situations th=
at
> > > > might help track down the problem.
> > >
> > > Try flipping the card into a different slot. A lot of the cards
> > > exceptionally do not like IRQ/DMA sharing, and a lot of the motherboa=
rds
> > > share them between different slots.
> >=20
> > I will try this, but my card has (and does) worked with irq sharing for
> > a long time.  Its entry in /proc/interrupts:
> >   9:     164935     165896   IO-APIC-level  acpi, bttv
>                                               ^^^^
> What happens with acpi disabled?  The power-down at boot could be caused =
by
> the acpi power management maybe ...
>=20
>   Gerd
>=20
> --=20
> Get back there in front of the computer NOW. Christmas can wait.
> 	-- Linus "the Grinch" Torvalds,  24 Dec 2000 on linux-kernel
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/



--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6eESE5UrYeFg/7bURArR8AJ9xCboW1yIcc8U49FRyANFa2897qQCgil6p
nez/a4UnJqxfKnO7DqWkUgM=
=Ba0T
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
