Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261632AbTCGP3o>; Fri, 7 Mar 2003 10:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261634AbTCGP3o>; Fri, 7 Mar 2003 10:29:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:16527 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261632AbTCGP3n>;
	Fri, 7 Mar 2003 10:29:43 -0500
Message-Id: <5.2.0.9.2.20030307164223.00c7de70@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Fri, 07 Mar 2003 16:44:50 +0100
To: Ingo Molnar <mingo@elte.hu>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] "interactivity changes", sched-2.5.64-B2
Cc: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303071543480.12493-100000@localhost.localdo
 main>
References: <Pine.LNX.4.44.0303071049500.7326-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:45 PM 3/7/2003 +0100, Ingo Molnar wrote:

>btw., could you please revert the kernel/softirq.c change, and re-test
>-j25 interactivity with that patch? That way we'll know exactly which
>component of -B2 caused the improvement on your box.

Done.  If either the softirq.c change or changing WAKER_BONUS_RATIO value 
(25:50:75) make any difference at all with what I'm doing, it's too close 
for me to tell.

         -Mike

