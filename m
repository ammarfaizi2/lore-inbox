Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266914AbUGVTNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266914AbUGVTNQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 15:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266913AbUGVTLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 15:11:54 -0400
Received: from peabody.ximian.com ([130.57.169.10]:12425 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266914AbUGVTKp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 15:10:45 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Robert Love <rml@ximian.com>
To: Scott Wood <scott@timesys.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Andrew Morton <akpm@osdl.org>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
In-Reply-To: <20040722183618.GB4774@yoda.timesys>
References: <20040719102954.GA5491@elte.hu>
	 <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org>
	 <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe>
	 <20040721082218.GA19013@elte.hu> <20040721183010.GA2206@yoda.timesys>
	 <20040721184308.GA27034@elte.hu> <20040722023235.GB3298@yoda.timesys>
	 <20040722095111.GA13125@elte.hu>  <20040722183618.GB4774@yoda.timesys>
Content-Type: text/plain
Date: Thu, 22 Jul 2004 15:11:35 -0400
Message-Id: <1090523495.7584.39.camel@lucy>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-22 at 14:36 -0400, Scott Wood wrote:

> This is assuming that a high-priority non-RT task will always preempt
> a lower priority task except when it has depleted its timeslice; I'm
> not familiar enough with the current scheduler to know whether that
> is the case.

Yes, this is the basic scheduling rule for non-RT: the highest priority
task, with timeslice remaining, runs.

	Robert Love


