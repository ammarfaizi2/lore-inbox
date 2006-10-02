Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965480AbWJBW1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965480AbWJBW1q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 18:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965482AbWJBW1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 18:27:46 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:31363 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S965480AbWJBW1p (ORCPT <rfc822;linux-kerneL@vger.kernel.org>);
	Mon, 2 Oct 2006 18:27:45 -0400
Subject: Re: RT exec for exercising RT kernel capabilities
From: Lee Revell <rlrevell@joe-job.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: markh@compro.net, linux-kerneL@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <1152929428.3119.114.camel@mindpipe>
References: <448876B9.9060906@compro.net>
	 <1152916456.3119.92.camel@mindpipe>  <1152929059.5915.11.camel@localhost>
	 <1152929428.3119.114.camel@mindpipe>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 18:27:59 -0400
Message-Id: <1159828079.20801.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 22:10 -0400, Lee Revell wrote:
> On Sat, 2006-07-15 at 04:04 +0200, Thomas Gleixner wrote:
> > On Fri, 2006-07-14 at 18:34 -0400, Lee Revell wrote:
> > > On Thu, 2006-06-08 at 15:12 -0400, Mark Hounschell wrote:
> > > > ftp://ftp.compro.net/public/rt-exec/
> > > 
> > > The high res timers do not seem to be working.  Using 2.6.17-rt3 and
> > > glibc 2.3.6, I get the exact same (bad) results whether
> > > CONFIG_HIGH_RES_TIMERS is enabled or not.
> > 
> > Can you please send me a boot log ?
> 
> Sent off-list.

I've discovered the problem - I was running rt-exec as a non-root user.

Is the use of high res timers limited to root?

Lee

