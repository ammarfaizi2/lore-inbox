Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275912AbSIUNhB>; Sat, 21 Sep 2002 09:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275913AbSIUNhB>; Sat, 21 Sep 2002 09:37:01 -0400
Received: from florin.dsl.visi.com ([209.98.146.184]:34631 "EHLO
	bird.iucha.org") by vger.kernel.org with ESMTP id <S275912AbSIUNhA>;
	Sat, 21 Sep 2002 09:37:00 -0400
Date: Sat, 21 Sep 2002 08:41:59 -0500
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.37 won't run X?
Message-ID: <20020921134159.GA6203@iucha.net>
Mail-Followup-To: Helge Hafting <helgehaf@aitel.hist.no>,
	linux-kernel@vger.kernel.org
References: <20020921121041.C20153@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20020921121041.C20153@hh.idb.hist.no>
User-Agent: Mutt/1.4i
X-message-flag: Outlook: Where do you want [your files] to go today?
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2002 at 12:10:41PM +0200, Helge Hafting wrote:
> X won't start on 2.5.37, but works with 2.5.36
> The screen goes black as usual, but then nothing else happens.
> ssh'ing in from another machine shows XFree86 using 50% cpu,
> i.e. one of the two cpu's in this machine.
>=20
> killing the XFre86 process is impossible, even with kill -9
> from root. sysrq SAK worked though, so I could recover
> the machine.  But I had to boot a different kernel to run X.
>=20
> lspci
> 00:0f.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01)
>=20
> 2.5.37 SMP kernel
>=20
> XFree86 Version 4.1.0.1 / X Window System
> (protocol Version 11, revision 0, vendor release 6510)
> Release Date: 21 December 2001
>=20
> Distribution debian testing
>=20
> Helge Hafting

I get the same behavior on two machines here (a desktop with Duron/SIS 735
chipset/ATI 8500 video and a laptop with PIII/BX chipset/S3 Savage MX video)
so it is not hardware specific.

I am running debian testing, the laptop has XFree 4.1.0 from debian, the
desktop has XFree 4.2.0 from xfree.org .

I am not runnning SMP or preempt. Preempt kernel on the laptop last
worked in 2.5.33 . When enabling preempt in 2.5.36 I get an oops, while
in 2.5.37 I get a bunch of oopses, continuously scrolling off the
screen.

florin

--=20

"If it's not broken, let's fix it till it is."

41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9jHcmNLPgdTuQ3+QRAkHvAJ4uwkL3eG7PlobMhYNy2NsAJOIjBgCfR0yg
s3/jZt8WlMGW9hlndEIXNL0=
=cBT2
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
