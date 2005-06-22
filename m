Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVFVXqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVFVXqM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 19:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVFVXmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 19:42:53 -0400
Received: from opersys.com ([64.40.108.71]:33041 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261473AbVFVXlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 19:41:21 -0400
Message-ID: <42B9F9AA.8070508@opersys.com>
Date: Wed, 22 Jun 2005 19:52:10 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ingo Molnar <mingo@elte.hu>, Bill Huey <bhuey@lnxw.com>,
       Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
References: <1119287612.6863.1.camel@localhost>	 <20050620183115.GA27028@nietzsche.lynx.com> <42B98B20.7020304@opersys.com>	 <20050622192927.GA13817@nietzsche.lynx.com>	 <20050622200554.GA16119@elte.hu> <42B9CC98.1040402@opersys.com>	 <20050622220428.GA28906@elte.hu> <1119481422.25270.11.camel@mindpipe>
In-Reply-To: <1119481422.25270.11.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lee Revell wrote:
> Well, if you want to be even more fair, you could hold off on publishing
> benchmark results that compare an experimental, not fully debugged
> feature with a mature technology.

Would you have applied similar logic had the results been inverted?

Surely the nature of scientific improvement is somewhere along
the lines of experiment, compare, enhance, and retry.

If PREEMPT_RT should not be studied, then what good is it to
continue talking about it on the LKML or even to continue posting
the patches there?

Surely the goal in doing that is to make it better and more
acceptable to the larger crowd. And if that is so, then isn't
it to everyone's advantage therefore to make a strong case for
its adoption?

Did you really expect that no one was going to start running
performance tests on preemp_rt somewhere along the way until
its developers gave an "official" ok? Isn't it better to know
about such results sooner rather than later?

... I'm sorry, I'm somewhat lost here. I can just guess that
you're expressing your dissapointment at the results, and
that's something I can understand very well. But shouldn't
these results encourage you try even harder? Lest you are
telling me that that's as good as it gets ... ?

As a side note about the I-pipe (formerly Adeos), it should
be noted that, in as far as I can recall, its latency response
and performance impact have not varied a lot since its first
introduction over 3 years ago. The mechanism's simplicity
makes it unlikely to introduce any sort of significant
overhead.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
