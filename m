Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbVLCQ64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVLCQ64 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 11:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbVLCQ64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 11:58:56 -0500
Received: from host-83-146-9-72.bulldogdsl.com ([83.146.9.72]:23395 "EHLO
	host-83-146-9-72.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932077AbVLCQ64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 11:58:56 -0500
Message-ID: <4391CEC7.30905@unsolicited.net>
Date: Sat, 03 Dec 2005 16:58:47 +0000
From: David Ranson <david@unsolicited.net>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de> <1133620598.22170.14.camel@laptopd505.fenrus.org> <20051203152339.GK31395@stusta.de> <20051203162755.GA31405@merlin.emma.line.org>
In-Reply-To: <20051203162755.GA31405@merlin.emma.line.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFBD1CB9B621AB5CC435B89CB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFBD1CB9B621AB5CC435B89CB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Matthias Andree wrote:

>>>the model needs finetuning. Right now the biggest pain is the userland
>>>ABI changes that need new packages; sometimes (often) for no real hard
>>>reason. Maybe we should just stop doing those bits, they're not in any
>>>fundamental way blocking general progress (sure there's some code bloat
>>>due to it, but I guess we'll just have to live with that)
>>>
>>>
Well as a mildly technical 'user' who's been tracking the 2.6 series I
can't recall having to update _any_ userland packages due to kernel
changes. An example of this would be helpful.

>Exactly that, and kernel interfaces going away just to annoy binary
>module providers also hurts third-party OSS modules, such as
>Fujitsu-Siemens's ServerView agents.
>
>
As many here say. Too bad, we really don't care. Hardware providers
should have the requisite relationships with the distros and target
their management utilities to those. Surely no business using this sort
of high end hardware is running anything other than RHEL or SLES etc ?

>I found myself chasing some genuine bugs in that code to please GCC 4
>(which doesn't tolerate extern blah declarations before static blah
>definitions), and some idiotic breakage when inter_module_get was
>dropped somewhen between 2.6.8 (where the modules compiled just fine)
>and 2.6.13 (where they didn't as functions had been removed).  And
>there's no point arguing about deprecation warnings being around,
>interfaces can be removed between 2.6 and 2.8 but not between
>
>
See above.

>Well, the current model, since it has been in effect, is just "let's
>break the interfaces at will, but let's not hint anyone, so let's always
>
>
Only kernel interfaces. And that's too bad for out of kernel modules.

>Linux is in fact light years away from being "stable", and while it was
>
>
If you want stable you want a distro 'enterprise' version.

>and some early 2.6.X release, moving between 2.6.X and 2.6.Y means
>switching user-space, too, and chances are the new user-space doesn't
>work with the old kernel.
>
>
In my experience this isn't the case.

Cheers
David

--------------enigFBD1CB9B621AB5CC435B89CB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (MingW32)

iD8DBQFDkc7NDYHcaCYtZo4RAltuAKDwddzQWuI3bNada699L8lBqOykTACgm/mA
A4HEXO06CrEihT6JadDHsR0=
=bqwQ
-----END PGP SIGNATURE-----

--------------enigFBD1CB9B621AB5CC435B89CB--
