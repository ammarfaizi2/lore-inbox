Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273204AbRJFGFF>; Sat, 6 Oct 2001 02:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275037AbRJFGEz>; Sat, 6 Oct 2001 02:04:55 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:26752 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S275014AbRJFGEv>; Sat, 6 Oct 2001 02:04:51 -0400
Date: Sat, 6 Oct 2001 01:05:19 -0500
From: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
To: linux-kernel@vger.kernel.org
Subject: low-latency patches
Message-ID: <20011006010519.A749@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It seems there are two low-latency projects out there.  The one by Robert L=
ove:
    http://tech9.net/rml/linux/
and the original one:
    http://www.uow.edu.au/~andrewm/linux/schedlat.html

Correct me if I'm wrong, but the former uses spinlocks to know when it can
preempt the kernel, and the latter just tries to reduce latency by adding
(un)conditional_schedule and placing it at key places in the kernel?

My questions are:
1) Which of these two projects has better latency performance?  Has anyone
    benchmarked them against each other?
2) Will either of these ever be merged into Linus' kernel (2.5?)
3) Is there a possibility that either of these will make it to non-x86
    platforms?  (for me: alpha)  The second patch looks like it would
    straightforwardly work on any arch, but the config.in for it is only in
    arch/i386.  Robert Love's patches would need some arch-specific asm...

Thanks,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAju+nx8ACgkQjwioWRGe9K2/DACcDo9Lgiu1FHD+ks2CzkCwTxpX
qlYAnicWli1aIJ5bEKqrE5SxTXy7A8Kk
=9e5x
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
