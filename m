Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277717AbRJROEU>; Thu, 18 Oct 2001 10:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277721AbRJROEL>; Thu, 18 Oct 2001 10:04:11 -0400
Received: from adsl-64-109-204-69.milwaukee.wi.ameritech.net ([64.109.204.69]:251
	"HELO alphaflight.d6.dnsalias.org") by vger.kernel.org with SMTP
	id <S277717AbRJRODy>; Thu, 18 Oct 2001 10:03:54 -0400
Date: Thu, 18 Oct 2001 09:04:12 -0500
From: "M. R. Brown" <mrbrown@0xd6.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Non-GPL modules
Message-ID: <20011018090412.I22296@0xd6.org>
In-Reply-To: <Pine.LNX.3.95.1011018091343.32746A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jHkwA2TBA/ec6v+"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1011018091343.32746A-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jHkwA2TBA/ec6v+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Richard B. Johnson <root@chaos.analogic.com> on Thu, Oct 18, 2001:

>=20
> >From time-to-time, I've asked that certain things be allowed
> within the kernel such as, most recently, denying a raw write
> to a mounted file-system. Such things have been opposed because,
> as I have been told, "Policy is not allowed within the kernel...".
>=20
> Well, with the current GPL code-only fiasco, this is Policy being
> enforced by the kernel.
>=20
> It won't be long before we get:
>=20
> Script started on Thu Oct 18 08:44:44 2001
> # gcc -o applic xxx.c
> # ./applic
> Kernel panic
> Non GPL application pollution of the Linux environment
> Application name =3D ./applic
>  Virtual address =3D 0x8048528
>    Stack address =3D 0xbffff72c
>              PID =3D 32636
> System halted
>=20
> I can understand not wanting to take any responsibility for
> some binary-only module when attempting to find a kernel
> problem. However, denying the use of non GPL modules is
> not the way. As a developer of many modules, I can certainly
> add the required object(s) during development and bypass the
> current policy. In fact, since the source code of `insmod`
> is available, it won't be long before any checks put there
> are eliminated.=20
>=20

I've seen this skewed view being reiterated time and time enough on the
list to ask,

Are you people on crack?

Where is policy being enforced?  insmod spits out a *warning* and procedes
to taint the kernel.  That's it.  It doesn't prevent such modules from
being loaded, it doesn't go back on Linus' provision to allow proprietary
modules, and it doesn't e-mail RMS with the subject "Linux (not GNU/Linux) =
is
no longer pure".  From reading Alan's posts, the primary purpose of this
provision is to help kernel hackers determine whether it's worth their
while to follow up on bug reports.  You can only do this with a "pure"
kernel, since you have no way of knowing if it's something in the
binary-only module that's killing the kernel.

Why the conspiracy?

As far as EXPORT_MODULE_GPL is concerned, I think that's an excellent idea.
There is *nothing* wrong with a copyright holder enforcing the fair use of
his/her software, and I'd encourage all new GPL'd modules to start
exporting these symbols.

There are some of us who strive to keep the kernel as "pure" as possible,
for a variety of reasons, the main one for me being peace of mind (knowing
my code base is supported, and bugfixes are cheap).  Why is this so
difficult for folks to grasp?

I'll shutup now, please read Keith Owen's post ("MODULE_LICENSE and
EXPORT_SYMBOL_GPL") for any more clarification.

M. R.

--9jHkwA2TBA/ec6v+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE7zuFcaK6pP/GNw0URAg8QAKDF4HW/W+k/HER6qtPwaclhBPUuFACdHWv8
5OzHKSW01hhUL7Afyg2XvGs=
=YI5O
-----END PGP SIGNATURE-----

--9jHkwA2TBA/ec6v+--
