Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUJPTWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUJPTWj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 15:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUJPTWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 15:22:39 -0400
Received: from mx2.elte.hu ([157.181.151.9]:27045 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262406AbUJPTWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 15:22:37 -0400
Date: Sat, 16 Oct 2004 21:24:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Adam Heath <doogie@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U4
Message-ID: <20041016192402.GA10445@elte.hu>
References: <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <Pine.LNX.4.58.0410161353530.1219@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410161353530.1219@gradall.private.brainfood.com>
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


* Adam Heath <doogie@debian.org> wrote:

> >    http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U4
> >
> > this is a fixes-only release, and it is still experimental code.
> 
> You forgot to lowercase RT and U in the EXTRAVERSION.

i changed my mind because lowercase it looks pretty ugly in uname,
appended to the already lowercase -mm string. Why does Debian need to
have it in lowercase anyway? It doesnt seem to make much sense.

	Ingo
