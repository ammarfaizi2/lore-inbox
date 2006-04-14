Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbWDNWTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbWDNWTS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 18:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbWDNWTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 18:19:18 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:14809 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030211AbWDNWTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 18:19:17 -0400
Date: Fri, 14 Apr 2006 18:19:14 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 00/05] robust per_cpu allocation for modules
In-Reply-To: <4t16i2$ma94t@orsmga001.jf.intel.com>
Message-ID: <Pine.LNX.4.58.0604141817540.18473@gandalf.stny.rr.com>
References: <4t16i2$ma94t@orsmga001.jf.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Apr 2006, Chen, Kenneth W wrote:

> Steven Rostedt wrote on Friday, April 14, 2006 2:19 PM
> > So the current solution has two flaws:
> > 1. not robust. If we someday add more modules that together take up
> >    more than 14K, we need to manually update the PERCPU_ENOUGH_ROOM.
> > 2. waste of memory.  We have 14K of memory wasted per CPU. Remember
> >    a 64 processor machine would be wasting 896K of memory!
>
> If someone who has the money to own a 64-process machine, 896K of memory
> is pocket change ;-)
>

I was waiting for someone to make that comment :)

But someone who has the money to own a 64-processor machine, is probably
also a penny pincher, and wants to hold on to their pocket change ;-)

-- Steve

