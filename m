Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271742AbTGRKSI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 06:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271738AbTGRKQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 06:16:53 -0400
Received: from mx02.qsc.de ([213.148.130.14]:59100 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S271736AbTGRKQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 06:16:19 -0400
Date: Fri, 18 Jul 2003 12:31:05 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: Mike Galbraith <efault@gmx.de>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Davide Libenzi <davidel@xmailserver.org>,
       Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] O6int for interactivity
Message-ID: <20030718103105.GE622@gmx.de>
Reply-To: Wiktor Wodecki <wodecki@gmx.net>
References: <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net> <200307170030.25934.kernel@kolivas.org> <200307170030.25934.kernel@kolivas.org> <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net> <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Content-Disposition: inline
In-Reply-To: <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.6.0-test1-mm1-O6 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2003 at 12:18:33PM +0200, Mike Galbraith wrote:
> That _might_ (add salt) be priorities of kernel threads dropping too low.
>=20
> I'm also seeing occasional total stalls under heavy I/O in the order of=
=20
> 10-12 seconds (even the disk stops).  I have no idea if that's something =
in=20
> mm or the scheduler changes though, as I've yet to do any isolation and/o=
r=20
> tinkering.  All I know at this point is that I haven't seen it in stock y=
et.

I've seen this too while doing a huge nfs transfer from a 2.6 machine to
a 2.4 machine (sparc32). Thought it'd be something with the nfs changes
which were recently, might be the scheduler, tho. Ah, and it is fully
reproducable.

--=20
Regards,

Wiktor Wodecki

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/F8xp6SNaNRgsl4MRAjOFAJ9BuVukrdpgXWfazUFh2QjDwYWYNACeLXGd
WF+BECb7xge7gFtf720BN3Y=
=tcYj
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--
