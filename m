Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277409AbRJOPhr>; Mon, 15 Oct 2001 11:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277551AbRJOPhh>; Mon, 15 Oct 2001 11:37:37 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:5400 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S277409AbRJOPhZ>; Mon, 15 Oct 2001 11:37:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: TreeWater Society Berlin
To: Chris Mason <mason@suse.com>
Subject: Re: mount hanging 2.4.12
Date: Mon, 15 Oct 2001 17:37:49 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <Pine.GSO.4.21.0110141231570.6026-100000@weyl.math.psu.edu> <2314290000.1003133922@tiny>
In-Reply-To: <2314290000.1003133922@tiny>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011015153750.16F46F89@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Chris,

I discovered some mount problems/hangs when playing with dvds,
so I gave your patch a try, but it does not apply properly on 
2.4.12. Can you shred some light on this:

drypatch -p1 < /home/hp/Downloads/linux/patch/fslock-2.4.12.dif
patching file fs/super.c
Hunk #2 succeeded at 324 with fuzz 2.
Hunk #3 succeeded at 372 with fuzz 2.
Hunk #4 FAILED at 626.
Hunk #5 FAILED at 639.
Hunk #6 FAILED at 666.
Hunk #7 FAILED at 677.
Hunk #8 FAILED at 783.
Hunk #9 FAILED at 800.
6 out of 9 hunks FAILED -- saving rejects to file fs/super.c.rej
patching file fs/buffer.c
Hunk #1 succeeded at 359 with fuzz 1.
patching file drivers/md/lvm.c
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.

Thanks in advance,
Hans-Peter
