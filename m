Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267966AbUHWVwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267966AbUHWVwU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 17:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267555AbUHWVu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 17:50:58 -0400
Received: from mail011.syd.optusnet.com.au ([211.29.132.65]:56707 "EHLO
	mail011.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267399AbUHWVtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 17:49:09 -0400
Message-ID: <412A663D.2050104@kolivas.org>
Date: Tue, 24 Aug 2004 07:48:45 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Cc: Joshua Schmidlkofer <menion@asylumwear.com>,
       ck kernel mailing list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-ck4
References: <412880BF.6050503@kolivas.org> <412A2398.8050702@asylumwear.com> <412A271F.3040802@gmx.de>
In-Reply-To: <412A271F.3040802@gmx.de>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB31B70EAFE1E44D8713C628D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB31B70EAFE1E44D8713C628D
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Prakash K. Cheemplavam wrote:
> Joshua Schmidlkofer wrote:
> | I don't know what or why, but I am experiancing a nightmare with
> | interactivity and heavy nfs use.   I am using Gentoo, and I have my
> | portage tree exported from a central server.   Trying to do an emerge
> | update world is taking forever.
> 
> [snip]
> 
> Yup I think I have a regression here, as well. I remember an older
> version of ck exhibited this, but the last one for 2.6.7 did work well
> (I think even the one for 2.8.6-rc4 was ok), IIRC. In my case, when
> doing a (niced) compile in background, some windows react very slow, ie
> Mozilla Thunderbird takes ages to switch trough mails or cliking on an
> icon in kde to load up konsole takes about 10seconds or more (shoud come
> up <1sec normally).
> 
> Using 2.8.6.1-ck4
> 
> HTH,
> 
> Prakash

For both of you this only happens with NFS? Can you reproduce the 
problem in flight and send me the output of 'top -n -n 1' while it's 
happening? Also if you have time can you confirm this happens with just 
the staircase patch and none of the other patches?

Cheers,
Con

--------------enigB31B70EAFE1E44D8713C628D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBKmZAZUg7+tp6mRURAmcnAJsFbNlPdfoVtChxg15nv8DEwWneggCgkkHc
4eeGvAlxXRP3ui7NtEuNkqA=
=sUMg
-----END PGP SIGNATURE-----

--------------enigB31B70EAFE1E44D8713C628D--
