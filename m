Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbUKENaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbUKENaP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 08:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbUKENaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 08:30:15 -0500
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:59084 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261614AbUKENaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 08:30:05 -0500
Message-ID: <418B8047.5050902@kolivas.org>
Date: Sat, 06 Nov 2004 00:29:43 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Fix for vmalloc problem was Re: 2.6.10-rc1-mm3
References: <20041105001328.3ba97e08.akpm@osdl.org.suse.lists.linux.kernel> <418B5C70.7090206@kolivas.org.suse.lists.linux.kernel> <p73sm7o7br3.fsf@verdi.suse.de> <418B6F18.9090404@kolivas.org> <20041105131232.GA1030@wotan.suse.de>
In-Reply-To: <20041105131232.GA1030@wotan.suse.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3EA85199C83F3AD6A7860949"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3EA85199C83F3AD6A7860949
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andi Kleen wrote:
> On Fri, Nov 05, 2004 at 11:16:24PM +1100, Con Kolivas wrote:
> 
>>Andi Kleen wrote:
>>
>>>Con Kolivas <kernel@kolivas.org> writes:
>>>
>>>
>>>
>>>>It's life Jim but not as we know it...
>>>>
>>>>
>>>>This happened during modprobe of alsa modules. Keyboard still alive,
>>>>everything else dead; not even sysrq would do anything, netconsole had
>>>>no output, luckily this made it to syslog:
>>>
>>>
>>>I just tested modprobing of alsa (snd_intel8x0) and it works for me.
>>>Also vmalloc must work at least to some point.
>>>
>>>Can you confirm it's really caused by 4level by reverting all the 
>>>4level-* patches from broken out? 
>>
>>I dont recall blaming 4level. When I get a chance I'll try.
> 
> 
> This patch should fix it. Can you please test? Thanks.
> 
> -Andi
> 
> Fix silly typo in mm/vmalloc.c and some minor cleanups.

Boots fine now thanks.

Con

--------------enig3EA85199C83F3AD6A7860949
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBi4BMZUg7+tp6mRURAmriAKCJQEeonCIUtlv3TDHNgOy7JOIXWgCeJHWw
YdA7FYxAEKm+DXNuHl6R3Ss=
=XYCB
-----END PGP SIGNATURE-----

--------------enig3EA85199C83F3AD6A7860949--
