Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286154AbRLZETk>; Tue, 25 Dec 2001 23:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286150AbRLZET3>; Tue, 25 Dec 2001 23:19:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3850 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286148AbRLZETU>; Tue, 25 Dec 2001 23:19:20 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: 2.5.2-pre2 forces ramfs on
Date: Wed, 26 Dec 2001 04:17:11 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a0bj07$18l$1@penguin.transmeta.com>
In-Reply-To: <2452.1009338062@ocs3.intra.ocs.com.au>
X-Trace: palladium.transmeta.com 1009340342 20846 127.0.0.1 (26 Dec 2001 04:19:02 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 26 Dec 2001 04:19:02 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <2452.1009338062@ocs3.intra.ocs.com.au>,
Keith Owens  <kaos@ocs.com.au> wrote:
>
>Why is ramfs forced on?

Because it's small, and if it wasn't there, we'd have to have the small
"rootfs" anyway (which basically duplicated ramfs functionality).

>And why is Al Viro's email address not in CREDITS or MAINTAINERS?  We
>should have somewhere to complain to ;).

He didn't want to be in either file at some point (yes, I asked him),
some day I'll put him in anyway (he's been the effective maintainer of
the VFS interface for the last year or so, regardless of whether he
wants to be in the MAINTAINTERS file or not).

		Linus
