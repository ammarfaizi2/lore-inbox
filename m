Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265495AbUF2G0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265495AbUF2G0M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 02:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265499AbUF2G0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 02:26:12 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:2974 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S265495AbUF2G0F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 02:26:05 -0400
Subject: Re: Nice 19 process still gets some CPU
From: =?ISO-8859-1?Q?Beno=EEt?= Dejean <TazForEver@free.fr>
Reply-To: TazForEver@dlfp.org
To: Timothy Miller <miller@techsource.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <40E035CE.1020401@techsource.com>
References: <40E035CE.1020401@techsource.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VIPdQYevXtigeBPDgUNU"
Date: Tue, 29 Jun 2004 08:26:03 +0200
Message-Id: <1088490363.4613.13.camel@athlon>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VIPdQYevXtigeBPDgUNU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Le lun, 28/06/2004 =C3=A0 11:14 -0400, Timothy Miller a =C3=A9crit :

> I would expect that nice 0 processes should get SO MUCH more than nice=20
> 19 processes that the nice 19 process would practically starve (and in=20
> the case of a nice 19 process, I think starvation by nice 0 processes is=20
> just fine), but it looks like it's not starving.

	when i was running seti@home (more than 10k WU, 7y), i was using a a
home-maid script that controled the seti process. when load > <value> i
was stopping seti (SIGSTOP) then, when load <value>, i was restarting it
(SIGCONT). i was using a kind of fuzzy logic to prevent from too
frequent switchs and i was polling the 3 loads to make a efficient
decision. that way, i was able to get 100% of my cpu when it was
needed : while playing quake or comipiling a big stuff.

--=20
Beno=C3=AEt Dejean
JID: TazForEver@jabber.org
http://gdesklets.gnomedesktop.org
http://www.paulla.asso.fr

--=-VIPdQYevXtigeBPDgUNU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA4Qt7liyxJIUSPQoRAkzQAJ9SwGkNRotRql9DOvYPqsxTuXLxQQCglWtr
9U6hPj4fFTBf+ZVVGW7Vd4M=
=FHp2
-----END PGP SIGNATURE-----

--=-VIPdQYevXtigeBPDgUNU--

