Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVCTBdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVCTBdT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 20:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVCTBdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 20:33:19 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:22457 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261986AbVCTBdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 20:33:16 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-00
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>
In-Reply-To: <20050319191658.GA5921@elte.hu>
References: <20050319191658.GA5921@elte.hu>
Content-Type: text/plain
Date: Sat, 19 Mar 2005 20:33:09 -0500
Message-Id: <1111282389.15947.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-19 at 20:16 +0100, Ingo Molnar wrote:
> the biggest change in this patch is the merge of Paul E. McKenney's
> preemptable RCU code. The new RCU code is active on PREEMPT_RT. While it
> is still quite experimental at this stage, it allowed the removal of
> locking cruft (mainly in the networking code), so it could solve some of
> the longstanding netfilter/networking deadlocks/crashes reported by a
> number of people. Be careful nevertheless.

With PREEMPT_RT my machine deadlocked within 20 minutes of boot.
"apt-get dist-upgrade" seemed to trigger the crash.  I did not see any
Oops unfortunately.

Lee



