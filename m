Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130330AbRAHX3N>; Mon, 8 Jan 2001 18:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130319AbRAHX3D>; Mon, 8 Jan 2001 18:29:03 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:37641 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130330AbRAHX2w>; Mon, 8 Jan 2001 18:28:52 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: `rmdir .` doesn't work in 2.4
Date: 8 Jan 2001 15:28:29 -0800
Organization: Transmeta Corporation
Message-ID: <93diet$aqc$1@penguin.transmeta.com>
In-Reply-To: <20010108213036.T27646@athlon.random> <Pine.GSO.4.21.0101081537570.4061-100000@weyl.math.psu.edu> <20010108225605.Y27646@athlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010108225605.Y27646@athlon.random>,
Andrea Arcangeli  <andrea@suse.de> wrote:
>On Mon, Jan 08, 2001 at 04:08:58PM -0500, Alexander Viro wrote:
>> 	Andrea, fix your code. Linux-only stuff is OK when there is no
>
>BTW, "rmdir `pwd`" is not portable either.

Indeed. Avoid it if you can.

But at least "rmdir `pwd`" is not _required_ to fail, like rmdir("."/"..").

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
