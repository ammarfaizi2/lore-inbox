Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265331AbUIMDwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265331AbUIMDwX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 23:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUIMDwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 23:52:23 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:7594 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265331AbUIMDwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 23:52:19 -0400
Message-ID: <41451957.7000101@kolivas.org>
Date: Mon, 13 Sep 2004 13:51:51 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joshua Schmidlkofer <kernel@pacrimopen.com>
Cc: jch@imr-net.com, ck kernel mailing list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Cliff Wells <clifford.wells@comcast.net>
Subject: Re: [ck] Re: 2.6.8.1-ck7, Two Badnessess, one dump.
References: <41412765.4010005@kolivas.org> <4144F691.6040405@pacrimopen.com>
In-Reply-To: <4144F691.6040405@pacrimopen.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1155DA152F95788093AE7F9D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1155DA152F95788093AE7F9D
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Joshua Schmidlkofer wrote:
> I upgraded from 2.6.8.1-ck5.
> 
> First off - this has been a landmark improvement for me.   Running an 
> "emerge -a world" on my system has gone from a matter of minutes to a 
> matter of seconds.
> 
> The performance has been !outstanding!. [Disclosure:  Using NVIDIA 
> Binary Drivers]

Great to hear. Thanks for feedback.

Not sure about the xfs one... perhaps it's related to the cfq one.

> Badness in cfq_sort_rr_list at drivers/block/cfq-iosched.c:428

Known issue. There is a fix posted already in my ckdev directory (as 
posted by Jens Axboe). The stack dump, while annoying and causes a stall 
for a couple of seconds I believe, is harmless. Please apply the cfq2 
fix in my ckdev directory for this to go away.

http://ck.kolivas.org/patches/2.6/2.6.8.1/2.6.8.1-ckdev/

Cheers,
Con

--------------enig1155DA152F95788093AE7F9D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBRRlbZUg7+tp6mRURAjsJAKCBp7UjKh2cydz3MBu0cpdI2jH9OwCeMQxU
Ql985wY9G+4Of+DkOWE7/5w=
=kvdk
-----END PGP SIGNATURE-----

--------------enig1155DA152F95788093AE7F9D--
