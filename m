Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132611AbRDKPlE>; Wed, 11 Apr 2001 11:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132612AbRDKPkz>; Wed, 11 Apr 2001 11:40:55 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:1664 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S132611AbRDKPkr>; Wed, 11 Apr 2001 11:40:47 -0400
Date: Wed, 11 Apr 2001 10:40:40 -0500
From: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
To: linux-kernel@vger.kernel.org
Subject: Alpha "process table hang"
Message-ID: <20010411104040.A8773@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've been experiencing a particular kind of hang for many versions
(since 2.3.99 days, recently seen with 2.4.1, 2.4.2, and 2.4.2-ac4) on
the alpha architecture.  The symptom is that any program that tries to
access the process table will hang. (ps, w, top) The hang will go away
by itself after ~10minutes - 1 hour or so.  When it hangs I run ps and
see that it gets halfway through the process list and hangs.  The
process that comes next in the list (after hang goes away) almost always
has nonsensical memory numbers, like multi-gigabyte SIZE.

Linux draal.physics.wisc.edu 2.3.99-pre5 #8 Sun Apr 23 16:21:48 CDT 2000
alpha unknown

Gnu C                  2.96
Gnu make               3.78.1
binutils               2.10.0.18
util-linux             2.11a
modutils               2.4.5
e2fsprogs              1.18
PPP                    2.3.11
Linux C Library        2.2.1
Dynamic linker (ldd)   2.2.1
Procps                 2.0.7
Net-tools              1.54
Kbd                    0.94
Sh-utils               2.0
Modules Loaded         nfsd lockd sunrpc af_packet msdos fat pas2 sound
soundcore

Has anyone else seen this?  Is there a fix?

-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjrUevgACgkQjwioWRGe9K10TgCglv95V7KZlSzTQuLQJy7NgmuY
hjUAoN0YGFYUjCS163dgtghN6egcKsUS
=HtoO
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
