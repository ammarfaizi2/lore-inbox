Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbVLJI6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbVLJI6K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 03:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965089AbVLJI6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 03:58:09 -0500
Received: from wg.technophil.ch ([213.189.149.230]:41650 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S964959AbVLJI6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 03:58:08 -0500
Date: Sat, 10 Dec 2005 09:57:52 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Device files for keyboard(s)?
Message-ID: <20051210085752.GF15679@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yH1ZJFh+qWm+VodA"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yH1ZJFh+qWm+VodA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello dear Kernel-Developers,

I've the problem that I've connected two keyboards
(one via usb and one via ps/2) to my machine and I want to have
different keyboard layout on it.

While I was trying to find out what would be the best way to do that,
I was somehow surprised that keyboards are not presented via
a device file to userspace.

My questions are:

- Is there a reason not to have devices for keyboards?
- If I would implement it into a recent kernel, would it have any chance
  getting into mainline?

I know this would have some consequences for user space, at least those:

- x11 (x.org/xfree) would have to modify their input device section for Lin=
ux
  for keyboards
- loadkeys would have to be patched so one could specify which keyboard
  to change the layout for
- kde/gnome would have to be changed in the manner that they support more
  than one keyboard

Nico

P.S.: Please cc me.

--=20
Latest project: cinit-0.2.1 (http://linux.schottelius.org/cinit/)
Open Source nutures open minds and free, creative developers.

--yH1ZJFh+qWm+VodA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ5qYj7OTBMvCUbrlAQJ9sQ/8CeM6uPLXtONwJ1fgyMhpprv9s4bez/Q8
KkS75XcX9010IF17ujUpppBjv+Y9HDAlr7r/5SjZiFpms4gi96nGyisbCiFnu6RV
dcylmUqRERQN+joM/EJr8ikUeJ5zVQ41Y2JVrqo78qo8En/dP8yi5bgu/a/qVEJC
M6FhODlfJRa2EdhAM0QEVWQSc8PYpz9A15/cts5SBQGa4WQI7NmWWwvafCI9xNdf
WAiEdiJpSRp8ttaapooXRExrKrHAsj8NAXegwv6EzKFvHzaT1xfGNqj2AqpIBpbk
FWo+SyOg5ppAdIs/v/ywfgBO1XZOMZfupiJRWY5P+OBIV7xsXEa/0TJ/hKmT0JMq
lZ8Lt5w36zpzRNIV3efKLUXwZbk088Fniypy+0RDYH7WSzsUhtpqkeVrX1dINeqA
C2M5PNEESAj7uXYQAc7ayOhPaHi6gHYYPcFnZ3yVRbryELnsYO2oYw8qQnvEZ8qe
dsarin2mx8H+6jDBCZnUPM4Mxp6q4SY80U0sBFsXrMCuMaecFGaVm+lhoDURu9Zl
pzpCZY+Wzp3yQoOnPF2f4R/dLLQvaMX1xggBEG3GBC2YO8feLs93zv2kyLyC+QFh
oyiRnx57l79L8zJUAtwydVEQJ52Jk4VZTPDbWoRshU6yZMdpNefvDDjurojh07kP
SsvS2TYATi0=
=mJZx
-----END PGP SIGNATURE-----

--yH1ZJFh+qWm+VodA--
