Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133083AbRDZDky>; Wed, 25 Apr 2001 23:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133084AbRDZDkp>; Wed, 25 Apr 2001 23:40:45 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:9610 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S133083AbRDZDka>; Wed, 25 Apr 2001 23:40:30 -0400
Date: Wed, 25 Apr 2001 22:39:39 -0500
From: Bob McElrath <rsmcelrath@students.wisc.edu>
To: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: aa's rwsem-generic-6 bug?  Process stuck in 'R' state.
Message-ID: <20010425223939.A26763@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Running 2.4.4pre4 with Andrea's rwsem-generic-6 patch, I have just
gotten a process stuck in the 'R' state.  According to the ps man page
this is: "runnable (on run queue)".  The 'ps aux' output is:
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root      7921  0.8 26.9 91720 68608 ?       R<   00:33  11:20 /usr/X11R6/b=
in/X

X is niced at -10 and doesn't respond to kill or kill -9.

alpha 21164 (ev56) architecture.  kernel compiled with:
gcc version 2.96 20000731 (Red Hat Linux 7.0)

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--huq684BweRXVnRxX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjrnmHsACgkQjwioWRGe9K3YFgCgrSDvyHMD/nOcCyr7PfceVgxf
298AoPnqOrnDPNk/PQjaR9I87gmUGkPy
=/3+3
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
