Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266512AbUHBNIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266512AbUHBNIm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 09:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266523AbUHBNIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 09:08:42 -0400
Received: from mail015.syd.optusnet.com.au ([211.29.132.161]:33966 "EHLO
	mail015.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266512AbUHBNIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 09:08:40 -0400
Message-ID: <410E3CAF.6080305@kolivas.org>
Date: Mon, 02 Aug 2004 23:07:59 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm2
References: <20040802015527.49088944.akpm@osdl.org>
In-Reply-To: <20040802015527.49088944.akpm@osdl.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7638F16970A57304FCCC5490"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7638F16970A57304FCCC5490
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc2/2.6.8-rc2-mm2/
> - Added Con's staircase CPU scheduler.
> 
>   This will probably have to come out again because various people are still
>   fiddling with the CPU scheduler.  But my feeling here is that the current
>   1st-gen CPU scheduler has been tweaked as far as it can go and is still not
>   100% right.  It is time to start thinking about a new design which addresses
>   the requirements and current problems by algorithmic means rather than by
>   tweaking.  Removing over 300 lines from the scheduler is a good sign.
> 
>   Feedback on this patch is sought.

Anyone with feedback on this please cc me. This was developed separately 
from the -mm series which has heaps of other scheduler patches which 
were not trivial to merge with so there may be teething problems. Good 
reports dont hurt either ;)

Cheers,
Con

--------------enig7638F16970A57304FCCC5490
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBDjyyZUg7+tp6mRURAkfzAJ4wz8GXwrP0B0myQQkDM+TtHAQv3gCdFHeP
XS/vSwMWlZnBCEE6Gr5T4mU=
=J4HI
-----END PGP SIGNATURE-----

--------------enig7638F16970A57304FCCC5490--
