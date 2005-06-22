Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbVFVV1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbVFVV1v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 17:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbVFVV1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 17:27:03 -0400
Received: from opersys.com ([64.40.108.71]:34320 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262374AbVFVVVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 17:21:03 -0400
Message-ID: <42B9D8D3.6060602@opersys.com>
Date: Wed, 22 Jun 2005 17:32:03 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, Philippe Gerum <rpm@xenomai.org>
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
References: <42B77B8C.6050109@opersys.com> <20050622011931.GF1324@us.ibm.com> <42B9845B.8030404@opersys.com> <20050622162718.GD1296@us.ibm.com> <1119460803.5825.13.camel@localhost> <20050622185019.GG1296@us.ibm.com> <20050622190422.GA6572@elte.hu> <42B9C777.8040202@opersys.com> <20050622202242.GA17301@elte.hu> <42B9D208.4080305@opersys.com> <20050622211037.GB24029@elte.hu>
In-Reply-To: <20050622211037.GB24029@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> see above. (It's no secret, i described components of this workload in 
> one of my first mails to the adeos thread.

I remembered your description, but it's always nice to see exactly
what's being done. Thanks very much for sending this, we'll integrate
it into the LRTBF.

> Btw., what happened to adeos 
> irq latency testing?)

It got obsoleted by the ipipe testing. It's basically the same thing.
What we were testing in the first released testbench was the usage
of the interrupt pipeline in adeos. Now that Philippe has forked it
out to make it more straightforward for people to look at (instead of
thinking they are looking at a true full nanokernel), it was just
the appropriate thing to do to use the I-pipe patch instead. The
mechansim being measured is exactly the same thing.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
