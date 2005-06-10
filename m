Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVFJTkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVFJTkY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 15:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVFJTkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 15:40:23 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:28293 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261185AbVFJTkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 15:40:13 -0400
Subject: Re: Attempted summary of "RT patch acceptance" thread
From: Lee Revell <rlrevell@joe-job.com>
To: Bill Huey <bhuey@lnxw.com>
Cc: Andrea Arcangeli <andrea@suse.de>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, karim@opersys.com, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
In-Reply-To: <20050610193926.GA19568@nietzsche.lynx.com>
References: <20050608022646.GA3158@us.ibm.com>
	 <42A8D1F3.8070408@am.sony.com> <20050609235026.GE1297@us.ibm.com>
	 <1118372388.32270.6.camel@mindpipe> <20050610154745.GA1300@us.ibm.com>
	 <20050610173728.GA6564@g5.random>
	 <20050610193926.GA19568@nietzsche.lynx.com>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 15:41:04 -0400
Message-Id: <1118432464.6423.22.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-10 at 12:39 -0700, Bill Huey wrote:
> Some of it is lack of displine with how various drivers do locking in
> that they overload the meaning of a spin_lock, etc... to also disable
> preemption and side effects with preempt_count. Making all of this
> formal
> is a good thing since it clarifies and un-ambiguates those code paths.
> It's something that should have been done in the first place 

Keep in mind there are large subsystems that are already RT safe like
ALSA.

Lee

