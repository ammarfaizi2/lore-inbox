Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281020AbRKYTzs>; Sun, 25 Nov 2001 14:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281021AbRKYTzi>; Sun, 25 Nov 2001 14:55:38 -0500
Received: from f05s15.cac.psu.edu ([128.118.141.58]:15833 "EHLO
	f05n15.cac.psu.edu") by vger.kernel.org with ESMTP
	id <S281020AbRKYTzd>; Sun, 25 Nov 2001 14:55:33 -0500
Subject: Re: Kernel Releases
From: Phil Sorber <aafes@psu.edu>
To: David Relson <relson@osagesoftware.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <4.3.2.7.2.20011124231412.00b40c50@mail.osagesoftware.com>
In-Reply-To: <4.3.2.7.2.20011124231412.00b40c50@mail.osagesoftware.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-io7TUqJW4cBPAqCKT754"
X-Mailer: Evolution/0.16 (Preview Release)
Date: 25 Nov 2001 14:55:24 -0500
Message-Id: <1006718131.3088.13.camel@praetorian>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-io7TUqJW4cBPAqCKT754
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

i know this is an old thread now, but i thought of something that might
be a nice feature, though it means more work for kernel maintainers.

a bug patch seperate from the new kernel patch. so you could only
upgrade from 2.4.0 with the bug fixes in 2.4.1. by the time you're at
something like 2.4.15, 2.4.0 should be rock solid. but you wouldn't have
any new funcionality.

say you wanted the new VM. you could upgrade to the first kernel with
the new VM, then get the bug patch for the latest kernel.

not a simple straigt forward idea, and it could mean a lot of work.
though maybe it is easier than i realize, or a few orders of magnitude
harder than i realize, and thus not worth it.

i've noticed that the 'aa' patch series seems to be something along
these lines.

On Sat, 2001-11-24 at 23:27, David Relson wrote:
> Greetings to All,
>=20
> Over the past few months, I've been listening in on LKML, with occasional=
,=20
> minor comments - mostly to help newbies.  Now, I think it's time for a=20
> suggestion ...
>=20
> As we all know, several of the recent releases have had defects that have=
=20
> __required__ patches before they could be built (or used safely).  Proble=
ms=20
> with symlinks, loopbacks, and unmount come to mind as being like=20
> this.  They are all show stoppers that required immediate fixes and the=20
> creation of a new release or of the next -pre1 version.
>=20
> I have a tendency to tink that it's better to be running a released kerne=
l,=20
> than a pre-release kernel.  I'd much rather be running a kernel named 2.4=
.x=20
> than a kernel named 2.4.y-pre?.  With the recent problems, the working=20
> versions tend to be the -pre1 or -pre2 releases, not the released=20
> one.  With a bit of QA, I think we can have 2.4.x releases be the stable=20
> releases.  Here's how...
>=20
> When the kernel maintainer, now Marcelo for 2.4, is ready to release the=20
> next kernel, for example 2.4.16, I suggest he switch from "pre?" to "-rc1=
"=20
> (as in release candidate).  A day or two with -rc1 will quickly show if i=
t=20
> has a show stopper.  If so, then the minor fixes (and nothing else) go in=
to=20
> -rc2.  A day or two ..., and either -rc3 appears or we have a stable=20
> release and 2.4.16 is ready to be released.
>=20
> Let's go the extra distance and have the releases be usable, stable=20
> kernels!  It's what users want and it's within the abilities of the=20
> developers to produce.  Let's do it :-)
>=20
> David
>=20
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20
--=20
Phil Sorber
AIM: PSUdaemon
IRC: irc.openprojects.net #psulug PSUdaemon
GnuPG: keyserver - pgp.mit.edu

--=-io7TUqJW4cBPAqCKT754
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8AUysXm6Gwek+iaQRAlWOAJ0U756VTZH6RibxgcEtelN8BcSv+wCgmU9e
rE7rGMvmyJDWZcw3Gd/UcyU=
=IbV2
-----END PGP SIGNATURE-----

--=-io7TUqJW4cBPAqCKT754--

