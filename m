Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTEUM7T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 08:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbTEUM7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 08:59:19 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:63983 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262063AbTEUM7S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 08:59:18 -0400
Subject: Re: [Linux-ia64] Re: web page on O(1) scheduler
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Duraid Madina <duraid@octopus.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3ECB57A4.1010804@octopus.com.au>
References: <16075.8557.309002.866895@napali.hpl.hp.com>
	 <1053507692.1301.1.camel@laptop.fenrus.com>
	 <3ECB57A4.1010804@octopus.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wqNv0fddgTcRxZIjZUQF"
Organization: Red Hat, Inc.
Message-Id: <1053522732.1301.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 21 May 2003 15:12:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wqNv0fddgTcRxZIjZUQF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-05-21 at 12:40, Duraid Madina wrote:
> Dear Arjan,
>=20
>=20
>        ///////
>        //    O
>       //      >                                    This is a graduate
>        / \__ ~                                     student, laboratory
>          ||                            /////       assistant, automotive
>        (\ \)   (~)                    //  o   <--- engineer or other
>        ( \ \  / /                    //    >       unfortunate soul
>        (  \ \/ /         ____________/ \__O        attempting to get
>        (   \__/         /  ___ ______\//           performance out of a
>        /   | /@        (  /  / ______)/            machine running Linux
>       (    |//          \ \ / /   (_)              by writing a simple
>        \   ()            \ \O/                     and correct
>         \  |              ) )                      multithreaded program.
>          ) )             / /
>         (  |_           / /_
>         (____>         (____>
>=20
>            ^
>            |
>            |
>            |
>            |
>=20
>       This is you.
>=20
>=20

if you had spent the time you spent on this colorful graphic on reading
SUS or Posix about what sched_yield() means, you would actually have
learned something. sched_yield() means "I'm the least important thing in
the system". It's the wrong thing for cross-cpu spinlocks; futexes are
optimal for that. For letting higher priority tasks run a sleep(0) is
also far more closer to the right behavior than a sched_yield().


--=-wqNv0fddgTcRxZIjZUQF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+y3ssxULwo51rQBIRAgyKAJ9n0t2mBSmeUqrzxyzIldiEUJCZAQCfec2z
Y03qbLDK8Y8rOoU7/dV+sLo=
=ugqy
-----END PGP SIGNATURE-----

--=-wqNv0fddgTcRxZIjZUQF--
