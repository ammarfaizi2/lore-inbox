Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262572AbUKANeC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbUKANeC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 08:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbUKANeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 08:34:01 -0500
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:25565 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262282AbUKANdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 08:33:49 -0500
Message-ID: <41863AF4.1040905@kolivas.org>
Date: Tue, 02 Nov 2004 00:32:36 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Pavel Machek <pavel@ucw.cz>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Peter Williams <pwil3058@bigpond.net.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH][plugsched 0/28] Pluggable cpu scheduler framework
References: <4183A602.7090403@kolivas.org> <20041031233313.GB6909@elf.ucw.cz> <20041101114124.GA31458@elte.hu>
In-Reply-To: <20041101114124.GA31458@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig61C37280096E7796787E473A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig61C37280096E7796787E473A
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> my main worry with this approach is not really overhead but the impact
> on scheduler development. 

> no problem even under the current model, and it has happened before. We
> made the scheduler itself easily 'rip-out-able' in 2.6 by decreasing the
> junction points between the scheduler and the rest of the system. Also,
> the current scheduler is no way cast into stone, we could easily end up
> having a different interactivity code within the scheduler, as a result
> of the various 'get rid of the two arrays' efforts currently underway.

Do you honestly think with the current "2.6 forever" development process 
that this is likely, even possible any more?

Given that fact, it means the current scheduler policy mechanism is 
effectively set in stone. Do you think we can polish the current 
scheduler enough to be, if not perfect, good enough for _every_ situation?

Noone said that if we have a plugsched infrastructure that we should 
instantly accept any scheduler.

Regards,
Con

--------------enig61C37280096E7796787E473A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBhjr3ZUg7+tp6mRURAs0fAJ48pyeoaqxfyhRvvNUSgrpOUAJbnACfbSJE
t7hZBD9O7ZdNvYw3nsu/PQY=
=Qwg7
-----END PGP SIGNATURE-----

--------------enig61C37280096E7796787E473A--
