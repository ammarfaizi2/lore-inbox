Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266848AbUGLO1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266848AbUGLO1z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 10:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266851AbUGLO1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 10:27:54 -0400
Received: from mail003.syd.optusnet.com.au ([211.29.132.144]:19341 "EHLO
	mail003.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266848AbUGLO1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 10:27:45 -0400
Message-ID: <40F29FCF.3070302@kolivas.org>
Date: Tue, 13 Jul 2004 00:27:27 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Instrumenting high latency
References: <cone.1089613755.742689.28499.502@pc.kolivas.org> <75270000.1089642258@[10.10.2.4]>
In-Reply-To: <75270000.1089642258@[10.10.2.4]>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig69C2144141E9E79376296BB7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig69C2144141E9E79376296BB7
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Martin J. Bligh wrote:
>>Because of the recent discussion about latency in the kernel I asked 
>>William Lee Irwin III to help create some instrumentation to determine 
>>where in the kernel there were still sustained periods of non-preemptible 
>>code. He hacked together this simple patch which times periods according 
>>to the preempt count. Hopefully we can use this patch in the advice of 
>>Linus to avoid the "mental masturbation" at guessing where latency is 
>>and track down real problem areas.
> 
> 
> Is this much different from Rick's schedstat's work, which was itself based
> on some earlier patches by Bill? I'd hate to end up with two sets of patches,
> and schedstats seemed pretty comprehensive to me. He's on vacation, but his
> stuff is here, if you want to take a look:
> 
> http://eaglet.rain.com/rick/linux/schedstats/

No I remember his work and this is tackling it via a different area if I 
recall correctly. He was looking at scheduler latencies as opposed to 
non-preemptible kernel code.

Con

--------------enig69C2144141E9E79376296BB7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA8p/SZUg7+tp6mRURAjg1AJ4qnmDXtG0oDTFs0DGmGueRVb78dACeKIgM
vq9mQEouK5EJL8ltAfeIzYU=
=4XDn
-----END PGP SIGNATURE-----

--------------enig69C2144141E9E79376296BB7--
