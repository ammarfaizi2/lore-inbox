Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbVHHOwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbVHHOwO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 10:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbVHHOwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 10:52:14 -0400
Received: from mx2.elte.hu ([157.181.151.9]:43393 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S1750918AbVHHOwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 10:52:13 -0400
Date: Mon, 8 Aug 2005 16:53:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>, Daniel Walker <dwalker@mvista.com>
Subject: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-16
Message-ID: <20050808145301.GA19369@elte.hu>
References: <1123186583.12009.32.camel@localhost.localdomain> <20050805105943.GA24994@elte.hu> <1123383935.17039.6.camel@mindpipe> <20050808144216.GA1307@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050808144216.GA1307@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

>  Updated RCU-only portion of the patch included below, applies to 
> 2.6.13-rc4. [...]

thanks - i've put it into the -RT tree and have released the -52-16 
patch, which can be downloaded from the usual place:

    http://redhat.com/~mingo/realtime-preempt/

to build a -V0.7.52-16 tree, the following patches should to be applied:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.12.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.13-rc4.bz2
   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.13-rc4-RT-V0.7.52-16

	Ingo
