Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVAUQqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVAUQqc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 11:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVAUQqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 11:46:03 -0500
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:64999 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261523AbVAUQne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 11:43:34 -0500
Message-ID: <41F13120.60108@kolivas.org>
Date: Sat, 22 Jan 2005 03:43:12 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Marc E. Fiuczynski" <mef@CS.Princeton.EDU>
Cc: Jens Axboe <axboe@suse.de>, Valdis.Kletnieks@vt.edu,
       Peter Williams <pwil3058@bigpond.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>
Subject: Re: [ANNOUNCE][RFC] plugsched-2.0 patches ...
References: <NIBBJLJFDHPDIBEEKKLPIEDNDIAA.mef@cs.princeton.edu>
In-Reply-To: <NIBBJLJFDHPDIBEEKKLPIEDNDIAA.mef@cs.princeton.edu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC18198C247B457F254C5CA1F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC18198C247B457F254C5CA1F
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Marc E. Fiuczynski wrote:
> Paraphrasing Jens Axboe:
> 
>>I don't think you can compare [plugsched with the plugio framework].
>>Yes they are both schedulers, but that's about where the 'similarity'
>>stops. The CPU scheduler must be really fast, overhead must be kept
>>to a minimum. For a disk scheduler, we can affort to burn cpu cycles
>>to increase the io performance. The extra abstraction required to
>>fully modularize the cpu scheduler would come at a non-zero cost as
>>well, but I bet it would have a larger impact there. I doubt you
>>could measure the difference in the disk scheduler.
> 
> 
> Modularization usually is done through a level of indirection (function
> pointers).  I have a can of "indirection be gone" almost ready to spray over
> the plugsched framework that would reduce the overhead to zero at runtime.
> I'd be happy to finish that work if it makes it more palpable to integrate a
> plugsched framework into the kernel?

The indirection was a minor point. On modern cpus it was suggested by 
wli that this would not be a demonstrable hit in perormance. Having said 
that, I'm sure Peter would be happy for another developer. I know how 
tiring and lonely it can feel maintaining such a monster.

Cheers,
Con

--------------enigC18198C247B457F254C5CA1F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8TEgZUg7+tp6mRURAjBkAJ9ibaStzeWZW1NaxKx3LD2nJ9v/sgCfTOGT
UwyqPJa/KY7nB1KW9mizKnY=
=N7Ts
-----END PGP SIGNATURE-----

--------------enigC18198C247B457F254C5CA1F--
