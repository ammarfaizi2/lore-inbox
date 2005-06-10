Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVFJXrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVFJXrT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 19:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVFJXrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 19:47:18 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:4786 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261482AbVFJXq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 19:46:27 -0400
Subject: Re: Attempted summary of "RT patch acceptance" thread
From: Lee Revell <rlrevell@joe-job.com>
To: Bill Huey <bhuey@lnxw.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, karim@opersys.com,
       mingo@elte.hu, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org
In-Reply-To: <20050610234133.GB24111@nietzsche.lynx.com>
References: <20050608022646.GA3158@us.ibm.com>
	 <42A8D1F3.8070408@am.sony.com> <20050609235026.GE1297@us.ibm.com>
	 <1118372388.32270.6.camel@mindpipe> <20050610154745.GA1300@us.ibm.com>
	 <20050610173728.GA6564@g5.random> <1118436338.6423.48.camel@mindpipe>
	 <20050610231647.GK1300@us.ibm.com>
	 <20050610232628.GA23512@nietzsche.lynx.com>
	 <Pine.LNX.4.61.0506101735290.19405@montezuma.fsmlabs.com>
	 <20050610234133.GB24111@nietzsche.lynx.com>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 19:46:11 -0400
Message-Id: <1118447173.6423.148.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-10 at 16:41 -0700, Bill Huey wrote:
> On Fri, Jun 10, 2005 at 05:36:10PM -0600, Zwane Mwaikambo wrote:
> > What's wrong with the memory controller on the G5?
> 
> DMA starvation

DMA starvation has also been observed with some PC chipsets during
PREEMPT_RT development and the cause was traced to the UDMA133
controller.  The symptom is latency traces that seem to go in extreme
"slow motion".  Check the archives for the hardware affected.

Lee 

