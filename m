Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVAWB5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVAWB5h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 20:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVAWB5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 20:57:37 -0500
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:45535 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261155AbVAWB5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 20:57:32 -0500
Message-ID: <41F3046A.1050808@kolivas.org>
Date: Sun, 23 Jan 2005 12:56:58 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: "Jack O'Quin" <joq@io.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       linux <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
References: <200501230141.j0N1fOAB022422@localhost.localdomain>
In-Reply-To: <200501230141.j0N1fOAB022422@localhost.localdomain>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5C6DBCC8FA73E3531F0F45AA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5C6DBCC8FA73E3531F0F45AA
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Paul Davis wrote:
>>The idea is to get equivalent performance to SCHED_FIFO. The results 
>>show that much, and it is 100 times better than unprivileged 
>>SCHED_NORMAL. The fact that this is an unoptimised normal desktop 
>>environment means that the conclusion we _can_ draw is that SCHED_ISO is 
>>as good as SCHED_FIFO for audio on the average desktop. I need someone 
> 
> 
> no, this isn't true. the performance you are getting isn't as good as
> SCHED_FIFO on a tuned system (h/w and s/w). the difference might be
> the fact that you have "an average desktop", or it might be that your
> desktop is just fine and SCHED_ISO actually is not as good as
> SCHED_FIFO. 

<pedantic mode>
On my desktop, whatever that is, SCHED_FIFO and SCHED_ISO results were 
the same.
</pedantic mode>

> 
>>with optimised hardware setup to see if it's as good as SCHED_FIFO in 
>>the critical setup.
> 
> 
> agreed. i have every confidence that Lee and/or Jack will be
> forthcoming :)

Good stuff :).

Meanwhile, I have the priority support working (but not bug free), and 
the preliminary results suggest that the results are better. Do I recall 
someone mentioning jackd uses threads at different priority?

Cheers,
Con

P.S. If you read any emotion in my emails without a smiley or frowny 
face it's unintentional and is the limited emotional range the email 
format is allowed to convey. Hmm.. perhaps I should make this my sig ;)

--------------enig5C6DBCC8FA73E3531F0F45AA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8wRqZUg7+tp6mRURAos/AJ0Spf4h/NhQiCMKVltyqyZ1WZoU/wCfVD3a
bpqsYZBMUMP8U1lpKJhve+0=
=oE6k
-----END PGP SIGNATURE-----

--------------enig5C6DBCC8FA73E3531F0F45AA--
