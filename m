Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262947AbVG3Ag0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262947AbVG3Ag0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262832AbVG3Adk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 20:33:40 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:16063 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262825AbVG3Aci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 20:32:38 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: i387 floating-point test program/benchmark
Date: Sat, 30 Jul 2005 10:32:25 +1000
User-Agent: KMail/1.8.1
Cc: Puneet Vyas <vyas.puneet@gmail.com>,
       Chuck Ebbert <76306.1226@compuserve.com>
References: <200507291639_MC3-1-A5E6-856D@compuserve.com> <42EAC686.5060604@gmail.com>
In-Reply-To: <42EAC686.5060604@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1455904.pRnOOKj1SB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507301032.28253.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1455904.pRnOOKj1SB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sat, 30 Jul 2005 10:15, Puneet Vyas wrote:
> Chuck Ebbert wrote:
> >/* fp.c: i387 benchmark/test program */
>
> [puneet@localhost C]$ cc FPUtest.c -o FPUtest
>
> FPUtest.c: In function `main':
>
> FPUtest.c:103: warning: passing arg 2 of `sched_setaffinity' makes
> integer from pointer without a cast
>
> FPUtest.c:103: error: too few arguments to function `sched_setaffinity'

There are half a dozen different versions of sched_setaffinity in glibc and=
=20
they vary in argument type and even argument number across architectures.

Cheers,
Con

--nextPart1455904.pRnOOKj1SB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC6sqcZUg7+tp6mRURAvRSAJ9lA6VY2qnXdz/FIuo37e4o/7t+cACdF3G+
TvyIPo0BrjwnmoqgnjovUnc=
=JmsB
-----END PGP SIGNATURE-----

--nextPart1455904.pRnOOKj1SB--
