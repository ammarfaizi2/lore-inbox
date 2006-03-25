Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWCYIuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWCYIuv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 03:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWCYIuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 03:50:51 -0500
Received: from mx1.mm.pl ([217.172.224.151]:7135 "EHLO mx1.mm.pl")
	by vger.kernel.org with ESMTP id S1750714AbWCYIuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 03:50:50 -0500
From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [ck] [benchmark] Interbench 2.6.16-ck/mm
Date: Sat, 25 Mar 2006 09:46:38 +0100
User-Agent: KMail/1.9.1
Cc: ck@vds.kolivas.org,
       "=?utf-8?q?Andr=C3=A9_Goddard?= Rosa" <andre.goddard@gmail.com>,
       linux list <linux-kernel@vger.kernel.org>
References: <200603251351.57341.kernel@kolivas.org> <200603250921.32409.astralstorm@gorzow.mm.pl> <200603251928.39190.kernel@kolivas.org>
In-Reply-To: <200603251928.39190.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3559212.uJkNJLlSQY";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603250946.42867.astralstorm@gorzow.mm.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3559212.uJkNJLlSQY
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 25 March 2006 09:28, Con Kolivas wrote yet:
> On Saturday 25 March 2006 19:21, Radoslaw Szkodzinski wrote:
> > On Saturday 25 March 2006 05:01, Con Kolivas wrote yet:
> > > I don't expect that staircase will be better in every single situatio=
n.
> > > However it will be better more often, especially when it counts (like
> > > audio or video skipping) and far more predictable. All that in 300
> > > lines less code :)
> >
> > I thinks the main difference is those other scheduler improvements.
> > Some of them are compatible with staircase.
> > Could you also try a mixed and matched 2.6.16-ck1+mm?
>
> You're kidding, right? Check the code.

Yes and no. I was kidding about "scheduler improvements" part.
(they're mostly NUMA-only)

But of course memload, read and write latencies aren't necessarily caused b=
y=20
scheduler itself.=20
(burn also reads a file)

The easiest thing to do would be to add staircase to -mm and see what happe=
ns.
It shouldn't be hard to port. (in fact, it may apply cleanly)

=2D-=20
GPG Key id:  0xD1F10BA2
=46ingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm

--nextPart3559212.uJkNJLlSQY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBEJQNylUMEU9HxC6IRAjOgAJ0RUxmIZ2qX658Dn2Vlxv2/5pWT6QCeLEQf
6JFb7IT5nPQEDT6YUfd+n8g=
=PRbc
-----END PGP SIGNATURE-----

--nextPart3559212.uJkNJLlSQY--
