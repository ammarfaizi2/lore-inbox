Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275229AbTHMPNI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 11:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275232AbTHMPNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 11:13:08 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:7943 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S275229AbTHMPNF
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 11:13:05 -0400
Date: Wed, 13 Aug 2003 10:50:12 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Tomas Szepe <szepe@pinerecords.com>
cc: Adrian Bunk <bunk@fs.tum.de>, John Bradford <john@grabjohn.com>,
       Riley@Williams.Name, Linux-Kernel@vger.kernel.org
Subject: Re: [2.6 patch] let broken drivers depend on BROKEN{,ON_SMP}
In-Reply-To: <20030731091525.GI12849@louise.pinerecords.com>
Message-ID: <Pine.LNX.3.96.1030813104305.11041B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jul 2003, Tomas Szepe wrote:

> There are going to be a zillion drivers that don't compile by the
> time 2.6.0 is released, which is precisely when lkml will see a whole
> new wave of people willing to fix things so I really don't think
> hiding the problems behind CONFIG_BROKEN or whatever is reasonable.

I can't follow your logic. This is now supposed to be a stable kernel, but
you want to have a bunch of non-working drivers available to reduce
confidence in it? If I have device X, why do you think I would need a
driver less if it were marked BROKEN? A broken list would be a great
starting point for people who are looking for something to do in 2.6.

If you get a bunch of compiler errors without a clear indication that the
driver is known to have problems, it is more likely to produce a "Linux is
crap" reaction. With the problems Windows is showing this week, I'd like
to show Linux as the reliable alternative, not whatever MS is saying about
hacker code this week.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

