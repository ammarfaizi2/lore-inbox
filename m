Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262317AbVAUIiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbVAUIiN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 03:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbVAUIiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 03:38:13 -0500
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:60037 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262317AbVAUIiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 03:38:02 -0500
Message-ID: <41F0BF4B.6010607@kolivas.org>
Date: Fri, 21 Jan 2005 19:37:31 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm2
References: <20050119213818.55b14bb0.akpm@osdl.org>	<41F0B807.6000606@kolivas.org> <20050121003449.75ec1397.akpm@osdl.org>
In-Reply-To: <20050121003449.75ec1397.akpm@osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig90F3A59430256929E78EBE94"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig90F3A59430256929E78EBE94
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> 
>>Stops after BIOS check successful.

earlyprintk on
> 
> 
> What does this mean, btw?  Can you be more specific about where it gets
> stuck?

It says decompressing BIOS check successful and then sits there

> If you mean that it actually prints no messages at all then yeah, early
> printk.  One suspect would be the kexec patches which play with boot-time
> memory layouts and such.

Hmm ok

> Make sure that CONFIG_PHYSICAL_START is 0x100000.

Yeah it is.
> 
> x86-vmlinux-fix-physical-addrs.patch, perhaps..

I'll try.

Cheers,
Con

--------------enig90F3A59430256929E78EBE94
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8L9LZUg7+tp6mRURAlePAJ9OePvj5NdDRa7I74rYpKxw9Yr/pgCdHhF6
/CRlQEpC1UneHYeLXRT4ASw=
=vaBq
-----END PGP SIGNATURE-----

--------------enig90F3A59430256929E78EBE94--
