Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130468AbRAEBJm>; Thu, 4 Jan 2001 20:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130687AbRAEBJe>; Thu, 4 Jan 2001 20:09:34 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:772 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130468AbRAEBJZ>; Thu, 4 Jan 2001 20:09:25 -0500
Date: Thu, 4 Jan 2001 17:09:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Miles Lane <miles@megapathdsl.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: And oh, btw..
In-Reply-To: <3A551986.3090601@megapathdsl.net>
Message-ID: <Pine.LNX.4.10.10101041659280.1249-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jan 2001, Miles Lane wrote:
>
> Is there a patch against test12 somewhere?  I don't see it.

In v2.4/test-kernels:
 patch-2.4.0-prerelease.gz - patch from test12 to the prerelease
 prerelease-to-final.gz - patch from prerelease to final.

And it will apparently take some time for the ftp servers to sync up: when
I moved the test-kernels away from the main v2.4 directory I didn't think
of the fact that the mirror scripts will spend quite a bit of time just
synchronizing everything (the fact that _I_ did it with a simple "mv" on
the master copies doesn't mean that the mirror services will be able to do
it ;)

Right now the sync from the master copy has gotten to the patches in the
test directory, which means that it shouldn't take more than maybe 15
minutes until everything has been synched - but I suspect that if people
pound on ftp.kernel.org it will only slow stuff down further, so try to
see if you can find other mirrors that got in early and don't synchronize
the test-kernels...

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
