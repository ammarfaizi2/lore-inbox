Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWJQOqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWJQOqg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 10:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWJQOqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 10:46:35 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:33680 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751121AbWJQOqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 10:46:35 -0400
Subject: Re: 2.6.18-rt1
From: Lee Revell <rlrevell@joe-job.com>
To: dipankar@in.ibm.com
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20061013221624.GD7477@in.ibm.com>
References: <20060920141907.GA30765@elte.hu>
	 <1159639564.4067.43.camel@mindpipe> <20060930181804.GA28768@in.ibm.com>
	 <200610132318.02512.annabellesgarden@yahoo.de>
	 <20061013212450.GC7477@in.ibm.com> <1160777536.4201.31.camel@mindpipe>
	 <20061013221624.GD7477@in.ibm.com>
Content-Type: text/plain
Date: Tue, 17 Oct 2006 10:46:35 -0400
Message-Id: <1161096395.2919.57.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-14 at 03:46 +0530, Dipankar Sarma wrote:
> > FWIW, I am also seeing hard lockups every 12-24 hours but the box is
> > headless and I don't have the bandwidth to debug these further.  It
> was
> > stable with 2.6.17-rt*.
> 
> Can you try whatever you were doing with nmi_watchdog=0 ? If it is
> stable, then that would explain the problem. I believe Andi enabled
> nmi watchdog on x86_64 by default recently, that might be why
> we are seeing it now. 

Looks like that was the problem, the hard lockups are gone.

Lee

