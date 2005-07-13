Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVGNAB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVGNAB6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 20:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbVGMX7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 19:59:12 -0400
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:63685 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262844AbVGMX6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 19:58:10 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [ANNOUNCE] Interbench v0.20 - Interactivity benchmark
Date: Thu, 14 Jul 2005 09:57:58 +1000
User-Agent: KMail/1.8.1
Cc: szonyi calin <caszonyi@yahoo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>, caszonyi@rdslink.ro
References: <20050713112710.60204.qmail@web52902.mail.yahoo.com> <1121276077.4435.50.camel@mindpipe>
In-Reply-To: <1121276077.4435.50.camel@mindpipe>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart17802920.lr4cfdX63Z";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507140958.00510.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart17802920.lr4cfdX63Z
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 14 Jul 2005 03:34, Lee Revell wrote:
> On Wed, 2005-07-13 at 13:27 +0200, szonyi calin wrote:
> > I have the following problem with audio:
> > Xmms is running with threads for audio and spectrum
> > analyzer(OpenGL).
> > The audio eats 5% cpu, the spectrum analyzer about 80 %. The
> > problem is that sometimes the spectrum analyzer is eating all of
> > the cpu while the audio is skipping. Xmms is version 1.2.10
> > kernel is vanilla, latest "stable" version 2.6.12, suid root.
> >
> > Does your benchmark simultes this kind of behaviour ?
>
> That's just a broken app, the kernel can't do anything about it.  XMMS
> should not be running the spectrum analyzer thread at such a high
> priority as to interfere with the audio thread.

I agree; optimising for this is just silly.

Cheers,
Con

--nextPart17802920.lr4cfdX63Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD4DBQBC1aqIZUg7+tp6mRURAuDfAJ96n/h6e8aZtWAml2V0BM6VHbTBxwCY51Xl
KTRg9uKxlOJX4xiaSRsvgQ==
=3wNY
-----END PGP SIGNATURE-----

--nextPart17802920.lr4cfdX63Z--
