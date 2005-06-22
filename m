Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbVFVUAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbVFVUAX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 16:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVFVUAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 16:00:23 -0400
Received: from opersys.com ([64.40.108.71]:31759 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261999AbVFVUAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 16:00:06 -0400
Message-ID: <42B9C5D1.3020403@opersys.com>
Date: Wed, 22 Jun 2005 16:10:57 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, andrea@suse.de, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
References: <1119287612.6863.1.camel@localhost> <20050620183115.GA27028@nietzsche.lynx.com> <42B98B20.7020304@opersys.com> <20050622192927.GA13817@nietzsche.lynx.com>
In-Reply-To: <20050622192927.GA13817@nietzsche.lynx.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bill Huey (hui) wrote:
> FreeBSD went through some slow down when they moved to SMPng, but not
> the kind of numbers you show for things surrounding the network stack.
> Something clearly bad happened.

Note that the numbers are not freak accidents, they are consistent
accross the various setups. So in total, that's 15 LMbench runs,
all showing consistent _severe_ cost for preempt_rt. And this despite
the fact that it comes down neck-to-neck with the ipipe on
interrupt response time in those same tests. I would highly suggest
setting up an automated benchmark for automatically running LMbench
on every preempt_rt release and compare that to the vanilla kernel.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
