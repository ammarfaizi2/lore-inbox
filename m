Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266549AbUHINGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266549AbUHINGQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 09:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266550AbUHINGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 09:06:16 -0400
Received: from mx2.elte.hu ([157.181.151.9]:44689 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266549AbUHINGP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 09:06:15 -0400
Date: Mon, 9 Aug 2004 15:05:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
Message-ID: <20040809130558.GA17725@elte.hu>
References: <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040809104649.GA13299@elte.hu>
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

> (the APIC bug has not been found yet so either turn off all APIC
> options in .config or use noapic if you intend to use
> voluntary_preempt=3.)

but it would be nice if those experiencing APIC lockups could test the
following: does the lockup still occur with -O4 if kernel_preemption=0?
(while keeping voluntary_preemption=3)

	Ingo
