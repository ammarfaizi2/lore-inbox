Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVCRJPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVCRJPm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 04:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVCRJOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 04:14:21 -0500
Received: from mx2.elte.hu ([157.181.151.9]:23963 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261535AbVCRJNk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 04:13:40 -0500
Date: Fri, 18 Mar 2005 10:13:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: dipankar@in.ibm.com, shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       manfred@colorfullife.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050318091303.GB9188@elte.hu>
References: <20050318002026.GA2693@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318002026.GA2693@us.ibm.com>
User-Agent: Mutt/1.4.1i
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

> I have tested this approach, but in user-level scaffolding.  All of
> these implementations should therefore be regarded with great
> suspicion: untested, probably don't even compile.  Besides which, I
> certainly can't claim to fully understand the real-time preempt patch,
> so I am bound to have gotten something wrong somewhere. [...]

you dont even have to consider the -RT patchset: if the scheme allows
forced preemption of read-side RCU sections on current upstream
CONFIG_PREEMPT, then it's perfect for PREEMPT_RT too.

	Ingo
