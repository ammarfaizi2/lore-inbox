Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWJMWQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWJMWQt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 18:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751925AbWJMWQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 18:16:49 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:5029 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751218AbWJMWQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 18:16:48 -0400
Date: Sat, 14 Oct 2006 03:46:24 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.18-rt1
Message-ID: <20061013221624.GD7477@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060920141907.GA30765@elte.hu> <1159639564.4067.43.camel@mindpipe> <20060930181804.GA28768@in.ibm.com> <200610132318.02512.annabellesgarden@yahoo.de> <20061013212450.GC7477@in.ibm.com> <1160777536.4201.31.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160777536.4201.31.camel@mindpipe>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 06:12:16PM -0400, Lee Revell wrote:
> On Sat, 2006-10-14 at 02:54 +0530, Dipankar Sarma wrote:
> > Can you try with nmi_watchdog=0 in the kernel command line ?
> > 
> > Paul has an NMI-safe patch for rcupreempt which I am adopting
> > and testing at the moment. If this works well, I will publish
> > a new patchset.
> > 
> 
> The bug is too hard to hit for me to provide useful feedback.  I've only
> seen it once since my original report.
> 
> FWIW, I am also seeing hard lockups every 12-24 hours but the box is
> headless and I don't have the bandwidth to debug these further.  It was
> stable with 2.6.17-rt*.

Can you try whatever you were doing with nmi_watchdog=0 ? If it is
stable, then that would explain the problem. I believe Andi enabled
nmi watchdog on x86_64 by default recently, that might be why
we are seeing it now.

Thanks
Dipankar
