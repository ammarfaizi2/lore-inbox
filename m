Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVANDqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVANDqA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 22:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVANDmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 22:42:49 -0500
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:37041 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261899AbVANDjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 22:39:14 -0500
Message-ID: <41E73E98.8070603@kolivas.org>
Date: Fri, 14 Jan 2005 14:38:00 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au, lkml@s2y4n2c.de,
       rlrevell@joe-job.com, arjanv@redhat.com, joq@io.com, chrisw@osdl.org,
       mpm@selenic.com, hch@infradead.org, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <200501140330.j0E3UCiG027037@localhost.localdomain>
In-Reply-To: <200501140330.j0E3UCiG027037@localhost.localdomain>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7FD4C503A8AD4BE3D3705D71"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7FD4C503A8AD4BE3D3705D71
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Paul Davis wrote:
>>>Paul.  Everyone agrees with you.  I think.  We just need to work out
>>>the best way of doing it.
>>>
>>>Would I be right in suspecting that we know what to do, but nobody has
>>>stepped up to write the code?  It's kinda looking like that?
>>
>>I thought I made it clear i had already volunteered. I was after a 
>>response to my proposal for how to do it.
> 
> 
> I think your proposal is a good (maybe even excellent) one, but it
> somewhat sidesteps the issue (which may be the best thing to
> do). Rather than answering the question "how best to allow regular
> users access to SCHED_FIFO", it says "lets offer regular users
> SCHED_ISO which is essentially identical to SCHED_FIFO unless tasks
> running SCHED_ISO use too much cpu time".
> 
> its a fine answer, but its the answer to a slightly different
> question. if anyone (maybe us audio freaks, maybe someone else) comes
> up with a reason to want "The Real SCHED_FIFO", the original question
> will have gone unanswered.

Ah then  you missed something. You can set the max cpu of SCHED_ISO to 
100% and then you have it.

Cheers,
Con

--------------enig7FD4C503A8AD4BE3D3705D71
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB5z6YZUg7+tp6mRURAtBSAKCCqziJ5lfq44jWLRBoR2Q4G+9oUwCePiED
izKcod7ntMOHNuruy9QtH5Y=
=J2Sj
-----END PGP SIGNATURE-----

--------------enig7FD4C503A8AD4BE3D3705D71--
