Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267703AbUHEPde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267703AbUHEPde (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 11:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267709AbUHEPde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 11:33:34 -0400
Received: from mail020.syd.optusnet.com.au ([211.29.132.131]:34985 "EHLO
	mail020.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267703AbUHEPda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 11:33:30 -0400
Message-ID: <41125339.6080002@kolivas.org>
Date: Fri, 06 Aug 2004 01:33:13 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Scheduler policies for staircase
References: <34840234.20040804074326@dns.toxicfilms.tv> <cone.1091601947.196990.9775.502@pc.kolivas.org> <1091657248.19988.19.camel@localhost> <1831126609.20040805163204@dns.toxicfilms.tv>
In-Reply-To: <1831126609.20040805163204@dns.toxicfilms.tv>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB3B33A8E508259DF99BAA0DE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB3B33A8E508259DF99BAA0DE
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Maciej Soltysiak wrote:
>>>>Con,
>>>>
>>>>I have been using SCHED_BATCH on two machines now with expected
>>>>results. So this you might consider this as another success report :-)
>>>
>>>Great. Thanks for the report. I too use them all day every day on each
>>>machine I have with distributed computing clients so they're pretty well
>>>tested.
> 
> I forgot to mention about something.
> 
> I totally deadlocked my machine just after setting the
> /proc/sys/kernel/compute to 1 with
> # echo 1 > /proc/sys/kernel/computer
> 
> 
> The machine is 2x1G p3, and the kernel was SMP and I had experimentally
> seti@home running in SCHED_BATCH mode in screen.
> 
> It was 2.6.8-rc1 with ck patches from:
> http://ck.kolivas.org/patches/2.6/2.6.7/2.6.8-rc1/
> 
> I used these patches on 2.6.8-rc1 from it (of course in the proper
> order:
> __cleanup_transaction-latency-fix.patch
> crq-fixes.diff
> defaultcfq.diff
> filemap_sync-latency-fix.patch
> from_2.6.8-rc1_to_staircase7.A

Sorry, those were snapshot patches and not "release" patches. That bug 
was known and fixed in staircase 7.E which was released with 2.6.7-ck6; 
2.6.8-rc2-mm2 did not have that bug either.

Cheers,
Con

--------------enigB3B33A8E508259DF99BAA0DE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBElM8ZUg7+tp6mRURAixrAKCTOhobGHnn03VKpTV2q/GKgLbApwCeIxSL
Ij/r03L1hFd0dTFoiccU3Ng=
=QSHd
-----END PGP SIGNATURE-----

--------------enigB3B33A8E508259DF99BAA0DE--
