Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbVDERpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVDERpv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 13:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVDERoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 13:44:02 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:30116 "EHLO
	mail-in-06.arcor-online.net") by vger.kernel.org with ESMTP
	id S261836AbVDERU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 13:20:29 -0400
Message-ID: <4252C8D8.9040109@arcor.de>
Date: Tue, 05 Apr 2005 19:20:24 +0200
From: Prakash Punnoor <prakashp@arcor.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050324)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Robert Love <rml@novell.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] inotify for 2.6.11
References: <1109961444.10313.13.camel@betsy.boston.ximian.com>	 <4252453E.7060407@arcor.de> <1112717566.7324.19.camel@betsy>
In-Reply-To: <1112717566.7324.19.camel@betsy>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig579286DA9FA843BAED90EC92"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig579286DA9FA843BAED90EC92
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Robert Love schrieb:
> On Tue, 2005-04-05 at 09:58 +0200, Prakash Punnoor wrote:
> 
>>I am having a little trouble with inotify 0.22. Previous version worked w/o
>>trouble (even with nvidia and nvsound loaded) with 2.6.12-rc1-kb2 and gamin
>>
>>Now I use 2.6.12-rc2 with inotify 0.22 and got this after a few minutes of
>>uptime (compiling some stuff):
> 
> 
> Ah, thanks.  That was not even related to the semaphore rewrite, but a
> small bug fix I slipped in.  But of course.
> 
> Gamin is an interesting test case for us because it does so many
> ignores.

BTW, what else could I use to make use of inotify? I know fam, which afaik
only uses dnotify.

> Anyhow, this should fix it.  Confirm?

So far no problems. Interesting enough the previous patch worked w/o problem
the last hours...

Cheers

-- 
Prakash Punnoor

--------------enig579286DA9FA843BAED90EC92
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCUsjcxU2n/+9+t5gRAgBGAJ9dPei9Q/Jnc3bVMGR/6IUiFOkguwCeNzZ3
RiG0xnsL+P7TngsyUfb6WF8=
=W0QO
-----END PGP SIGNATURE-----

--------------enig579286DA9FA843BAED90EC92--
