Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269479AbUJLGK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269479AbUJLGK5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 02:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269477AbUJLGK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 02:10:56 -0400
Received: from mx1.elte.hu ([157.181.1.137]:63716 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269484AbUJLGKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 02:10:51 -0400
Date: Tue, 12 Oct 2004 08:12:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Mark_H_Johnson@Raytheon.com, Andrew Morton <akpm@osdl.org>,
       Daniel Walker <dwalker@mvista.com>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T5
Message-ID: <20041012061201.GG1479@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012005754.1d49a074@mango.fruits.de> <20041012011447.3e7669f8@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041012011447.3e7669f8@mango.fruits.de>
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


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> On Tue, 12 Oct 2004 00:57:54 +0200
> Florian Schmidt <mista.tapas@gmx.net> wrote:
> 
> > hi,
> > 
> > i still can't build it. Fist i reverse applied T4, then applied T5 and tried
> > a make bzImage. I'll try from scratch though to make sure, cause these
> > errors look identical to the T4 ones.
> > 
> 
> same errors.. Both with the preemptible real time thingy and without..

could you send me your .config? Had to do some wacky include file magic
to be able to use semaphores in spinlocks, but could easily have missed
some .config variations.

	Ingo
