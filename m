Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286949AbSAFCM6>; Sat, 5 Jan 2002 21:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286938AbSAFCMv>; Sat, 5 Jan 2002 21:12:51 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:45320 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286949AbSAFCMU>; Sat, 5 Jan 2002 21:12:20 -0500
Date: Sat, 5 Jan 2002 18:17:06 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <E16N2vX-00023B-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0201051816470.1607-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002, Alan Cox wrote:

> > > then it represents a huge win since an 8bit ffz can be done by lookup table
> > > and that is fast on all processors
> >
> > It's here that i want to go, but i'd liketo do it gradually :)
> > unsigned char first_bit[255];
>
> Make it [256] and you can do 9 queues since the idle task will always
> be queued...

Mistyping error :)



- Davide


