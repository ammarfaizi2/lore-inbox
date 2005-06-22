Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbVFVV1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbVFVV1v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 17:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbVFVV1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 17:27:13 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:7099 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262363AbVFVVX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 17:23:27 -0400
Date: Wed, 22 Jun 2005 14:23:54 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
Message-ID: <20050622212354.GI1296@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1119287612.6863.1.camel@localhost> <20050621015542.GB1298@us.ibm.com> <42B77B8C.6050109@opersys.com> <20050622011931.GF1324@us.ibm.com> <42B9845B.8030404@opersys.com> <20050622162718.GD1296@us.ibm.com> <42B9A6D6.4060109@opersys.com> <20050622184748.GF1296@us.ibm.com> <42B9B917.9010606@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B9B917.9010606@opersys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 03:16:39PM -0400, Karim Yaghmour wrote:
> 
> Paul E. McKenney wrote:
> > (And, yes, there are other CDFs lacking a 30us bulge that would be
> > consistent with a 55us "blue-moon" bulge -- so I guess I am asking
> > if you have the CDF or the raw latency measurements -- though the
> > data set might be a bit large...  And I would have to think about
> > how one goes about deriving individual-latency CDF(s) given a single
> > dual-latency CDF, assuming that this is even possible...)
> 
> This is a bandwidth issue. The compressed archive containing the
> interrupt latencies of all our test runs is 100MB. I could provide
> a URL _privately_ to a handful of individuals, but beyond that
> someone's going to have to host it.
> 
> Let me know if you want this.

The approach of measuring the target's and the logger's latencies 
separately is a -much- better approach than using strange mathematical
techniques with strange mathematical assumptions.  So please don't
waste any further time on my misguided request for the full data set!

> Of course, now that LRTBF is out there, others can generate their
> own data sets.

True enough!

						Thanx, Paul
