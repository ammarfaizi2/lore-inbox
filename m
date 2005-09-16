Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161119AbVIPTwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161119AbVIPTwf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 15:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965315AbVIPTwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 15:52:35 -0400
Received: from av8-1-sn3.vrr.skanova.net ([81.228.9.183]:42894 "EHLO
	av8-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S965314AbVIPTwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 15:52:34 -0400
Message-ID: <432B2237.4090900@fulhack.info>
Date: Fri, 16 Sep 2005 21:51:19 +0200
From: Henrik Persson <root@fulhack.info>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050912)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jesper.juhl@gmail.com
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>	 <43289A7E.1080307@fulhack.info> <9a874849050914162069c0296f@mail.gmail.com>
In-Reply-To: <9a874849050914162069c0296f@mail.gmail.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5A821913AE6AE37A56382CF9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5A821913AE6AE37A56382CF9
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jesper Juhl wrote:
>>My cardbus is acting funny. When I insert my netgear wg511 (prism54) the
>>first time after booting 2.6.14-rc1 nothing happens. Nothing in dmesg,
>>nothing nowhere. I remove it. Still nothing. Oh well. Inserting again.
>>THEN it initializes and is working like it usually does.
>>
>>2.6.13+Ivan's PCI resource patch worked allright.

Whops. I lied. 2.6.13+Ivan's patch behaves just the same.. Too bad I 
didn't test that BEFORE I bisected and recompiled the kernel 12 times. ;/

So..I guess this has something to do with the PCI update in 2.6.13.. Any 
pointers to where I should start bisecting this time?

--
Henrik Persson

--------------enig5A821913AE6AE37A56382CF9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDKyI9p5uk1YPOcmcRAgO3AJ0Z6XkEnweo2djHB2ktU64WbyY9RwCeOIYr
N8rRXN1oKYjmaTkpqWMqzgc=
=Hzle
-----END PGP SIGNATURE-----

--------------enig5A821913AE6AE37A56382CF9--
