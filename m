Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275232AbTHMPbr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 11:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275234AbTHMPbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 11:31:47 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:30399
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S275232AbTHMPbp
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 11:31:45 -0400
Date: Wed, 13 Aug 2003 11:31:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Tomas Szepe <szepe@pinerecords.com>, Adrian Bunk <bunk@fs.tum.de>,
       John Bradford <john@grabjohn.com>, Riley@Williams.Name,
       Linux-Kernel@vger.kernel.org
Subject: Re: [2.6 patch] let broken drivers depend on BROKEN{,ON_SMP}
Message-ID: <20030813153144.GA10579@gtf.org>
References: <20030731091525.GI12849@louise.pinerecords.com> <Pine.LNX.3.96.1030813104305.11041B-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030813104305.11041B-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 10:50:12AM -0400, Bill Davidsen wrote:
> On Thu, 31 Jul 2003, Tomas Szepe wrote:
> 
> > There are going to be a zillion drivers that don't compile by the
> > time 2.6.0 is released, which is precisely when lkml will see a whole
> > new wave of people willing to fix things so I really don't think
> > hiding the problems behind CONFIG_BROKEN or whatever is reasonable.
> 
> I can't follow your logic. This is now supposed to be a stable kernel, but
> you want to have a bunch of non-working drivers available to reduce
> confidence in it? If I have device X, why do you think I would need a
> driver less if it were marked BROKEN? A broken list would be a great
> starting point for people who are looking for something to do in 2.6.
> 
> If you get a bunch of compiler errors without a clear indication that the
> driver is known to have problems, it is more likely to produce a "Linux is
> crap" reaction. With the problems Windows is showing this week, I'd like
> to show Linux as the reliable alternative, not whatever MS is saying about
> hacker code this week.

The people who want Linux to be reliable won't be compiling their own
kernels, typically.  Because, the people that _do_ compile their own
kernels have sense enough to disable broken drivers :)  That's what Red
Hat, SuSE, and others do today.

	Jeff



