Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275512AbTHMV2r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 17:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275516AbTHMV21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 17:28:27 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:51975 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S275512AbTHMV1f
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 17:27:35 -0400
Date: Wed, 13 Aug 2003 17:06:06 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Tomas Szepe <szepe@pinerecords.com>, Adrian Bunk <bunk@fs.tum.de>,
       John Bradford <john@grabjohn.com>, Riley@Williams.Name,
       Linux-Kernel@vger.kernel.org
Subject: Re: [2.6 patch] let broken drivers depend on BROKEN{,ON_SMP}
In-Reply-To: <20030813153144.GA10579@gtf.org>
Message-ID: <Pine.LNX.3.96.1030813165635.12417K-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Aug 2003, Jeff Garzik wrote:

> On Wed, Aug 13, 2003 at 10:50:12AM -0400, Bill Davidsen wrote:

> > If you get a bunch of compiler errors without a clear indication that the
> > driver is known to have problems, it is more likely to produce a "Linux is
> > crap" reaction. With the problems Windows is showing this week, I'd like
> > to show Linux as the reliable alternative, not whatever MS is saying about
> > hacker code this week.
> 
> The people who want Linux to be reliable won't be compiling their own
> kernels, typically.  Because, the people that _do_ compile their own
> kernels have sense enough to disable broken drivers :)  That's what Red
> Hat, SuSE, and others do today.

Disabling broken drivers is fine, identifying them is nice, too. When I
was deciding which gigE cards to use, I found that all drivers in the 2.4
kernel were not equal. Some didn't compile with my config, some compiled
but had runtime problems, etc.

It would be nice if there were some neat 3-D shreadsheet type thing
listing all drivers, all architectures, UP vs. SMP, and a status such as
WORKS, DOESN'T COMPILE, REPORTED PROBLEMS (SLOW|ERRORS|PANICS) and the
like. I don't even know where to find a good open source 3-D spreadsheet,
and the data certainly is scattered enough to be a project in itself,
chasing a moving target.

A BROKEN config isn't a perfect solution (fixing the drivers is), but it
would help in some cases, and I don't see that it would hurt, and more
information is usually better.

Not my original idea, my ego won't be hurt if it doesn't happen.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

