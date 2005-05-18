Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbVERNp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbVERNp7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 09:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVERNp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 09:45:59 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:36783 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262185AbVERNpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 09:45:34 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Markus =?iso-8859-1?q?T=F6rnqvist?= <mjt@nysv.org>
Subject: Re: [SMP NICE] [PATCH] SCHED: Implement nice support across physical cpus on SMP
Date: Wed, 18 May 2005 23:45:19 +1000
User-Agent: KMail/1.8
Cc: Carlos Carvalho <carlos@fisica.ufpr.br>, AndrewMorton <akpm@osdl.org>,
       ck@vds.kolivas.org, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
References: <20050509112446.GZ1399@nysv.org> <17033.62480.218289.246488@fisica.ufpr.br> <20050518113016.GL1399@nysv.org>
In-Reply-To: <20050518113016.GL1399@nysv.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart13000716.aZzGDcd9si";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505182345.22614.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart13000716.aZzGDcd9si
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, 18 May 2005 21:30, Markus T=F6rnqvist wrote:
> On Tue, May 17, 2005 at 10:39:28AM -0300, Carlos Carvalho wrote:
> >That's a pity. What's more important however is that this misfeature
> >of the scheduler should be corrected ASAP. The nice control is a
> >traditional UNIX characteristic and it should have higher priority in
> >the patch inclusion queue than other scheduler improvements.
>
> Linux is not a traditional unix, but it doesn't mean the support
> shouldn't exist.
>
> My suggestion is that whoever broke the interface, rendering
> con's patch which mingo accepted useless, merge the patch.

Unrealistic. We are in a constant state of development, the direction of wh=
ich=20
is determined by who is hacking on what, when - as opposed to "we need this=
=20
feature or fix now so lets direct all our efforts to that". Unfortunately t=
he=20
SMP balancing changes need more than one iteration of a mainline kernel=20
before being incorporated due to the potential for regression so the=20
likelihood of "SMP nice" becoming part of mainline if it is based on this n=
ew=20
code is going to be (at a guess) 6 months. Of course my patch could go into=
=20
mainline in its current form and the SMP balancing code in -mm could be=20
modified with that in place rather than the other way around but I just=20
didn't get in early enough for that to happen ;)

Cheers,
Con

--nextPart13000716.aZzGDcd9si
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCi0byZUg7+tp6mRURAiUrAJ4j8hT38YTzZCJhc0ZzOOBwQtvlagCfYL/Z
BJFaF/m4GvB/mMTWT8346GE=
=ajhy
-----END PGP SIGNATURE-----

--nextPart13000716.aZzGDcd9si--
