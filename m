Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVDDGux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVDDGux (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 02:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVDDGux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 02:50:53 -0400
Received: from mx1.elte.hu ([157.181.1.137]:22701 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261209AbVDDGus (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 02:50:48 -0400
Date: Mon, 4 Apr 2005 08:50:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@engr.sgi.com>
Cc: kenneth.w.chen@intel.com, torvalds@osdl.org, nickpiggin@yahoo.com.au,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs [was: Re: Industry db benchmark result on recent 2.6 kernels]
Message-ID: <20050404065040.GB23312@elte.hu>
References: <200504020100.j3210fg04870@unix-os.sc.intel.com> <20050402145351.GA11601@elte.hu> <20050402215332.79ff56cc.pj@engr.sgi.com> <20050403070415.GA18893@elte.hu> <20050403043420.212290a8.pj@engr.sgi.com> <20050403071227.666ac33d.pj@engr.sgi.com> <20050403152413.GA26631@elte.hu> <20050403160807.35381385.pj@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050403160807.35381385.pj@engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Jackson <pj@engr.sgi.com> wrote:

> Would be a good idea to rename 'cpu_distance()' to something more 
> specific, like 'cpu_dist_ndx()', and reserve the generic name 
> 'cpu_distance()' for later use to return a scaled integer distance, 
> rather like 'node_distance()' does now. [...]

agreed - i've changed it to domain_distance() in my tree.

	Ingo
