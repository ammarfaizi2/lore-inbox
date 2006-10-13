Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751929AbWJMWLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbWJMWLQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 18:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbWJMWLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 18:11:16 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:18580 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751929AbWJMWLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 18:11:16 -0400
Subject: Re: 2.6.18-rt1
From: Lee Revell <rlrevell@joe-job.com>
To: dipankar@in.ibm.com
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20061013212450.GC7477@in.ibm.com>
References: <20060920141907.GA30765@elte.hu>
	 <1159639564.4067.43.camel@mindpipe> <20060930181804.GA28768@in.ibm.com>
	 <200610132318.02512.annabellesgarden@yahoo.de>
	 <20061013212450.GC7477@in.ibm.com>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 18:12:16 -0400
Message-Id: <1160777536.4201.31.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-14 at 02:54 +0530, Dipankar Sarma wrote:
> Can you try with nmi_watchdog=0 in the kernel command line ?
> 
> Paul has an NMI-safe patch for rcupreempt which I am adopting
> and testing at the moment. If this works well, I will publish
> a new patchset.
> 

The bug is too hard to hit for me to provide useful feedback.  I've only
seen it once since my original report.

FWIW, I am also seeing hard lockups every 12-24 hours but the box is
headless and I don't have the bandwidth to debug these further.  It was
stable with 2.6.17-rt*.

Lee

