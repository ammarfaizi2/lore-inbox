Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265044AbUGZIew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbUGZIew (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 04:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265048AbUGZIew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 04:34:52 -0400
Received: from mx2.elte.hu ([157.181.151.9]:25031 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265044AbUGZIeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 04:34:44 -0400
Date: Mon, 26 Jul 2004 10:35:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Lenar L?hmus <lenar@vision.ee>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [patch] voluntary-preempt-2.6.8-rc2-J3
Message-ID: <20040726083537.GA24948@elte.hu>
References: <20040713122805.GZ21066@holomorphy.com> <40F3F0A0.9080100@vision.ee> <20040713143947.GG21066@holomorphy.com> <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090830574.6936.96.camel@mindpipe>
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


> Yes, jackd does exactly this, mlockall then opens the ALSA driver with
> mmap.

ok, i fixed this in -J3:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-J3

-J3 also includes a number of softirq latency fixes for the networking
layer.

	Ingo
