Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285692AbRL3XoR>; Sun, 30 Dec 2001 18:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285724AbRL3XoH>; Sun, 30 Dec 2001 18:44:07 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:17678 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S285692AbRL3Xn4>; Sun, 30 Dec 2001 18:43:56 -0500
Date: Sun, 30 Dec 2001 15:46:13 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: Timothy Covell <timothy.covell@ashavan.org>,
        Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Balanced Multi Queue Scheduler ...
In-Reply-To: <200112302320.AAA10992@webserver.ithnet.com>
Message-ID: <Pine.LNX.4.40.0112301545030.934-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Dec 2001, Stephan von Krawczynski wrote:

> > On Sun, 30 Dec 2001, Timothy Covell wrote:
> >
> > > each CPU?   And this reminds me of how "make -j3 bzlilo" is slower
> than
> > > "make -j2 bzlilo".
> >
> > Running N CPU bound tasks on an M way SMP machine with N > M is
> never
> > going to improve your performace. On the contrary, expecially with
> the
> > current scheduler that keeps rotating the three tasks between the
> two
> > CPUs, you're going to suffer a slight performance degradation.
>
> And can you please post a patch for this?

http://www.xmailserver.org/linux-patches/mss-2.html#patches



- Davide


