Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261273AbTCGA2b>; Thu, 6 Mar 2003 19:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261300AbTCGA2b>; Thu, 6 Mar 2003 19:28:31 -0500
Received: from fep04-mail.bloor.is.net.cable.rogers.com ([66.185.86.74]:21025
	"EHLO fep04-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S261273AbTCGA2a>; Thu, 6 Mar 2003 19:28:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: "Dimitrie O. Paun" <dpaun@rogers.com>
Reply-To: dpaun@rogers.com
Organization: DSSD Software Inc.
To: Linus Torvalds <torvalds@transmeta.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Date: Thu, 6 Mar 2003 19:09:38 -0500
User-Agent: KMail/1.4.3
Cc: digitale@digitaleric.net, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@digeo.com>,
       <rml@tech9.net>, <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0303061554250.9387-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0303061554250.9387-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303061909.38688.dpaun@rogers.com>
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep04-mail.bloor.is.net.cable.rogers.com from [24.103.156.204] using ID <dpaun@rogers.com> at Thu, 6 Mar 2003 19:38:59 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 6, 2003 07:02 pm, Linus Torvalds wrote:
> Btw, "success" is often "being good enough". We shouldn't _suck_, but you
> should always remember the old "perfect is the enemy of good" thing.
> Trying to get perfect behaviour under some circumstances often means that
> you suck under others, and then the right answer is usually not to try to
> be so damn perfect, but "just being good".

Very much so! I can not agree more with you that the lack of a default
good policy is stupid -- this is why X was in such a bad state for years!
I could write pages on this subject, but I'm glad other people share my
ideas in this matter :)

That being said, I have nothing against an automatic algorithm. If we can
get that one to do what we want, there's obviously no need for knobs. All
I'm saying is that *if* there are cases where we need help, we should not
have to tweak the priority of a process, but create a different knob.
Priority is a different beast from interactivity. For example, it's clear
that good interactive behaviour _requires_ information only available in
the kernel. Which makes the interactivity know (if at all required) more
of a hint rather than a set in stone thing like the priority.

But I guess all this is academic. If the automatic stuff just works, 
we're better off anyway.

-- 
Dimi.

