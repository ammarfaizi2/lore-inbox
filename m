Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbTEGJWv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 05:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbTEGJWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 05:22:51 -0400
Received: from stingr.net ([212.193.32.15]:31162 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id S263024AbTEGJWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 05:22:49 -0400
Date: Wed, 7 May 2003 13:35:07 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH: Replace current->state with set_current_state in 2.5.6 8
Message-ID: <20030507093507.GE5807@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <A46BBDB345A7D5118EC90002A5072C780C8FDEAD@orsmsx116.jf.intel.com> <20030506182456.644b70d1.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20030506182456.644b70d1.rddunlap@osdl.org>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

Replying to Randy.Dunlap:
> Even if Gabriel's patch is perfect, I don't expect that Linus will merge it,
> esp. not now, but not even earlier in 2.5 days.  For one thing, it's
> 176 KB, so it needs to be broken down by subsystem/driver/filesystem/etc.

almost one year ago I've did similar work. Even split it in small pieces.
Even encouraged some subsystem maintainers to do some movements in this
direction (greg kh, actually).

Even running my own patched kernel with this patches in on my production
servers for a months without single hang or reboot.

Even have 2.4 bk tree (way outdated, but patches are in). Even can publish it.

> Then it needs some exposure, like living in -ac or -mm or -pick1,
> or at least some testing (everyday usage) by a few people, with reports
> from them.

After a couple of attempts to attend people who make decisions to that issue
I've stopped doing that, just almost like Keith Owens with his kbuild 2.5

> And I don't really want to review a 176 KB patch (although I did already
> look over most of it a few days ago).  Do people want to take portions
> of it for review and then see about Alan merging it, e.g.?

I don't think even sed with simple s/// can misplace set_current_state into
something unrelated (if it is not buggy sed ;)

And with bitkeeper (or other tool that can do colored diff representation)
it will be even simplier.

- -- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
-----BEGIN PGP SIGNATURE-----

iD8DBQE+uNNByMW8naS07KQRA52oAKDL1irCb0uRhN1coX/u8FB1q00SQwCcDYvq
FF8b4rCJLJVKtFFmCGTu1Xo=
=M478
-----END PGP SIGNATURE-----
