Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265932AbUHVDgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265932AbUHVDgT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 23:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265909AbUHVDgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 23:36:19 -0400
Received: from mail020.syd.optusnet.com.au ([211.29.132.131]:24006 "EHLO
	mail020.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265932AbUHVDgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 23:36:06 -0400
Message-ID: <41281496.8080800@kolivas.org>
Date: Sun, 22 Aug 2004 13:35:50 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Diego Calleja <diegocg@teleline.es>
Cc: John McGowan <jmcgowan@inch.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.8.1: memory leak? cdrecord problem?
References: <20040821172646.GA8781@localhost.localdomain> <20040821194457.38920e99.diegocg@teleline.es>
In-Reply-To: <20040821194457.38920e99.diegocg@teleline.es>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig371BB1B52B06C826BEF0D4C1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig371BB1B52B06C826BEF0D4C1
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Diego Calleja wrote:
> El Sat, 21 Aug 2004 13:26:46 -0400 John McGowan <jmcgowan@inch.com> escribió:
> 
> 
>>KERNEL 2.6.8.1: Memory leak? CDrecord problem?
> 
> 
> 
> Yes, there's a memory leak, you can try 2.6.8.1-mm3
> or apply the fix yourself (I think it's this one:
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm3/broken-out/bio_uncopy_user-mem-leak.patch )

That wont do by itself. It only fixes the memory leak. You _also_ need 
this patch for audio cds to not be stuffed:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm3/broken-out/bio_uncopy_user-mem-leak-fix.patch

Cheers,
Con

--------------enig371BB1B52B06C826BEF0D4C1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBKBSYZUg7+tp6mRURAlbNAJ9IaAKwe3kk8hlcXDnbs2N42H7gkgCghTfZ
kVCpVf5XQ/hIu4TS54dIVtY=
=IYcw
-----END PGP SIGNATURE-----

--------------enig371BB1B52B06C826BEF0D4C1--
