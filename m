Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030481AbWFIULE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030481AbWFIULE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030477AbWFIULD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:11:03 -0400
Received: from www.osadl.org ([213.239.205.134]:47754 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1030482AbWFIULA (ORCPT
	<rfc822;linux-kerneL@vger.kernel.org>);
	Fri, 9 Jun 2006 16:11:00 -0400
Subject: Re: RT exec for exercising RT kernel capabilities
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: markh@compro.net
Cc: linux-kerneL@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <4489D44E.6060308@compro.net>
References: <448876B9.9060906@compro.net>
	 <1149795975.5257.83.camel@localhost.localdomain>
	 <44888D8F.2000404@compro.net> <4489614A.3030704@compro.net>
	 <4489D44E.6060308@compro.net>
Content-Type: text/plain
Date: Fri, 09 Jun 2006 22:11:37 +0200
Message-Id: <1149883897.5257.181.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-09 at 16:04 -0400, Mark Hounschell wrote:
> > Still investigating...
> 
> Am I even close in assuming that to enable the PI support you have to use
> 
> pthread_mutexattr_setprotocol(mutexattr, PTHREAD_PRIO_INHERIT);
> 
> I have only glibc 2.3 and 2.4 and neither of them understand what
> PTHREAD_PRIO_INHERIT is.
> 
> Can anyone point me to an some Doc or examples of how to enable PI for
> pthread_mutexes?
> 
> Sorry I'm ignorant on the subject. I do understand the principle of PI and may
> even be able to figure out how to test it in user land but how do I turn it on?

Sorry for letting you in the dark. There was a patch against glibc CVS,
but it vansihed somehow. The support will go into glibc CVS when the PI
futex support hits mainline in the 2.6.18 merge window,

	tglx


