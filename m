Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317482AbSFRQfV>; Tue, 18 Jun 2002 12:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317483AbSFRQfU>; Tue, 18 Jun 2002 12:35:20 -0400
Received: from [212.3.242.3] ([212.3.242.3]:62715 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id <S317482AbSFRQfU>;
	Tue, 18 Jun 2002 12:35:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: DevilKin <devilkin-lkml@blindguardian.org>
To: root@chaos.analogic.com
Subject: Re: VMM - freeing up swap space
Date: Tue, 18 Jun 2002 18:32:55 +0200
User-Agent: KMail/1.4.1
References: <Pine.LNX.3.95.1020618110445.3808A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1020618110445.3808A-100000@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206181832.55655.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 June 2002 17:10, Richard B. Johnson wrote:
> On Tue, 18 Jun 2002, Gregory Giguashvili wrote:
> > Hello,
> >
> > Running an application allocating huge amounts of memory would push some
> > data from RAM to swap area. After the application terminates, swap area
> > is usually still occupied.
> >
> > Is there any way to clean up the swap area by pushing the data back to
> > RAM?
> >
> > Thanks in advance
> > Giga
>
> Sure. Execute `swapoff -a`, followed by `swapon -a`. This is no joke.

Hmm. Now if you happen to get out of memory during the swapoff part, you'll 
get the OO killer on your tail? Or will the system just go freeze solid?

Just a small question.

DK
-- 
Reclaimer, spare that tree!
Take not a single bit!
It used to point to me,
Now I'm protecting it.
It was the reader's CONS
That made it, paired by dot;
Now, GC, for the nonce,
Thou shalt reclaim it not.

