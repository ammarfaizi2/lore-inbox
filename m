Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264356AbTL3CxR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 21:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264361AbTL3CxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 21:53:17 -0500
Received: from [24.35.117.106] ([24.35.117.106]:38283 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264356AbTL3CxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 21:53:14 -0500
Date: Mon, 29 Dec 2003 21:53:13 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
In-Reply-To: <Pine.LNX.4.58.0312292020190.6227@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0312292147330.6639@localhost.localdomain>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain>
 <Pine.LNX.4.58.0312292020190.6227@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Under 2.6 top shows:
> > user	nice	system	irq	softirq	iowait	idle
> > 0.9	0	5.3	0.9	0.3	92.6	0
> > 
> > Execution time for the test was:
> > real	22m42.397s
> > user	0m37.753s
> > sys	0m54.043s
> 
> 
> Changing 2.6 to 8 from 255 changed times:
> 
> real    25m39.653s
> user    0m37.594s
> sys     0m55.454s

Changing readahead to 8192 increased the real time to 28 minutes and left 
the user and sys times essentially unchanged.

I've recompiled with profiling support.  I'll give an update on that when 
I can.
