Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315236AbSEQAku>; Thu, 16 May 2002 20:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315237AbSEQAkt>; Thu, 16 May 2002 20:40:49 -0400
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:59266 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id <S315236AbSEQAkt>; Thu, 16 May 2002 20:40:49 -0400
Date: Thu, 16 May 2002 20:40:44 -0400 (EDT)
From: Paul Faure <paul@engsoc.org>
X-X-Sender: <paul@lager.engsoc.carleton.ca>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: Process priority in 2.4.18 (RedHat 7.3)
In-Reply-To: <20020516215744.GI1025@dualathlon.random>
Message-ID: <Pine.LNX.4.33.0205162037500.21864-100000@lager.engsoc.carleton.ca>
X-Home-Page: http://www.engsoc.org/
X-URL: http://www.engsoc.org/
Organisation: Engsoc Project (www.engsoc.org)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would seem that it only occurs when running the application (that takes
100% of the CPU) as root.

As for testing it with other cards, I only have this one card.

Thanks for your time... its not a big issue now since I can run my
application as a non privileged user.

On Thu, 16 May 2002, Andrea Arcangeli wrote:

> On Thu, May 16, 2002 at 02:06:10PM -0700, Andrew Morton wrote:
> > of transmit attempts and is relying on ksoftirqd to transmit.
> 
> ksoftirqd or not the softirq are guaranteed to keep running even if
> there's a task in loop with SCHED_FIFO, ksoftirqd only enhance/polish
> the case of a recursive softirq, or a very big flood of softirq events,
> it is not required to run softirqs.
> 
> Andrea
> 

-- 
Paul N. Faure					613.266.3286
EngSoc Administrator            		paul-at-engsoc-dot-org
Chief Technical Officer, CertainKey Inc.	paul-at-certainkey-dot-com
Carleton University Systems Eng. 4th Year	paul-at-faure-dot-ca

