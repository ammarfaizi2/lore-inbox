Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280832AbRKLQ1A>; Mon, 12 Nov 2001 11:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280834AbRKLQ0v>; Mon, 12 Nov 2001 11:26:51 -0500
Received: from ns.caldera.de ([212.34.180.1]:40669 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S280832AbRKLQ0e>;
	Mon, 12 Nov 2001 11:26:34 -0500
Date: Mon, 12 Nov 2001 17:25:49 +0100
Message-Id: <200111121625.fACGPnq03210@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: kaos@ocs.com.au (Keith Owens)
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
To: dalecki@evision.ag
Subject: Re: PATCH 2.4.14 mregparm=3 compilation fixes
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <4300.1005581402@ocs3.intra.ocs.com.au>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <4300.1005581402@ocs3.intra.ocs.com.au> you wrote:
> Setting mregparm must be a CONFIG_ option, with a huge warning that
>
> A) Changing CONFIG_MREGPARM requires make mrproper.

The above patch changes the kernel to always use mregparm - 
it should be catched by the .flags depencies anyway.

> B) Loading binary only modules into a kernel compiled with mregparm is
>    even more likely to destroy your kernel.

Nope - people who uses those are just doomed.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
