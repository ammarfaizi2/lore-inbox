Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281283AbRLABD3>; Fri, 30 Nov 2001 20:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281289AbRLABDT>; Fri, 30 Nov 2001 20:03:19 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:51974 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S281283AbRLABDK>; Fri, 30 Nov 2001 20:03:10 -0500
Date: Fri, 30 Nov 2001 17:13:38 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Larry McVoy <lm@bitmover.com>
cc: Andrew Morton <akpm@zip.com.au>, Daniel Phillips <phillips@bonn-fries.net>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
In-Reply-To: <20011130155740.I14710@work.bitmover.com>
Message-ID: <Pine.LNX.4.40.0111301636010.1600-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2001, Larry McVoy wrote:

[ A lot of stuff Pro-Sun ]

Wait a minute.
Wasn't it you that were screaming against Sun, leaving their team because
their SMP decisions about scaling sucked, because their OS was bloated
like hell with sync spinlocks, saying that they tried to make it scale but
they failed miserably ?
What is changed now to make Solaris, a fairly vanishing OS, to be the
reference OS/devmodel for every kernel developer ?
Wasn't it you that were saying that Linux will never scale with more than
2 CPUs ?
Isn't Linux SMP improved from the very first implementation ?
Isn't Linux SMP improved from the very first implementation w/out losing
reliability ?
Why you don't try to compare 2.0.36 with 2.4.x let's say on a 8 way SMP ?
Why should it stop improving ?
Because you know that adding fine grained spinlocks will make the OS
complex to maintain and bloated ... like it was Solaris before you
suddendly changed your mind.


<YOUR QUOTE>
>     Then people want more performance.  So they thread some more and now
>     the locks aren't 1:1 to the objects.  What a lock covers starts to
>     become fuzzy.  Thinks break down quickly after this because what
>     happens is that it becomes unclear if you are covered or not and
>     it's too much work to figure it out, so each time a thing is added
>     to the kernel, it comes with a lock.  Before long, your 10 or 20
>     locks are 3000 or more like what Solaris has.  This is really bad,
>     it hurts performance in far reaching ways and it is impossible to
>     undo.
</YOUR QUOTE>

I kindly agree with this, just curious to understand which kind of amazing
architectural solution Solaris took to be a reference for SMP
development/scaling.




- Davide






