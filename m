Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262651AbULPJeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbULPJeI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 04:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbULPJeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 04:34:08 -0500
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:61665 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262651AbULPJeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 04:34:02 -0500
Message-ID: <41C1567D.1020603@kolivas.org>
Date: Thu, 16 Dec 2004 20:33:49 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Werner Almesberger <werner@almesberger.net>
Cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generalized prio_tree, revisited
References: <20041216053118.M1229@almesberger.net> <41C14F1B.8000401@kolivas.org> <20041216061517.O1229@almesberger.net>
In-Reply-To: <20041216061517.O1229@almesberger.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD55EF1268F423F7DE3F0D9C8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD55EF1268F423F7DE3F0D9C8
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Werner Almesberger wrote:
> Con Kolivas wrote:
> 
>>While not being able to comment on the actual patch I think having a 1 
>>or 0 for different types is not clear.
> 
> 
> Yeah, it's not pretty. I also hope this division to be very
> transitional, that's why I didn't bother to do anything nicer.
> 
> 
>>Naming them different struct names would seem to me much more readable.
> 
> 
> Struct names ? I'd rather not duplicate everything. Or did you mean
> initialization function names, e.g. INIT_RAW_PRIO_TREE_ROOT ?
> Or, for just the flag, maybe something like
> #define PRIO_TREE_RAW		1
> #define PRIO_TREE_NORMAL	0

Initialisation function names.

Cheers,
Con

--------------enigD55EF1268F423F7DE3F0D9C8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBwVZ/ZUg7+tp6mRURAriJAJ4z9MqboxWHmPJtqvoBx61EuJ6+6QCfTwER
c4QdB55Ekyh9DxCF3hwLqfI=
=OVFQ
-----END PGP SIGNATURE-----

--------------enigD55EF1268F423F7DE3F0D9C8--
