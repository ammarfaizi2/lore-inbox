Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270674AbUJUKYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270674AbUJUKYq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 06:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270538AbUJUKX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 06:23:27 -0400
Received: from pop.gmx.de ([213.165.64.20]:9128 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S270484AbUJUKVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 06:21:04 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
Date: Thu, 21 Oct 2004 12:24:54 +0200
User-Agent: KMail/1.7
Cc: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Rodland <arodland@entermail.net>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <200410171946.33472.dominik.karall@gmx.net> <87ekjw65x9.fsf@ibmpc.myhome.or.jp>
In-Reply-To: <87ekjw65x9.fsf@ibmpc.myhome.or.jp>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1114629.MlHvlALnsd";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200410211224.57951.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1114629.MlHvlALnsd
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 18 October 2004 05:50, OGAWA Hirofumi wrote:
> Dominik Karall <dominik.karall@gmx.net> writes:
> > yes, the bug only occurs on a specific file.
> > as the bug is present in -mm1 (without vp) too, i applied your patch to
> > that one. here is the output:
> >
> > fat_cache_check: id 0, contig 6415, fclus 38231, dclus 1010103
> > contig 6416, fclus 38231, dclus 1010103
> > contig 0, fclus 32, dclus 603964
> > contig 1, fclus 30, dclus 603960
> > contig 7, fclus 22, dclus 603950
> > contig 4, fclus 17, dclus 603943
> > contig 1, fclus 15, dclus 603940
> > contig 6, fclus 8, dclus 603931
> > contig 0, fclus 7, dclus 603929
>
> Thanks. Seems good. There is no inconsistency in cache.
>
> > and the movie starts to play in mplayer without problems. tell me if
> > you need more debugging!
>
> Can you please try the patch again? This patch should tell who added
> the cache.
>
> Thanks.

sorry, but i can't reproduce the bug again. even after a reboot the file wo=
rks=20
as normal. but i didn't changed anything on the file.
if the bug appears again, i will apply the patch and let you know!

best regards,
dominik

--nextPart1114629.MlHvlALnsd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQCVAwUAQXeOeQvcoSHvsHMnAQKClAQAiu5U1seV23jVJPcVcEZmtneNkRX/kAXH
90P8WNJpnnCiCBn0XRbVJjX9Q9ixVhMqkTWoJ9Go7fLp2ygqoiOV7wrASbHXBdV6
MY9SLIsUPdT1YfZEthSvVwK4Y3iMGpWTgjro9mpAS8NZFcyUmtNLxyDNb1jMyxmS
kcEuMK9oSoQ=
=QRcu
-----END PGP SIGNATURE-----

--nextPart1114629.MlHvlALnsd--
