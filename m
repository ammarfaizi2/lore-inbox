Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbULSBaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbULSBaw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 20:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbULSBaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 20:30:52 -0500
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:51356 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261258AbULSBa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 20:30:29 -0500
Message-ID: <41C4D990.1060507@kolivas.org>
Date: Sun, 19 Dec 2004 12:29:52 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: Mikhail Ramendik <mr@ramendik.ru>, ck@vds.kolivas.org, riel@redhat.com,
       Andrew Morton <akpm@osdl.org>, linux <linux-kernel@vger.kernel.org>
Subject: Re: [ck] 2.6.7 backport request, spinoff idea
References: <200412171504.41234.mr@ramendik.ru> <41C4A670.9090009@kolivas.org> <41C4A899.10102@kolivas.org> <200412190321.16567.mr@ramendik.ru> <41C4CE77.40601@kolivas.org>
In-Reply-To: <41C4CE77.40601@kolivas.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6A1BD1BC968F11B26B53D63E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6A1BD1BC968F11B26B53D63E
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Con Kolivas wrote:
> Mikhail Ramendik wrote:
> 
>> Con Kolivas wrote:
>>
>>
>>> Actually I wonder if the swap token is responsible in 2.6.10-rc3
>>>
>>> Try this
>>> echo 0 > /proc/sys/vm/swap_token_timeout
>>
>>
>>
>> Well, this makes things really better, although not as good as 
>> 2.6.8.1. There are kswapd cpu jumps and screen freezes, but they only 
>> last several seconds (the longest is in the very beginning, about 
>> 15-20 sec).
>>
>> Thanks! This makes the system much more useable.
> 
> 
> This is worth posting to lkml so I've cc'ed a few relevant people (there 
> is already a thread about this there). Rik care to comment? I recall 
> pointing out this test case a while back. Got any way to make it harder 
> to trigger the swap token? It seems to affect normal workloads adversely 
> considering how rare swap thrashing actually occurs.

Rik tells me he has already posted a patch for this problem :D

Sorry for cc'ing the wrong email Rik. Do you have a simple link to the 
patch or can you send it on this thread please?

Cheers,
Con

--------------enig6A1BD1BC968F11B26B53D63E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBxNmQZUg7+tp6mRURAjKRAJ416Pw7U3CfMc7J5WdozNjWO+YbJQCeMyda
jjkkMxN0hOWiS8TlgVtH/Ic=
=D36A
-----END PGP SIGNATURE-----

--------------enig6A1BD1BC968F11B26B53D63E--
