Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbUBHQMV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 11:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbUBHQMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 11:12:21 -0500
Received: from [193.230.220.21] ([193.230.220.21]:7149 "EHLO MailBox.iNES.RO")
	by vger.kernel.org with ESMTP id S263834AbUBHQMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 11:12:18 -0500
Subject: Re: cpufreq - less possible freqs with 2.6.2 and P4M
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
To: Georg =?ISO-8859-1?Q?M=FCller?= <georgmueller@gmx.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <402656CB.7070701@gmx.net>
References: <402562D4.7010706@gmx.net> <yw1xd68q4h05.fsf@kth.se>
	 <402656CB.7070701@gmx.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fIQSU9FLvizjk/SktRZd"
Organization: iNES Group
Message-Id: <1076256735.1840.8.camel@LNX.iNES.RO>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.3 (1.5.3-1) 
Date: Sun, 08 Feb 2004 18:12:15 +0200
X-RAVMilter-Version: 8.4.1(snapshot 20020919) (MailBox.iNES.RO)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fIQSU9FLvizjk/SktRZd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-02-08 at 16:33 +0100, Georg M=C3=BCller wrote:
> M=C3=A5ns Rullg=C3=A5rd wrote:
> > Which cpufreq module are you using?  With p4-clockmod I get lots of
> > choices, with acpi only the two you mentioned.
> >=20
>=20
> Ok, that works. With P4 clockmod only there are the freqs I wanted :-)

But I don't know it's having the effect you desire... :)

By monitoring /proc/acpi/battery/*/state ("present rate" key) I found
that by using p4-clockmod at the lovest rate the processor permits, it's
actually using more energy than by using speedstep_ich (only two levels
of frequency).

I don't know if this is a bug of p4-clockmod or a hw bug in my machine
though... can you please check in your machine?

--=20
Cioby


--=-fIQSU9FLvizjk/SktRZd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAJl/fQisRnSkd59cRAmyJAJsFxP5CpiZ3QmkMOBmZqdak+Zw3AQCfdbIH
9/OyrQaJRolJGGzsk1OgPt8=
=pmkt
-----END PGP SIGNATURE-----

--=-fIQSU9FLvizjk/SktRZd--

