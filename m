Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312818AbSCZXKj>; Tue, 26 Mar 2002 18:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312803AbSCZXK3>; Tue, 26 Mar 2002 18:10:29 -0500
Received: from louise.pinerecords.com ([212.71.160.16]:14084 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S312818AbSCZXKT>; Tue, 26 Mar 2002 18:10:19 -0500
Date: Tue, 26 Mar 2002 23:56:54 +0100 (CET)
From: tomas szepe <kala@pinerecords.com>
To: Bill Davidsen <davidsen@tmr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 SPARC SMP oops
In-Reply-To: <Pine.LNX.3.96.1020326173956.9836A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0203262349190.417-100000@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


> > The following oops is more-or-less-deterministically reproducible
> > on my dual-processor SPARCstation 10 with 160MB RAM. It tends to send
> > the system down under heavy load caused by either sendmail/procmail
> > or apache. I first came across the bug at around 2.4.17, though it's
> > probably been lurking in the kernel much longer. I've gone through
> > quite a bit of trouble attempting to get the oops barf at me in 2.2.x
> > in case it's my hw config that's behind the whole problem, but I haven't
> > run into any breakdowns, 2.2.21-rc2 included.
> Assuming that you can handle your load, at least briefly, with a single
> CPU, have you tried booting with 'nosmp' on this machine? A serious test
> would build without SMP to get the whole locking stuff to go away, but
> this is quick and dirty.

Right, good point. I'll boot the machine nosmp and try to reproduce the
oops over the weekend.

> I'm convinced that there are evils still lurking in SMP after all these
> years.

trouble is, I have no idea whether the bug is present in earlier
2.4 kernels as well without me noticing, or if it's a relatively
new thing (Sure I could check, but it's not like I can reproduce
the oops in under an hour or so of trying: that's what I meant by
"more-or-less-deterministically" :D).


T.

pub 1024d/8e316a84 2002-01-29   tomas szepe <kala@pinerecords.com>
openpgp f/print 2955 2eea c4b8 b09e 7ae1  4d5d 68e3 d606 8e31 6a84

