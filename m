Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274258AbRISXH3>; Wed, 19 Sep 2001 19:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274257AbRISXHW>; Wed, 19 Sep 2001 19:07:22 -0400
Received: from Expansa.sns.it ([192.167.206.189]:8964 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S274256AbRISXHO>;
	Wed, 19 Sep 2001 19:07:14 -0400
Date: Thu, 20 Sep 2001 01:04:21 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Jan Niehusmann <jan@gondor.com>
cc: Liakakis Kostas <kostas@skiathos.physics.auth.gr>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Re[2]: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <20010919165503.A16359@gondor.com>
Message-ID: <Pine.LNX.4.33.0109200100380.25500-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Sep 2001, Jan Niehusmann wrote:

> On Wed, Sep 19, 2001 at 05:31:36PM +0300, Liakakis Kostas wrote:
> > It seems to fix the stability problem. We don;t know why, but
> > experimetation shows that those _with_ the problem are relieved. This is
> > fine! We are happy with it.
> >
> > We write to a register marked as "don't write" by Via. This is potentialy
> > dangerous in ways we don't know yet.
>
> Additionally, look at who tested the 'fix' up to now: Probably only
> people who had a problem before. And for all of them, the problem got
> fixed. But do we know what happens if we use this 'fix' on a computer
> that is not broken? No. Perhaps it breaks when we apply the 'fix'?
No, it won't break.  I tried this patch on an Athlon 1300 Mhz 200 FSB,
that has worked with athlon optimizzed kernels without any problems, and
it still works. I did this just for curiosity, and i was
avoiding to post a long series of it works for me too, since I have just
abit MBs, and before the patch was out I just putted a working bios on
every MB.  Anyway I tried the patch on working Athlon.

And let's try to get VIA to tell us what is going on....

bests
Luigi


