Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVFJUos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVFJUos (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 16:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVFJUos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 16:44:48 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:55697 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261222AbVFJUoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 16:44:46 -0400
Subject: Re: Attempted summary of "RT patch acceptance" thread
From: Lee Revell <rlrevell@joe-job.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org, bhuey@lnxw.com, tglx@linutronix.de,
       karim@opersys.com, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
In-Reply-To: <20050610173728.GA6564@g5.random>
References: <20050608022646.GA3158@us.ibm.com>
	 <42A8D1F3.8070408@am.sony.com> <20050609235026.GE1297@us.ibm.com>
	 <1118372388.32270.6.camel@mindpipe> <20050610154745.GA1300@us.ibm.com>
	 <20050610173728.GA6564@g5.random>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 16:45:38 -0400
Message-Id: <1118436338.6423.48.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-10 at 19:37 +0200, Andrea Arcangeli wrote:
> You don't need to add it to the document, but as a further pratical
> example of troublesome hardware besides VGA (could be a software issue
> and not hardware issue though)  

The VGA problems were due to (X, not kernel!) driver bugs.  Recent
versions of X are thought to be OK.

It's the exact same issue described in this paper, scroll down to
section 4.5.

http://www.cs.utah.edu/~regehr/papers/hotos7/hotos7.html

There's absolutely nothing the kernel or PREEMPT_RT can do about this,
AFAICT even RTAI would be affected, because X lets userspace drivers
talk directly to the hardware including wedging the PCI bus.

Lee

