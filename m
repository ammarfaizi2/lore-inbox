Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbULYNxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbULYNxb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 08:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbULYNxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 08:53:31 -0500
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:39616 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261507AbULYNxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 08:53:23 -0500
Message-ID: <41CD70B9.8080001@kolivas.org>
Date: Sun, 26 Dec 2004 00:52:57 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sean Neakums <sneakums@zork.net>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.10-ck1
References: <200412250800_MC3-1-91AD-1E8B@compuserve.com> <6upt0ymqrc.fsf@zork.zork.net>
In-Reply-To: <6upt0ymqrc.fsf@zork.zork.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig32D10D3474C1AFB7724B4647"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig32D10D3474C1AFB7724B4647
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sean Neakums wrote:
> Chuck Ebbert <76306.1226@compuserve.com> writes:
> 
> 
>>Con Kolivas wrote:
>>
>>
>>>.fix_noswap.diff
>>>Build fix for config without swap
>>
>>  So 2.6.10 won't build without swap enabled?
> 
> 
> Built fine here.
> 
> 
>>  This was a known problem; how did it get out the door without that fix?
> 
> 
> It looks like a different (and cleaner) fix was applied:
> #define swap_token_default_timeout 0 when CONFIG_SWAP=n.

Ah thanks. I should have looked more carefully. I simply didn't see the 
fix Chuck posted. This should be better as Chuck's fix didn't disable 
the swap token (which still does stuff even with swap disabled).

Cheers,
Con

--------------enig32D10D3474C1AFB7724B4647
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBzXC5ZUg7+tp6mRURAoMeAJ9QAtoVYjphupxHDPagd1q5GpXqAwCfYGXo
m/axbpCnJX/+pI/tESDWJwQ=
=tOCA
-----END PGP SIGNATURE-----

--------------enig32D10D3474C1AFB7724B4647--
