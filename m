Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVFJUQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVFJUQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 16:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVFJUQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 16:16:26 -0400
Received: from opersys.com ([64.40.108.71]:32525 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261205AbVFJUQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 16:16:22 -0400
Message-ID: <42A9F788.2040107@opersys.com>
Date: Fri, 10 Jun 2005 16:26:48 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: Andrea Arcangeli <andrea@suse.de>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Lee Revell <rlrevell@joe-job.com>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
References: <20050608022646.GA3158@us.ibm.com> <42A8D1F3.8070408@am.sony.com> <20050609235026.GE1297@us.ibm.com> <1118372388.32270.6.camel@mindpipe> <20050610154745.GA1300@us.ibm.com> <20050610173728.GA6564@g5.random> <20050610193926.GA19568@nietzsche.lynx.com>
In-Reply-To: <20050610193926.GA19568@nietzsche.lynx.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bill Huey (hui) wrote:
> LynxOS is a hard real time OS similar to how the preemption patch works
> in that it's a single kernel system. It's gets those times regularly and
> is obviously deterministic because of careful coding conventions just like
> it has always been. Single kernel determinism is not new. It's only new
> to you.

Bill, I know PREEMPT_RT is something you root for strongly. FWIW, however,
such statements are usually counter-productive.

The existence of real-time monolithic kernels is not disputed. Note, though,
that LynxOS is controlled by a single corporation and its development
model could not be compared in any way to Linux. Because of Linux's
development model, what others are attempting to explain (Andrea included,
I think), the reality is that the auditing/upgrading you speak of is unlikely
to ever become part of the development philosophy.

I don't contest the fact that those promoting PREEMPT_RT intend to conduct
this auditing for the drivers that are of interest to their development.
That, though, doesn't mean that those who are maintaining existing driver
sets want to take part in that.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
