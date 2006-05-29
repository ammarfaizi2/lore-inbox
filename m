Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWE2PfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWE2PfM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 11:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWE2PfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 11:35:12 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:22693 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751059AbWE2PfK (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 11:35:10 -0400
Message-Id: <200605291535.k4TFZ0VP003544@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: =?iso-8859-2?Q?Haar_J=E1nos?= <djani22@netcenter.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: How to send a break?
In-Reply-To: Your message of "Mon, 29 May 2006 11:08:15 EDT."
             <Pine.LNX.4.61.0605291105550.21358@chaos.analogic.com>
From: Valdis.Kletnieks@vt.edu
References: <01b701c6818d$4bcd37b0$1800a8c0@dcccs>
            <Pine.LNX.4.61.0605291105550.21358@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1148916899_3031P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 29 May 2006 11:35:00 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1148916899_3031P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 29 May 2006 11:08:15 EDT, =22linux-os (Dick Johnson)=22 said:
>=20
> On Sat, 27 May 2006, =5Biso-8859-2=5D Haar J=E1nos wrote:
>=20
> > Hello, list,
> >
> > I wish to know, how to send a =22BREAK=22 to trigger the sysreq funct=
ions on the
> > serial line, using echo.
> >
> > I mean like this:
> >
> > =23=21/bin/bash
> > echo =22?BREAK?=22 >/dev/ttyS0
> > sleep 2
> > echo =22m=22 >/dev/ttyS0
> >
> > Thanks,
> > Janos
> >
>=20
> Can't you use /proc/sysrq-trigger?

That can be tricky if the other end of /dev/ttyS0 is plugged into a debug=
ging
serial port on an embedded system where you don't have easy access to a s=
hell.

Or for that matter, if you're trying to talk to the serial port on a non-=
embedded
system, which is too far into OOM thrashing for you to be able to get a
usable shell prompt.....

--==_Exmh_1148916899_3031P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEexSjcC3lWbTT17ARAiBJAKCbm57XLXb3bRD/ok50jDW+yu+ycACeOwDh
w9NQ6osNSpYEP/mNlKfF6q8=
=wukj
-----END PGP SIGNATURE-----

--==_Exmh_1148916899_3031P--
