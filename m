Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265692AbUGJQSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265692AbUGJQSq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 12:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265789AbUGJQSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 12:18:46 -0400
Received: from mail001.syd.optusnet.com.au ([211.29.132.142]:32898 "EHLO
	mail001.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265692AbUGJQSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 12:18:44 -0400
Message-ID: <40F016D9.8070300@kolivas.org>
Date: Sun, 11 Jul 2004 02:18:33 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: ck kernel mailing list <ck@vds.kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org> <20040710124814.GA27345@elte.hu> <40F0075C.2070607@kolivas.org>
In-Reply-To: <40F0075C.2070607@kolivas.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig781F0FF94E94B8AA84B38746"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig781F0FF94E94B8AA84B38746
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Con Kolivas wrote:
> I've conducted some of the old fashioned Benno's latency test on this 
> patch in various sysctl configurations. This was done on top of a 
> different tree but everything else was kept static. I have to preface 
> these results by saying I don't really get the 50ms size latencies 
> normally but I'm usually unable to get better than 3ms so I wasn't sure 
> what to expect.
> 
> Only the both preempt off showed any "outlying" results with one spike 
> of ~20ms but the rest of the time being ~3ms. Enabling both forms of 
> preempt seemed to help a little but nothing drastic, and never below 
> 1ms. It was not universal that the latencies were better, but there was 
> a trend towards better latency. I suspect that those who are getting 
> huge latencies may see a bigger change with this patch than I did.
> 
> http://ck.kolivas.org/latency/
> 
> Con


Ooops forgot to mention this was running reiserFS 3.6 on software raid0 
2x IDE with cfq elevator.

Con

--------------enig781F0FF94E94B8AA84B38746
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA8BbbZUg7+tp6mRURAiJFAJ91HSd22Q8acctC3+mMBSW9zyAEAACcDWNG
wFSo3KbA2e/RpvmAUeiGWbk=
=YwDv
-----END PGP SIGNATURE-----

--------------enig781F0FF94E94B8AA84B38746--
