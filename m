Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130835AbQK2STU>; Wed, 29 Nov 2000 13:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131774AbQK2STK>; Wed, 29 Nov 2000 13:19:10 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:31751 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S130835AbQK2SSx>; Wed, 29 Nov 2000 13:18:53 -0500
Date: Wed, 29 Nov 2000 09:47:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <UTC200011291116.MAA147726.aeb@aak.cwi.nl>
Message-ID: <Pine.LNX.4.10.10011290940070.11951-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Nov 2000 Andries.Brouwer@cwi.nl wrote:
>
> > can you give a rough estimate on when you suspect you started seeing it?
> 
> I reported both cases. That is, I started seeing it a few days ago.

I wasn't trying to imply that you hadn't reported them well.

It's just that I was born with a highly developed case of Altzheimers, and
I have trouble keeping details around in my head for more than about five
minutes.

I'm half serious, btw. It's not that I don't have a good memory, but I
tend to remember patterns and how things work, and I'm _really_ bad at
keeping track of details. This is why I absolutely depend on people like
Alan Cox etc who maintain lists of problems, and who are good at gathering
reports on what kinds of machines see it etc. I just suck at it. I really
do.

Anyway, it tentatively sounds like it might have been request corruption
by the new re-merge code. It fits the details, you having IDE and all. I
see that you can't at least easily reproduce it in pre3 any more, but if
it turns out later that you still can, please holler. Loudly.

That still leaves the SCSI corruption, which could not have been due to
the request issue. What's the pattern there for people?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
