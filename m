Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129652AbQLVT4r>; Fri, 22 Dec 2000 14:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129944AbQLVT4i>; Fri, 22 Dec 2000 14:56:38 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:45061 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129652AbQLVT4W>; Fri, 22 Dec 2000 14:56:22 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: recommended gcc compiler version
Date: 22 Dec 2000 11:25:14 -0800
Organization: Transmeta Corporation
Message-ID: <9209qq$7pf$1@penguin.transmeta.com>
In-Reply-To: <0012212320430F.02217@comptechnews> <E149NvR-0004Kz-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E149NvR-0004Kz-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>
>2.4.0test
>	egcs-1.1.2
>	(gcc 2.95 miscompiles some of the long long uses)
>	Red Hat's 2.96 seems to generate valid kernels but don't expect
>		sympathy if you report a bug in one built that way

Now, now, I'd love to se reports of expecially the new updated compiler. 
I've not actually seen a single report of problems for the kernel even
with the old 2.96, it's just that I've seen too many user-space problems
that I would be hesitant to use it for the kernel. 

Despite my dislike of releasing snaopshot compilers, I'd _much_ rather
see Red Hat just dropping their "kgcc" thing, and in order to do that
people do ned to test with the new compiler. 

I just want people to mention the fact, so that I can correlate any
bug-reports with a compiler version. Just in case. It can be important
(and not just because of compiler bugs, but due to real kernel bugs that
just were hidden by pure luck with other compilers). And it helps a LOT
if you have another compiler available to compare with.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
