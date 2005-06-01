Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVFAV7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVFAV7q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 17:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVFAV46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 17:56:58 -0400
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:45268 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261328AbVFAVyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 17:54:17 -0400
From: Con Kolivas <kernel@kolivas.org>
To: steve.rotolo@ccur.com
Subject: Re: SD_SHARE_CPUPOWER breaks scheduler fairness
Date: Thu, 2 Jun 2005 07:54:44 +1000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, bugsy@ccur.com
References: <1117561608.1439.168.camel@whiz> <1117651285.22879.73.camel@bonefish> <200506020737.20098.kernel@kolivas.org>
In-Reply-To: <200506020737.20098.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1256420.F2rFUJHaWd";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506020754.46419.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1256420.F2rFUJHaWd
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thu, 2 Jun 2005 07:37, Con Kolivas wrote:
> On Thu, 2 Jun 2005 04:41, Steve Rotolo wrote:
> > I guess the bottom-line is: given N logical cpus, 1/N of all
> > SCHED_NORMAL tasks may get stuck on a sibling cpu with no chance to
> > run.  All it takes is one spinning SCHED_FIFO task.  Sounds like a bug.
>
> You're right, and excuse me for missing it.=20

Oh and thanks for picking it up!

Cheers,
Con

--nextPart1256420.F2rFUJHaWd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCni6mZUg7+tp6mRURAmQxAJsH43XDdBKUyg99Iz7lZiCPJadrMwCcC6E0
JpZ2efYqVR/2NJ6JEMAiBow=
=fcKw
-----END PGP SIGNATURE-----

--nextPart1256420.F2rFUJHaWd--
