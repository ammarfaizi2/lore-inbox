Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVGLMGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVGLMGh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 08:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVGLME0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 08:04:26 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:49126 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261412AbVGLMCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 08:02:55 -0400
From: Con Kolivas <kernel@kolivas.org>
To: David Lang <david.lang@digitalinsight.com>
Subject: Re: [ANNOUNCE] Interbench v0.20 - Interactivity benchmark
Date: Tue, 12 Jul 2005 22:02:36 +1000
User-Agent: KMail/1.8.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
References: <200507122110.43967.kernel@kolivas.org> <Pine.LNX.4.62.0507120446450.9200@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0507120446450.9200@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart20022987.GAklf6gvqH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507122202.39988.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart20022987.GAklf6gvqH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tue, 12 Jul 2005 21:57, David Lang wrote:
> this looks very interesting, however one thing that looks odd to me in
> this is the thought of comparing the results for significantly different
> hardware.
>
> for some of the loads you really are going to be independant of the speed
> of the hardware (burn, compile, etc will use whatever you have) however
> for others (X, audio, video) saying that they take a specific percentage
> of the cpu doesn't seem right.
>
> if I have a 400MHz cpu each of these will take a much larger percentage of
> the cpu to get the job done then if I have a 4GHz cpu for example.
>
> for audio and video this would seem to be a fairly simple scaleing factor
> (or just doing a fixed amount of work rather then a fixed percentage of
> the CPU worth of work), however for X it is probably much more complicated
> (is the X load really linearly random in how much work it does, or is it
> weighted towards small amounts with occasional large amounts hitting? I
> would guess that at least beyond a certin point the liklyhood of that much
> work being needed would be lower)

Actually I don't disagree. What I mean by hardware changes is more along th=
e=20
lines of changing the hard disk type in the same setup. That's what I mean =
by=20
careful with the benchmarking. Taking the results from an athlon XP and=20
comparing it to an altix is silly for example.

Cheers,
Con

--nextPart20022987.GAklf6gvqH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC07FfZUg7+tp6mRURAtKjAJ4/CF/BC9bWj/Xd8bZAYs9Eftm/lQCfZvCY
fh4E/zl0E0jWyXbkEE/uItw=
=QOr9
-----END PGP SIGNATURE-----

--nextPart20022987.GAklf6gvqH--
