Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVFNQnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVFNQnK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 12:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVFNQnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 12:43:09 -0400
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:3542 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261246AbVFNQmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 12:42:09 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Swapping in 2.6.10 and 2.6.11.11 on a desktop system
Date: Wed, 15 Jun 2005 02:42:00 +1000
User-Agent: KMail/1.8.1
Cc: Alexander Gretencord <arutha@gmx.de>
References: <200506141653.32093.arutha@gmx.de>
In-Reply-To: <200506141653.32093.arutha@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1983641.vlfaokoqK0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506150242.02606.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1983641.vlfaokoqK0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 15 Jun 2005 00:53, Alexander Gretencord wrote:
> Hi,
>
> [1] With swappiness = 60 I either get swap hell (2.6.10) or the oom killer
> kicks in (2.6.11.11)
>
> [2] I upgraded to 2.6.11.11 from 2.6.8.1 yesterday and tried to compile
> something. After some time I come back and the compile has aborted because
> the oom killer killed the compiler process. There is no additional use of
> swap space (although some applications that were also running could have
> been swapped out). There was a similar bugreport with this behaviour some
> time ago for 2.6.11.8 but that one included a swappiness value of 0, i got
> 60.

> I have 512MB of RAM and another 512MB of swap.

Try the mapped watermark patch from -ck on 2.6.11*
http://ck.kolivas.org/patches/2.6/2.6.11/2.6.11-ck10/patches/mapped_watermark3.diff

Cheers,
Con

--nextPart1983641.vlfaokoqK0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCrwjaZUg7+tp6mRURAnOTAJ9JGoWpHPJt/YBNF6pU7A5PYpqlSQCfVM9s
9iQlTkSlbu5ibkKHOedUPCw=
=0ghq
-----END PGP SIGNATURE-----

--nextPart1983641.vlfaokoqK0--
