Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUHJIJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUHJIJe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 04:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUHJIJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:09:34 -0400
Received: from mx1.elte.hu ([157.181.1.137]:1967 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261234AbUHJIJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:09:33 -0400
Date: Tue, 10 Aug 2004 10:09:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
Message-ID: <20040810080933.GA26081@elte.hu>
References: <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040809130558.GA17725@elte.hu> <20040809190201.64dab6ea@mango.fruits.de> <1092103522.761.2.camel@mindpipe> <1092117141.761.15.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092117141.761.15.camel@mindpipe>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> Here is another one I got starting jackd.  Never seen it before today.
> 
> (jackd/778): 14583us non-preemptible critical section violated 1100 us
> preempt threshold starting at schedule+0x55/0x5a0 and ending at
> schedule+0x2ed/0x5a0

just to make sure this is not a false positive - is this accompanied by
ALSA-detected xruns as well? (i suspect it is.)

	Ingo
