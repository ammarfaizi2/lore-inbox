Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269182AbUJFKAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269182AbUJFKAa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 06:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269183AbUJFKAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 06:00:30 -0400
Received: from mx.laposte.net ([81.255.54.11]:49405 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S269182AbUJFJ6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 05:58:38 -0400
Subject: Preempt? (was Re: Cannot enable DMA on SATA drive (SCSI-libsata,
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-bNortN9EdfgmYGrvsJYI"
Organization: Adresse personnelle
Date: Wed, 06 Oct 2004 11:58:31 +0200
Message-Id: <1097056711.16116.33.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 (2.0.1-2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bNortN9EdfgmYGrvsJYI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

    Jeff> I strongly recommend disabling kernel preemption.  It is a
    Jeff> hack that hides bugs.

ROTFL. Given than the whole rationale for RedHat developing voluntary-
preempt and not enabling preempt itself in their kernels was preempt
aggressively exposed bugs you could somehow live with most of the times
in prod without preempt I find this argument hilarious (and if I
remember well Linus made the same argument, only he wanted the bugs to
be exposed to recommended preempt for testers).

    Jeff> If all code paths in the kernel were low latency, then you=20
    Jeff> would not need preempt at all.

Sure, and if the whole kernel was written in hand-tuned assembly you
would not need gcc at all. The point of software tools like preempt is
not you could do the same work manually but that they free developer
time for things that can not be automated.

   Jeff> If users and developers are presented with the _impression_
   Jeff> that long latency code paths don't exist, then nobody is
   Jeff> motivated to profile them (with any tool), much less fix them.

I'll take a system that gives the _impression_ that it always works well
over a system that proves it works well on paper all the time. Linux got
where it is because it cared about field impressions, unlike some
research OSs.

   Jeff> Preempt will always be something I ask people to turn off when
   Jeff> reporting driver bugs; it just adds too much complicated mess
   Jeff> for zero gain.

And this is the real argument. It sure took a long time to come out.

This is not to flame anybody - I'm a kernel nobody and have no right to
do it. Just to point out even a bystander like me can feel the weakness
of some of the arguments advanced against preempt in this thread. (I
almost wrote bad faith arguments here but sometimes you get so involved
into something you don't realise the arguments you choose to advance
lack rationale if not emotion).

Jeff, if you cool down a bit I'm sure you can back your position a bit
better than this. You won't sell it by telling preempt users they hide
problems that won't affect them (only !preempt users), that they'll get
the impression of a better system, or that they'll get the same/better
result someday once someone takes the time to fix countless drivers.

Regards,

--=20
Nicolas Mailhot

--=-bNortN9EdfgmYGrvsJYI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBY8HHI2bVKDsp8g0RAsNYAKDNhhLd8i5gNyHl6ApwihxX50iU2gCg9KZr
Zix0Xtx24qT0+dNEn+8YXUM=
=Ryfa
-----END PGP SIGNATURE-----

--=-bNortN9EdfgmYGrvsJYI--

