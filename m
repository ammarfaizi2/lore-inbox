Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265048AbUD3QRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265048AbUD3QRr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 12:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264674AbUD3QRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 12:17:36 -0400
Received: from 69-18-53-202.lisco.net ([69.18.53.202]:43457 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S265107AbUD3QOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 12:14:46 -0400
Message-ID: <40927B6C.9020600@slaphack.com>
Date: Fri, 30 Apr 2004 11:14:36 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040422)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@suse.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com, akpm@osdl.org
Subject: Re: I oppose Chris and Jeff's patch to add an unnecessary additional
 namespace to ReiserFS
References: <1082750045.12989.199.camel@watt.suse.com> <408D3FEE.1030603@namesys.com> <20040426203314.A6973@infradead.org> <408E986F.90506@namesys.com> <20040427183400.A20221@infradead.org> <408E9F42.2080804@namesys.com>
In-Reply-To: <408E9F42.2080804@namesys.com>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

| Christoph Hellwig wrote:
|
|>> Did you notice that V4 blows XFS and ReiserFS V3 away in
|>> benchmarks?    That is what I have been doing for 3 years....
|>>
|>> See www.namesys.com for details.
|>>
|>
|>
|> see www.microsoft.com why Windows is much better than Linux.  Yeah,
|> thanks.
|>
|>
| Ask the users whether their laptops, etc.,  seem to go a lot faster with
| V4.  They seem to be pretty happy with it.

With the speed, yes.  With the stability, no.  I use it on my desktop
now, as that's for games, and use xfs on cryptoloop for my laptop.  I
hope to replace that with reiser4 and some crypto plugin someday.  I'll
follow this up with the specific problems in a bit.

|
| V4 fixed all of V3's serious performance flaws, and totally obsoletes
| it.    I am very happy with it.
|

In fact, regarding the whole "innovation" thing, Microsoft and others
have occasionally announced that they were going to create a filesystem
which could act as a database (or the other way around), and generally
introduce some of the features reiser4 has solid by now.

Every time I've seen such a thing announced, it flops later.  It becomes
a userland project, or an abandoned project, and definitely nowhere near
as usable.  Reiser4, however, seems to already have that kind of
functionality -- it's efficient at storing lots of tiny flat text files,
and searching them randomly.

I haven't run any benchmarks against "real" databases like mysql, but if
we want to talk about what V4 obsoletes, it obsoletes things which
haven't even been developed/released yet (WinFS on Longhorn).
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQJJ7angHNmZLgCUhAQIZ+hAAjEI4q47XD+ihgMvXvSo5M7yUMfXZL6vp
Kf306LWaSHEqONsfOZ66X084kezb/1FbG3SrGVkK9TQ2BZ2dCCCa8mHz/eWx6X6j
BiXyBmj7h5UZAVngzbeSFd4LkmWsSVedBb5eKjAj2saHoXbVz/B+efLwaTr5V9+7
ANPL9Qe4qB5O3gNdft1wNu+Zajnuoe5tMGadVyhVKUju8dm43WLOAo23+c5CNBfA
VPheDgLQG84qje6ggwhUEjnpzVKHBKT2jBQ+FG7+MVrK9fiqhWRXLft2ytG6zQfL
VPWiRB5yIYXMItNHm29f1rP/Gx2yITmEGtxMyo/Aq3dD7SWAGik4o/6piQ7OzXCI
+Hfplx4DeVbJ6DeitkeOfJmzOBNMAdE7k2kWs6/Gh7W+TJhp+lYQpYfM/sRPaxRF
T9Wgpq3/kH5GzY+dqkYX/SPU202uSG5X9RAk7oW8Fl55Cmhdrapfp2xkv88Sl6JT
BypmnQFAQl5uBfvtOXzEtz3JLssTATY8JapZyR7KH3+uORsikO1yfb5kuAdBUHvr
Qs+nvHNVg2yQMDA2iB0LXobx/NFY8rMuFj1tmHRVOWgfm9Ky9i2KWfSf/RgtlyjH
gTHLbtCQKpZk/cF1gdkw1fFAath/q2BunSQNdvV6ESy8CYVNTJeYjWqmTktejnS6
NvLjomnwp78=
=cYSQ
-----END PGP SIGNATURE-----
