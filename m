Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbUJaXi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbUJaXi0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 18:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbUJaXi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 18:38:26 -0500
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:24194 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261697AbUJaXiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 18:38:12 -0500
Message-ID: <41857745.6020808@kolivas.org>
Date: Mon, 01 Nov 2004 10:37:41 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH][plugsched 0/28] Pluggable cpu scheduler framework
References: <4183A602.7090403@kolivas.org> <20041031233313.GB6909@elf.ucw.cz>
In-Reply-To: <20041031233313.GB6909@elf.ucw.cz>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5FBA24471E0AF9965D7B1DB2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5FBA24471E0AF9965D7B1DB2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Pavel Machek wrote:
> Hi!
> 
> 
>>This code was designed to touch the least number of files, be completely
>>arch-independant, and allow extra schedulers to be coded in by only
>>touching Kconfig, scheduler.c and scheduler.h. It should incur no
>>overhead when run and will allow you to compile in only the scheduler(s)
>>you desire. This allows, for example, embedded hardware to have a tiny
>>new scheduler that takes up minimal code space.
> 
> 
> You are changing 
> 
> some_functions()
> 
> into
> 
> something->function()
> 
> no? I do not think that is 0 overhead...

Indeed, and I am performing microbenchmarks to see what measurable 
overhead there is and so far any difference is lost in noise.

Cheers,
Con

--------------enig5FBA24471E0AF9965D7B1DB2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBhXdFZUg7+tp6mRURAoifAJ9AtzmzVR5pjJXM17XjHRrh2mJ9/wCgkFwX
vicIqMjzsWlbtTHRJkkeO3U=
=EOeb
-----END PGP SIGNATURE-----

--------------enig5FBA24471E0AF9965D7B1DB2--
