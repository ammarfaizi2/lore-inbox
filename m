Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVFJXGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVFJXGN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 19:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVFJXFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 19:05:35 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:59053 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261394AbVFJXEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 19:04:14 -0400
Date: Fri, 10 Jun 2005 16:04:33 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Eric Piel <Eric.Piel@lifl.fr>
Cc: Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de, karim@opersys.com,
       mingo@elte.hu, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050610230433.GI1300@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050608022646.GA3158@us.ibm.com> <42A73D15.6080201@nortel.com> <20050608192853.GE1295@us.ibm.com> <42AA133D.1050102@lifl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AA133D.1050102@lifl.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 12:25:01AM +0200, Eric Piel wrote:
> I've read the whole summary and really appreciated it. It's clear, 
> precise and objective.

Glad you like it!

> Just a small change to "1 - QoS":
> 
> >b.	For each service:
> >
> >	i.	Probability of missing a deadline due to software,
> >		ranging from 0 to 1, with the value of 1 corresponding
> >		to the hardest possible hard realtime.
> 
> I think it should be (by reference to how you define probability at the 
> beginning of the section):
> Probability of not missing any deadline due to software

Good catch!  How about the following?

	i.      Probability of meeting a deadline due to software,
		ranging from 0 to 1, with the value of 1 corresponding
		to the hardest possible hard realtime.

Changing "missing" in the original to "meeting".

							Thanx, Paul

> Thanks again for writing this summary,
> Eric
> 
