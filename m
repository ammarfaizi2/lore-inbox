Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVCUJBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVCUJBg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 04:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVCUJBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 04:01:36 -0500
Received: from mx2.elte.hu ([157.181.151.9]:43691 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261706AbVCUJBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 04:01:31 -0500
Date: Mon, 21 Mar 2005 10:01:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-00
Message-ID: <20050321090122.GA8066@elte.hu>
References: <20050319191658.GA5921@elte.hu> <20050320174508.GA3902@us.ibm.com> <20050321085332.GA7163@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321085332.GA7163@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> got this early-bootup crash on an SMP box:

the same kernel image boots fine on an UP box, so it's an SMP bug.

note that the same occurs with your latest (synchronization barrier)
fixes applied as well.

	Ingo
