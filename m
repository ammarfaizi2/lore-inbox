Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbUJWUlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbUJWUlp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 16:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbUJWUgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 16:36:36 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:4971 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S261265AbUJWUeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 16:34:23 -0400
Date: Sat, 23 Oct 2004 13:29:17 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, karim@opersys.com,
       Dimitri Sivanich <sivanich@sgi.com>
Subject: Re: [RFC][PATCH] Restricted hard realtime
Message-ID: <20041023202917.GC1267@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20041023194721.GB1268@us.ibm.com> <20041023201724.GA23936@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041023201724.GA23936@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 10:17:24PM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@us.ibm.com> wrote:
> 
> > +	bool "Reserve a CPU for hard realtime processes"
> 
> this has been implemented in a clean way already: check out the
> "isolcpus=" boot option & scheduler feature (implemented by Dimitri
> Sivanich) which isolates a set of CPUs via sched-domains for precisely
> such purposes. The way to enter such a domain is via the affinity
> syscall - and balancing will leave such domains isolated.

Thank you for the tip -- I will look this over!

							Thanx, Paul
