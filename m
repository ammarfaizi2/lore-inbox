Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265655AbUA1ISz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 03:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265806AbUA1ISz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 03:18:55 -0500
Received: from adsl-67-124-158-125.dsl.pltn13.pacbell.net ([67.124.158.125]:23730
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S265655AbUA1ISx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 03:18:53 -0500
Date: Wed, 28 Jan 2004 00:18:51 -0800
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: ALSA noise (was: Re: 2.6.2-rc2-mm1)
Message-ID: <20040128081851.GA11391@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20040127233402.6f5d3497.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <20040127233402.6f5d3497.akpm@osdl.org>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2004 at 11:34:02PM -0800, Andrew Morton wrote:
> - Various fixes.  Nothing stands out.

This doesn't have quite as much to do with -mm as it probably should,
but this high pitched noise + random static on ALSA playback happens
on all of my machines that use intel8x0 PAST 2.6.1-rc1-mm2. (That is,
2.6.1-rc2 stock has the bug, onwards until this release 2.6.2-rc2-mm1.)

As I've repeated a few times on a few threads on LKML, this involves:
1) a high pitched whining type noise when the system is *NOT* under load
   which goes away if the CPU usage is at ~100%.
2) lots of annoying pops of static during wave playback (hurts my ears.)

I'm not so bold as to try to figure what changed between 2.6.1-rc1-mm2
and 2.6.1-rc2 stock that could have caused this. Can anyone offer
pointers on how to tackle this bug? I don't wish to be stuck with such
an old kernel in the heat of 2.6 stable release development :)

Hoping for a quick resolution for this bug. Other people have noticed it
as well...

--=20
Joshua Kwan

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQIVAwUBQBdwaqOILr94RG8mAQJ7KQ/9GllCf0XBvPtjN6G4/h6PU6zQcjT967XS
BcvQ12M2f7Ov43nzKIkZOdf2prC6xk8xtlbl5mFcimeSl2I3T/SbnjfBLxFeuUHW
Me/EJauG/my0bHDAJioln6TtW4PKrVyF7msc4NKj6eNbkxGYvrNIXHrS6zIz9MCt
x3S46uebLQA8Cw5KAMsuxCLqP1gr8RXlZf/6gbt+w/4nmuUb1lU9oovm2sZBkN+c
vPTmdpjqYgeFesO3BT3nfQlw9dR6nspCUNgelkoUWMR/82V4AEAPSBGrGkncU1z1
a6T2nDkMnk4XZaBUFSPRc3eKU8URT7a0Dxc5EknSu+S9EL2/1gqqpNzJvt0ko+Ei
K5MWglFiaM1pJ6I/JHGj0u5AZNYRehwUoqux8/wCv2o5nSUu7FT/V3jBCgJ7VpTQ
ddYbLZkULFPqEEGDSd5mBJw2dxcKBySv6oXJfZ3piJiTM+0ofU/xTRsrKIB8F17P
jDpzWFBshqDOTwkSnBn1KMXDN/vLW9oL8Z7nzbC0dvN412oGvDY8f9tYDuCP8Tl6
Ub5wVFpGg7rnUHtmWlQ9E9ExsDflHzR3oGZaQofhpm7OlAVtftOVWtgPWG393odx
gM5jN03VmOQ2n1glyTuvoFpqoXtRvh6rvC+UiTHrcsx4vdhUMdAWVhA4wTejRp0k
4v7dQIPn7qk=
=ETGT
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
