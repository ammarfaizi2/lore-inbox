Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284755AbRL3UQX>; Sun, 30 Dec 2001 15:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284765AbRL3UQO>; Sun, 30 Dec 2001 15:16:14 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:17932 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284755AbRL3UP7>; Sun, 30 Dec 2001 15:15:59 -0500
Date: Sun, 30 Dec 2001 12:16:50 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Timothy Covell <timothy.covell@ashavan.org>
cc: Stephan von Krawczynski <skraw@ithnet.com>,
        Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Balanced Multi Queue Scheduler ...
In-Reply-To: <200112301951.fBUJoxSr011753@svr3.applink.net>
Message-ID: <Pine.LNX.4.40.0112301212540.935-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Dec 2001, Timothy Covell wrote:

> each CPU?   And this reminds me of how "make -j3 bzlilo" is slower than
> "make -j2 bzlilo".

Running N CPU bound tasks on an M way SMP machine with N > M is never
going to improve your performace. On the contrary, expecially with the
current scheduler that keeps rotating the three tasks between the two
CPUs, you're going to suffer a slight performance degradation.



- Davide


