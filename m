Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVCOPGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVCOPGS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 10:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVCOPGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 10:06:18 -0500
Received: from mx2.elte.hu ([157.181.151.9]:56808 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261311AbVCOPGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 10:06:16 -0500
Date: Tue, 15 Mar 2005 16:05:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@cpushare.com>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [-mm patch] seccomp: don't say it was more or less mandatory
Message-ID: <20050315150526.GA14744@elte.hu>
References: <20050224224134.GE20715@opteron.random> <20050225211453.GC3311@stusta.de> <20050226013137.GO20715@opteron.random> <20050301003247.GY4021@stusta.de> <20050301004449.GV8880@opteron.random> <20050303145147.GX4608@stusta.de> <20050303135556.5fae2317.akpm@osdl.org> <20050315100903.GA32198@elte.hu> <20050315112712.GA3497@elte.hu> <20050315130046.GK7699@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315130046.GK7699@opteron.random>
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


* Andrea Arcangeli <andrea@cpushare.com> wrote:

> > which quite likely wont be provable in the foreseeable future).
> 
> Please mention a _single_ bug that could allow you to escape the
> seccomp jail in linux since 2.4.0 on x86 and x86-64 (and with escape I
> don't mean sniffing data with mmx not being backwards compatible, or
> f00f DoS, I mean executing code into the host as user nobody). I'm not
> aware of a _single_ seccomp bug that could allow you to escape the
> seccomp jail since 2.4.0 and probably much earlier.

ugh? Where do i claim any such thing?

while we are at it, please mention a single ptrace bug in the same
timeframe that could allow a bytecode 'client' to escape a ptrace
TRACE_SYSCALL jail at will.

	Ingo
