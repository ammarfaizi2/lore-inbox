Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130051AbQJ0Ub7>; Fri, 27 Oct 2000 16:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129536AbQJ0Ubk>; Fri, 27 Oct 2000 16:31:40 -0400
Received: from [194.213.32.137] ([194.213.32.137]:1796 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130267AbQJ0Ub3>;
	Fri, 27 Oct 2000 16:31:29 -0400
Message-ID: <20001027194513.A1060@bug.ucw.cz>
Date: Fri, 27 Oct 2000 19:45:13 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <andrewm@uow.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] kernel/module.c (plus gratuitous rant)
In-Reply-To: <39F5830E.7963A935@uow.edu.au> <Pine.LNX.4.10.10010241353590.1743-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.10.10010241353590.1743-100000@penguin.transmeta.com>; from Linus Torvalds on Tue, Oct 24, 2000 at 01:55:56PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > if the person who sent you the -pre4 patch against module.c
> > had Cc:'ed this mailing list then your kernel would do
> > something useful when compiled with gcc-2.7.2.3.
> 
> It seems that gcc-2.7.2.3 is terminally ill. I'd rather change
> Documentation/Changes, and just document the fact.
> 
> These kinds of subtle work-arounds for gcc bugs are not really acceptable,
> nor is it worthwhile complaining when somebody does development with a gcc
> that is _not_ broken, and doesn't notice that some random gcc bug breaks
> the kernel for others.

Would it be possible to keep 2.7.2.3? You still need 2.7.2.3 to
reliably compile 2.0.X (and maybe even 2.2.all-but-latest?).
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
