Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261297AbTCFXuk>; Thu, 6 Mar 2003 18:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261298AbTCFXuk>; Thu, 6 Mar 2003 18:50:40 -0500
Received: from mx12.arcor-online.net ([151.189.8.88]:52179 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id <S261297AbTCFXuj>; Thu, 6 Mar 2003 18:50:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Date: Sat, 8 Mar 2003 01:05:37 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0303060949120.7720-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0303060949120.7720-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030307000112.4C059FB45A@mx12.arcor-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06 Mar 03 18:55, Linus Torvalds wrote:
> The thing about wakeups is that it's an "illogical" place to give the
> bonus ("it's too late to give the server a bonus _now_, I wanted it when I
> went to sleep"), but it's the _trivial_ place to give it.
>
> It also (I'm convinced) is actually in the end exactly equivalent to
> giving the bonus at sleep time - in the steady state picture.

And anyway, on the first sleep there was no chance to measure the sleep_time, 
so there was no bonus to give.

Regards,

Daniel
