Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266004AbUGJApr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266004AbUGJApr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 20:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266038AbUGJApr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 20:45:47 -0400
Received: from mail022.syd.optusnet.com.au ([211.29.132.100]:38602 "EHLO
	mail022.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266048AbUGJApa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 20:45:30 -0400
Message-ID: <40EF3C1C.6080206@kolivas.org>
Date: Sat, 10 Jul 2004 10:45:16 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <piggin@cyberone.com.au>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Likelihood of rt_tasks
References: <40EE6CC2.8070001@kolivas.org> <40EF2FF2.6000001@bigpond.net.au> <40EF354F.9090903@kolivas.org> <40EF3B3D.9080908@bigpond.net.au>
In-Reply-To: <40EF3B3D.9080908@bigpond.net.au>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3DCA5A60149C51E464E75860"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3DCA5A60149C51E464E75860
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Peter Williams wrote:
> Con Kolivas wrote:
>> - and hitting it frequently enough will be washed over by the cpu as 
>> Ingo said. I dont think the order of magnitude of this change is in 
>> the same universe as the problem of scheduling latency that people are 
>> complaining of.
> 
> 
> They are talking very small times.

No I think you'll find some people are getting jitter and occasional 
latencies up to 50ms with rt tasks, as evidenced by Ingo's own testing. 
The problem is bigger than we'd like. Unlikely() would be pushing at 
worst not even microsecond differences.

Con

--------------enig3DCA5A60149C51E464E75860
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA7zwcZUg7+tp6mRURAvSzAJsHC0bA1nMl3edKuO/OEYGUrSUYvgCeP4hh
b1KC7IYcDuR5SQwPlqNFcvU=
=Yv/L
-----END PGP SIGNATURE-----

--------------enig3DCA5A60149C51E464E75860--
