Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271550AbRHULRv>; Tue, 21 Aug 2001 07:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271551AbRHULRm>; Tue, 21 Aug 2001 07:17:42 -0400
Received: from [213.171.56.2] ([213.171.56.2]:62476 "EHLO mail.ixcelerator.com")
	by vger.kernel.org with ESMTP id <S271550AbRHULRX>;
	Tue, 21 Aug 2001 07:17:23 -0400
Date: Tue, 21 Aug 2001 15:18:11 +0400
Message-Id: <200108211118.f7LBIBZ28931@morgoth.ixcelerator.com>
From: green@linuxhacker.ru
To: _deepfire@mail.ru, linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 - still dies. [ was Re: 2.4.8/2.4.8-ac7 sound crashes ]
In-Reply-To: <E15Z68k-000O9c-00@f5.mail.ru>
X-Newsgroups: linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.9 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E15Z68k-000O9c-00@f5.mail.ru> you wrote:
>      2.4.9 still dies, although i nearly thought
>   it was ok, because it survived alot longer:
>   around 15-20 minutes.
Still you need to obtain oops/panic dump, decode it and post here,
otherwise nobody can help. And other people seem to have troubles reproducing
this report.
You can obtain oops output using serial console.
Or you can modify linux/arch/i386/kernel/traps.c::show_trace() to stop
after printing first oops and write that down to the piece of paper.

Bye,
    Oleg
