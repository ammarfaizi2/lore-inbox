Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbUJZUub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbUJZUub (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 16:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbUJZUua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 16:50:30 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:59522 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261458AbUJZUtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 16:49:03 -0400
Message-ID: <417EB83B.90707@comcast.net>
Date: Tue, 26 Oct 2004 16:48:59 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, alan@lxorguk.ukuu.org.uk,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Let's make a small change to the process
References: <200410260644.47307.edt@aei.ca>	 <00c201c4bb4c$56d1b8b0$e60a0a0a@guendalin>	 <4d8e3fd3041026050823d012dc@mail.gmail.com>	 <877jpdcnf5.fsf@barad-dur.crans.org> <4d8e3fd304102613165b2fb283@mail.gmail.com>
In-Reply-To: <4d8e3fd304102613165b2fb283@mail.gmail.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Paolo Ciarrocchi wrote:
| Hi all,
| despite I know you are all bored with the " I know how to improve the
| process" email but I want to share with you this idea .-)
|
| Both Andrew and Linus are doing an impressive job so I really don't
| think we need to change the way they are working.
|
| What I'm suggesting is start offering 2.6.X:Y kernel, you did for
2.6.8.1 so...
|
| The .Y patchset contains only important security fix (all stuff you
| think are important) and is weekly uploaded to kernel.org
|

Eww.

2.6.10 got an -rc about 4 days after 2.6.9 went stable.  This would be a
bit too rapid for my tastes; I don't like ideas that potentially load
maintainers.

[...]

| We, of course, need a maintainer for it,

Yes, a little too much to maintain though isn't it?  Maintainers to
continuously upkeep revisions that come out every few weeks potentially?
~ Remember it's got to be able to withstand the test of time for quite a
while; why are people still maintaining 2.2?

| maybe someone from OSDL (Randy?), maybe wli (he maintained his tree
| for a long time), maybe Alan (that is already applying these kind of
| fixes to his tree), maybe someone else... ?
|

Common courteousy, don't volunteer people.  :)

| Sounds reasonable ?
|

Sounds too fast.  I don't predict having a maintainer for each minor
release of the kernel (which is what you're saying here essentially), so
there'd be a need for one or a handfull of maintainers to spend loads of
time backporting fixes to a quickly mounting set of kernels.

I had <shameless plug> suggested an hour or two ago a scheme where the
current development model be based off, but periodic releases be made
"stable," basing on approximately 6 months between releases </shameless
plug>.  I think it's a bit more sane to say that a maintainer may mount
up 4 kernels in 2 years to backport bugfixes into, if nobody else steps
up to the plate to help.

Of course, eventually official support has to be dropped in either
scheme, because the same problem is faced:  We can't expect people to
maintain a continuously mounting number of kernel revisions once the
workload becomes sufficiently high.  A balance must be made between
dropping support for a non-volitile code base, and maintaining a support
period sufficiently long.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBfrg7hDd4aOud5P8RAo5eAJ4/lbCRuNfVM9iNoNaEOBX5wdqTlwCfWUK7
XM9z2dgXmkMWg28xZzlWeMI=
=edrQ
-----END PGP SIGNATURE-----
