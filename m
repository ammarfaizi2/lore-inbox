Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312154AbSCRAw3>; Sun, 17 Mar 2002 19:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312155AbSCRAwS>; Sun, 17 Mar 2002 19:52:18 -0500
Received: from runyon.sfbay.redhat.com ([205.180.230.5]:50317 "HELO cygnus.com")
	by vger.kernel.org with SMTP id <S312154AbSCRAwE>;
	Sun, 17 Mar 2002 19:52:04 -0500
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
From: Ulrich Drepper <drepper@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Martin Wirth <martin.wirth@dlr.de>, pwaechtler@loewe-komp.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020317175009.4f4954a0.rusty@rustcorp.com.au>
In-Reply-To: <E16m1oK-0006oy-00@wagner.rustcorp.com.au>
	<3C932B2E.90709@dlr.de>  <20020317175009.4f4954a0.rusty@rustcorp.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-fdJzidDxnRI4dc2+4R9y"
X-Mailer: Evolution/1.0.2 (1.0.2-0.7x) 
Date: 17 Mar 2002 16:52:00 -0800
Message-Id: <1016412720.2194.16.camel@myware.mynet>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fdJzidDxnRI4dc2+4R9y
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2002-03-16 at 22:50, Rusty Russell wrote:

> Only vs. pthread_cond_broadcast.

No.  pthread_barrier_wait has the same problem.  It has to wake up lots
of thread.

> And if you're using that you probably
> have some other performance issues anyway?

Why?  Conditional variables are of use in situations with loosely
coupled threads.

--=20
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------

--=-fdJzidDxnRI4dc2+4R9y
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8lTow2ijCOnn/RHQRAhQ9AJ9PbWMT0ULslFt9siVmeNkcrfzxgACbB+6k
cIbNhkrDn5ZCM+PKFVoRwSk=
=edt3
-----END PGP SIGNATURE-----

--=-fdJzidDxnRI4dc2+4R9y--

