Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVC2WfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVC2WfF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 17:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVC2Wdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 17:33:41 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:1774 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261588AbVC2Wb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 17:31:57 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-10
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>
In-Reply-To: <20050325145908.GA7146@elte.hu>
References: <20050325145908.GA7146@elte.hu>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 17:31:56 -0500
Message-Id: <1112135516.5386.27.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-25 at 15:59 +0100, Ingo Molnar wrote:
> i have released the -V0.7.41-10 Real-Time Preemption patch, which can be 
> downloaded from the usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 

Ingo,

-15 has a typo that prevents building with my config.

Lee

--- include/linux/mm.h~	2005-03-29 17:28:57.000000000 -0500
+++ include/linux/mm.h	2005-03-29 17:30:05.000000000 -0500
@@ -845,7 +845,7 @@
 #else
  static inline int check_no_locks_freed(const void *from, const void *to)
  {
-	return 0
+	return 0;
  }
 #endif
 


