Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262660AbUKEMRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262660AbUKEMRH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 07:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbUKEMRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 07:17:06 -0500
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:62116 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262660AbUKEMQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 07:16:36 -0500
Message-ID: <418B6F18.9090404@kolivas.org>
Date: Fri, 05 Nov 2004 23:16:24 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm3
References: <20041105001328.3ba97e08.akpm@osdl.org.suse.lists.linux.kernel>	<418B5C70.7090206@kolivas.org.suse.lists.linux.kernel> <p73sm7o7br3.fsf@verdi.suse.de>
In-Reply-To: <p73sm7o7br3.fsf@verdi.suse.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig162EF045386D8F2516777BEA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig162EF045386D8F2516777BEA
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andi Kleen wrote:
> Con Kolivas <kernel@kolivas.org> writes:
> 
> 
>>It's life Jim but not as we know it...
>>
>>
>>This happened during modprobe of alsa modules. Keyboard still alive,
>>everything else dead; not even sysrq would do anything, netconsole had
>>no output, luckily this made it to syslog:
> 
> 
> I just tested modprobing of alsa (snd_intel8x0) and it works for me.
> Also vmalloc must work at least to some point.
> 
> Can you confirm it's really caused by 4level by reverting all the 
> 4level-* patches from broken out? 

I dont recall blaming 4level. When I get a chance I'll try.

Cheers,
Con

--------------enig162EF045386D8F2516777BEA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBi28YZUg7+tp6mRURAk6nAJ4uYU+GFCgkqmXtAn7j9Qg5SAGCbQCeNTOG
L2Pe4RAD7sjj3+1C7z09z44=
=39bU
-----END PGP SIGNATURE-----

--------------enig162EF045386D8F2516777BEA--
