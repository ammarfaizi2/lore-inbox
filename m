Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264732AbRFSTUI>; Tue, 19 Jun 2001 15:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264737AbRFSTT6>; Tue, 19 Jun 2001 15:19:58 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43793 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264732AbRFSTTp>; Tue, 19 Jun 2001 15:19:45 -0400
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
To: ahu@ds9a.nl (bert hubert)
Date: Tue, 19 Jun 2001 20:18:59 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <20010619211038.A3704@home.ds9a.nl> from "bert hubert" at Jun 19, 2001 09:10:38 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15CR1f-0006Wh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Which clearly marks you as a typical kernel-side developer :-) It never
> ceases to amaze me how different a userland perspective can be from that of
> people who live in kernel space.

I've been writing multiuser games since 1987. I'm not just a kernel hacker

> But that foregoes the point that the code is far more complex and harder to
> make 'obviously correct', a concept that *does* translate well to userspace.

There I disagree. Threads introduce parallelism that the majority of user
space programmers have trouble getting right (not that C is helpful here).

A threaded program has a set of extremely complex hard to repeat timing based
behaviour dependancies. An unthreaded app almost always does the same thing on
the same input. From a verification and coverage point of view that is 
incredibly important.

Alan

