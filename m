Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312773AbSCZWpJ>; Tue, 26 Mar 2002 17:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312783AbSCZWpA>; Tue, 26 Mar 2002 17:45:00 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:18703 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S312773AbSCZWoq>; Tue, 26 Mar 2002 17:44:46 -0500
Date: Tue, 26 Mar 2002 17:42:28 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: tomas szepe <kala@pinerecords.com>
cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 SPARC SMP oops
In-Reply-To: <Pine.LNX.4.44.0203262128370.417-100000@louise.pinerecords.com>
Message-ID: <Pine.LNX.3.96.1020326173956.9836A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2002, tomas szepe wrote:

> Hi David and everybody else on lkml,
> 
> 
> The following oops is more-or-less-deterministically reproducible
> on my dual-processor SPARCstation 10 with 160MB RAM. It tends to send
> the system down under heavy load caused by either sendmail/procmail
> or apache. I first came across the bug at around 2.4.17, though it's
> probably been lurking in the kernel much longer. I've gone through
> quite a bit of trouble attempting to get the oops barf at me in 2.2.x
> in case it's my hw config that's behind the whole problem, but I haven't
> run into any breakdowns, 2.2.21-rc2 included.

Assuming that you can handle your load, at least briefly, with a single
CPU, have you tried booting with 'nosmp' on this machine? A serious test
would build without SMP to get the whole locking stuff to go away, but
this is quick and dirty.

I'm convinced that there are evils still lurking in SMP after all these
years.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

