Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262668AbVBYKuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbVBYKuL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 05:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262670AbVBYKuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 05:50:10 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:10627 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262668AbVBYKuF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 05:50:05 -0500
Message-Id: <200502251050.j1PAo6QK008040@owlet.beaverton.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/13] rework schedstats 
In-reply-to: Your message of "Thu, 24 Feb 2005 18:18:10 +1100."
             <1109229491.5177.71.camel@npiggin-nld.site> 
Date: Fri, 25 Feb 2005 02:50:06 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I have an updated userspace parser for this thing, if you are still
    keeping it on your website.

Sure, be happy to include it, thanks!  Send it along.  Is it for version
11 or version 12?

    Move balancing fields into struct sched_domain, so we can get more
    useful results on systems with multiple domains (eg SMT+SMP, CMP+NUMA,
    SMP+NUMA, etc).

It looks like you've also removed the stats for pull_task() and
wake_up_new_task().  Was this intentional, or accidental?

I can't quite get the patch to apply cleanly against several variants
of 2.6.10 or 2.6.11-rc*.  Which version is the patch for?

Rick
