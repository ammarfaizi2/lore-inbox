Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269166AbUHZQko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269166AbUHZQko (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 12:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269188AbUHZQkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 12:40:22 -0400
Received: from mail020.syd.optusnet.com.au ([211.29.132.131]:49338 "EHLO
	mail020.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S269166AbUHZQiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 12:38:17 -0400
Message-ID: <412E11ED.7040300@kolivas.org>
Date: Fri, 27 Aug 2004 02:38:05 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm1
References: <20040826014745.225d7a2c.akpm@osdl.org> <412DC47B.4000704@kolivas.org> <200408261636.06857.rjw@sisk.pl>
In-Reply-To: <200408261636.06857.rjw@sisk.pl>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3A75C81C3BC9A176A5ED83B6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3A75C81C3BC9A176A5ED83B6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Rafael J. Wysocki wrote:
> On Thursday 26 of August 2004 13:07, Con Kolivas wrote:
> 
>>Andrew Morton wrote:
>>
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2
>>>.6.9-rc1-mm1/
>>>
>>>
>>>- nicksched is still here.  There has been very little feedback, except
>>>that it seems to slow some workloads on NUMA.
>>
>>That's because most people aren't interested in a new cpu scheduler for
>>2.6.
> 
> 
> I am, but I have no benchmarks that give any useful numbers.

That's because there are none for interactivity; you're simply 
reinforcing my point.

>>The current one works well enough in most situations and people
>>aren't trying -mm to fix their interactive problems since they are few
>>and far between.
> 
> 
> Actually, with the current scheduler, updatedb really sucks.  It's supposed to 
> be a background task, but it hogs IO resources and memory like crazy 
> (disclaimer: it's my personal subjective observation).

The cpu scheduler plays almost no part in this. It's the I/O scheduler 
and the vm. IOnice will help the former _when it comes out_. Dropping 
the swappiness kind of helps the latter; although there are numerous 
alternative tweaks appearing for that too.

Cheers,
Con

--------------enig3A75C81C3BC9A176A5ED83B6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBLhHtZUg7+tp6mRURAnNeAJkBC3WLSdSmER8cCKXO/F1cyrZhogCdELbj
0MgXD65k5fAqUqn/9/Msm4g=
=1d3E
-----END PGP SIGNATURE-----

--------------enig3A75C81C3BC9A176A5ED83B6--
