Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284164AbRLKWo7>; Tue, 11 Dec 2001 17:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284168AbRLKWot>; Tue, 11 Dec 2001 17:44:49 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:17164 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S284153AbRLKWol>; Tue, 11 Dec 2001 17:44:41 -0500
Date: Tue, 11 Dec 2001 17:37:54 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IO degradation in 2.4.17-pre2 vs. 2.4.16
In-Reply-To: <Pine.LNX.4.21.0112031717020.19010-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.3.96.1011211173426.21150B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2001, Marcelo Tosatti wrote:

> Yes, throughtput-only tests will have their numbers degradated with the
> change applied on 2.4.16-pre2.
> 
> The whole thing is just about tradeoffs: Interactivity vs throughtput.
> 
> I'm not going to destroy interactivity for end users to get beatiful
> dbench numbers.
> 
> And about your clients: Don't you think they want some kind of
> decent latency on their side? 

It depends on the machine. For a server the thing you need to feed clients
is throughput. I don't see how feeding the data slower is going to be GOOD
for latency. Particularly servers which push a lot of data, like mail and
news or certain web sites, need to push it now.

Latency is more of an issue for end user machines.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

