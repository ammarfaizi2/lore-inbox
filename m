Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWAEQXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWAEQXU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 11:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWAEQXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 11:23:20 -0500
Received: from ns2.suse.de ([195.135.220.15]:53695 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751469AbWAEQXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 11:23:19 -0500
From: Andi Kleen <ak@suse.de>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Moore's law (was Re: [patch 0/9] mutex subsystem, -V4)
Date: Thu, 5 Jan 2006 16:30:59 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20051222114147.GA18878@elte.hu> <20051225150445.0eae9dd7.akpm@osdl.org> <20051226003313.GB2440@ucw.cz>
In-Reply-To: <20051226003313.GB2440@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601051631.00146.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 December 2005 01:33, Pavel Machek wrote:

[cc list from hell trimmed down]

> > Another example: Ingo's VFS stresstest which is hitting i_sem hard: it only
> > does ~8000 ops/sec on an 8-way, and it's an artificial microbenchmark which
> > is _designed_ to hit that lock hard.  So if/when i_sem is converted to a
> > mutex, I figure that the benefits to ARM in that workload will be about a
> > 0.01% performance increase.  ie: about two hours' worth of Moore's law in a
> > dopey microbenchmark.

Moore's law actually doesn't say anything about performance increases,
just about the number of transistors available.
> 
> :-) Expressing performance increases in Moore's hours seems like
> neat trick. OTOH I do not think it is valid any more. Single-threaded
> performance stopped increasing 2 years ago AFAICS.

It's not true. e.g. a 2.6 Ghz FX-57 is significantly faster than the
top end CPU you could get 2 years ago. And I'm sure this years CPUs
will be still faster than last years.

> Plus people are 
> pushing Linux onto smaller machines, that were unavailable 2 years
> ago.

Even smaller systems are still getting faster.

-Andi
