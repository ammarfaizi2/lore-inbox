Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030443AbVLWF6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030443AbVLWF6k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 00:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030437AbVLWF6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 00:58:40 -0500
Received: from fsmlabs.com ([168.103.115.128]:15545 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1030423AbVLWF6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 00:58:39 -0500
X-ASG-Debug-ID: 1135317511-20007-9-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Thu, 22 Dec 2005 22:03:53 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Keith Owens <kaos@sgi.com>
cc: Bill Davidsen <davidsen@tmr.com>, Lee Revell <rlrevell@joe-job.com>,
       "Luck, Tony" <tony.luck@intel.com>, Tony Luck <tony.luck@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jack Steiner <steiner@sgi.com>,
       Dimitri Sivanich <sivanich@sgi.com>
X-ASG-Orig-Subj: Re: [PATCH] ia64: disable preemption in udelay() 
Subject: Re: [PATCH] ia64: disable preemption in udelay() 
In-Reply-To: <8270.1135296864@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.64.0512222202190.3822@montezuma.fsmlabs.com>
References: <8270.1135296864@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.6567
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Dec 2005, Keith Owens wrote:

> Agreed.  See [RFC] Add thread_info flag for "no cpu migration"[1] on
> lkml.  It got no response.
> 
> [1] http://marc.theaimsgroup.com/?l=linux-kernel&m=113471059115107&w=2

I read it and it would make fixing cpuhotplug + cpufreq also easier. 
However you could also argue that the whole locking in cpufreq should be 
fixed instead.
