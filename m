Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268277AbTCFSWM>; Thu, 6 Mar 2003 13:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268290AbTCFSWM>; Thu, 6 Mar 2003 13:22:12 -0500
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:10634
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S268277AbTCFSWL>; Thu, 6 Mar 2003 13:22:11 -0500
Date: Thu, 6 Mar 2003 13:06:59 -0500 (EST)
From: "Dimitrie O. Paun" <dimi@intelliware.ca>
X-X-Sender: dimi@dimi.dssd.ca
To: Ingo Molnar <mingo@elte.hu>
cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@transmeta.com>,
       Andrew Morton <akpm@digeo.com>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <Pine.LNX.4.44.0303061814080.14035-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303061304230.23356-100000@dimi.dssd.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep02-mail.bloor.is.net.cable.rogers.com from [24.103.156.204] using ID <dpaun@rogers.com> at Thu, 6 Mar 2003 13:32:19 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Mar 2003, Ingo Molnar wrote:

> yes, an ELF flag might work, or my suggestion to allow applications to
> increase their priority (up until a certain degree).

An ELF flag might be better, as it's declarative -- it allows the kernel
to implement 'interactivity' in various ways, so we can keep tweeking it.
Priority might prove to be a bit different than interactivity, so we
better not overload the two just yet.

-- 
Dimi.

