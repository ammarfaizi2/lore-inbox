Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVFUCCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVFUCCo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVFUB71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 21:59:27 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:7050 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261853AbVFUBz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 21:55:26 -0400
Date: Mon, 20 Jun 2005 18:55:42 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Kristian Benoit <kbenoit@opersys.com>
Cc: linux-kernel@vger.kernel.org, bhuey@lnxw.com, andrea@suse.de,
       tglx@linutronix.de, karim@opersys.com, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
Message-ID: <20050621015542.GB1298@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1119287612.6863.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119287612.6863.1.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 01:13:32PM -0400, Kristian Benoit wrote:
> We've finally been able to complete a second round of our tests.
> Unfortunately, this has taken much longer than we ever anticipated.
> Without going into too much detail, suffice it to say that we ran into
> problems with each of our intended test configurations. Fortunately,
> the results are that much more interesting and, we hope, more
> accurately illustrate the performance of the approaches being
> compared.

Again, good stuff!

It looks to me that I-PIPE is an example of a "nested OS", with
Linux nested within the I-PIPE functionality.  One could take
the RTAI-Fusion approach, but this measurement is of I-PIPE
rather than RTAI-Fusion, right?  (And use of RTAI-Fusion might
or might not change these results significantly, just trying to
make sure I understand what these specific tests apply to.)

Also, if I understand correctly, the interrupt latency measured
is to the Linux kernel running within I-PIPE, rather than to I-PIPE
itself.  Is this the case, or am I confused?

						Thanx, Paul
