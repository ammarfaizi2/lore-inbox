Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267677AbUHEOPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267677AbUHEOPN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 10:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267731AbUHEOOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 10:14:23 -0400
Received: from mx2.elte.hu ([157.181.151.9]:26578 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267725AbUHEOKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 10:10:17 -0400
Date: Thu, 5 Aug 2004 12:45:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       kernel@kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm2 performance improvements (scheduler?)
Message-ID: <20040805104537.GA20466@elte.hu>
References: <239380000.1091663979@flay> <200408050520.i755K6503436@owlet.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408050520.i755K6503436@owlet.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rick Lindsley <ricklind@us.ibm.com> wrote:

> Okay, they're done. Here's the URL of the graphs:
> 
>     http://eaglet.rain.com/rick/linux/staircase/scase-vs-noscase.html
> 
> General summary: as Martin reported, we're seeing improvements in a
> number of areas, at least with sdet.  The graphs as listed there
> represent stats from four separate sdet runs run sequentially with an
> increasing load. (We're trying to see if we can get the information
> from each run separately, rather than the aggregate -- one of the
> hazards of an automated test harness :)

really nice results! Would be interesting to see the effect of Con's
patch on other SMP/NUMA workloads as well - i'd expect to see an
improvement there too. The test was done with the default interactive=1
compute=0 setting, right?

	Ingo
