Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262628AbVCSQ1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262628AbVCSQ1F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 11:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbVCSQ1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 11:27:04 -0500
Received: from mx1.elte.hu ([157.181.1.137]:59806 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262628AbVCSQ0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 11:26:34 -0500
Date: Sat, 19 Mar 2005 17:26:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, dipankar@in.ibm.com,
       shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050319162601.GA28958@elte.hu>
References: <20050318002026.GA2693@us.ibm.com> <20050318091303.GB9188@elte.hu> <20050318092816.GA12032@elte.hu> <423BB299.4010906@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423BB299.4010906@colorfullife.com>
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


* Manfred Spraul <manfred@colorfullife.com> wrote:

> Ingo Molnar wrote:
> 
> >	read_lock(&rwlock);
> >	...
> >		read_lock(&rwlock);
> >
> >are still legal. (it's also done quite often.)
> >
> > 
> >
>
> How do you handle the write_lock_irq()/read_lock locks? E.g. the
> tasklist_lock or the fasync_lock.

which precise locking situation do you mean?

	Ingo
