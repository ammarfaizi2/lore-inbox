Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267575AbUHEFU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267575AbUHEFU1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 01:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267555AbUHEFT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 01:19:59 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:493 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S267550AbUHEFTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 01:19:51 -0400
Message-Id: <200408050520.i755K6503436@owlet.beaverton.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       kernel@kolivas.org, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.8-rc2-mm2 performance improvements (scheduler?) 
In-reply-to: Your message of "Wed, 04 Aug 2004 16:59:39 PDT."
             <239380000.1091663979@flay> 
Date: Wed, 04 Aug 2004 22:20:06 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Rick showed me schedstats graphs of the two ... it seems to have lower
    latency, does less rebalancing, fewer pull_tasks, etc, etc. Everything
    looks better ... he'll send them out soon, I think (hint, hint).

Okay, they're done. Here's the URL of the graphs:

    http://eaglet.rain.com/rick/linux/staircase/scase-vs-noscase.html

General summary: as Martin reported, we're seeing improvements in a number
of areas, at least with sdet.  The graphs as listed there represent stats
from four separate sdet runs run sequentially with an increasing load.
(We're trying to see if we can get the information from each run separately,
rather than the aggregate -- one of the hazards of an automated test
harness :)

Rick
