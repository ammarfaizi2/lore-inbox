Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289106AbSAGDpY>; Sun, 6 Jan 2002 22:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289107AbSAGDpF>; Sun, 6 Jan 2002 22:45:05 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:43534 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S289106AbSAGDpD>; Sun, 6 Jan 2002 22:45:03 -0500
Date: Sun, 6 Jan 2002 19:49:09 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Richard Henderson <rth@twiddle.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <Pine.LNX.4.33.0201061930250.5900-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.40.0201061948390.1000-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002, Linus Torvalds wrote:

>
> On Sun, 6 Jan 2002, Davide Libenzi wrote:
> >
> > 32 bit words lookup can be easily done in few clock cycles in most cpus
> > by using tuned assembly code.
>
> I tried to time "bsfl", it showed up as one cycle more than "nothing" on
> my PII.
>
> It used to be something like 7+n cycles on a i386, if I remember
> correctly. It's just not an issue any more - trying to use clever code to
> avoid it is just silly.

I think the issue was about architectures that does not have bsfl like ops



- Davide


