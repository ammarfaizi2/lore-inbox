Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266404AbUAOBxV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 20:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266382AbUAOBt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 20:49:29 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:46186 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266355AbUAOBre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 20:47:34 -0500
Message-ID: <4005F128.3080208@yahoo.es>
Date: Wed, 14 Jan 2004 20:47:20 -0500
From: Roberto Sanchez <rcsanchez97@yahoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.1-mm3
References: <20040114014846.78e1a31b.akpm@osdl.org>
In-Reply-To: <20040114014846.78e1a31b.akpm@osdl.org>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig23B9F10AC9EE145ADAB3AB39"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig23B9F10AC9EE145ADAB3AB39
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm3/
> 
> 
> - A big ppc64 update from Anton
> 
> - Added Nick's CPU scheduler patches for hyperthreaded/SMT CPUs.  This work
>   needs lots of testing and review from those who care about and work upon
>   this feature, please.
> 
> - An I/O scheduler tuning patch.  This is the 114th patch against the
>   anticipatory scheduler and we're nearly finished, honest.  Now would be a
>   good time for people to run the appropriate benchmarks.
> 
>   We're still not as good as deadline on some seeky loads, and deep SCSI
>   TCQ still hurts a lot.  But it is looking good on average.
> 
> - Plenty of other random stuff

I am still getting lock-ups on my system (nForce2 w/ Athlon XP 2500+).
I am currently stuck at 2.6.1-rc1-mm1.  If there is anything I can do
to help track down the problem I would be happy to help, I just need
some  pointers on where to start.

-Roberto Sanchez

--------------enig23B9F10AC9EE145ADAB3AB39
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFABfEyTfhoonTOp2oRAjTuAKDdE100uhKV8y8kJ1jyZycvJJ8FpACgr0PA
KCghWM/n97DA5cEpJWXhZfU=
=xSiP
-----END PGP SIGNATURE-----

--------------enig23B9F10AC9EE145ADAB3AB39--
