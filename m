Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUIOJ7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUIOJ7s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 05:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUIOJ7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 05:59:48 -0400
Received: from mx2.elte.hu ([157.181.151.9]:58593 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264299AbUIOJ7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 05:59:39 -0400
Date: Wed, 15 Sep 2004 12:00:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Florian Schmidt <mista.tapas@gmx.net>,
       "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R5
Message-ID: <20040915100048.GA2676@elte.hu>
References: <1094597710.16954.207.camel@krustophenia.net> <1094598822.16954.219.camel@krustophenia.net> <32930.192.168.1.5.1094601493.squirrel@192.168.1.5> <20040908082358.GB680@elte.hu> <20040908083158.GA1611@elte.hu> <37312.195.245.190.93.1094728166.squirrel@195.245.190.93> <1095210962.2406.79.camel@krustophenia.net> <19084.195.245.190.94.1095240596.squirrel@195.245.190.94> <20040915093859.GA1629@elte.hu> <58425.195.245.190.93.1095242005.squirrel@195.245.190.93>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58425.195.245.190.93.1095242005.squirrel@195.245.190.93>
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


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> Yes, I didn't mentioned that, but I do have provided it and assumed on
> all my reported trials:
> 
>     echo 0 > "/proc/irq/8/rtc/threaded"
>     echo 0 > "/proc/irq/17/Intel ICH5/threaded"
> 
> Thanks.

weird. You shouldnt get any xruns - unless jackd for whatever reason
doesnt truly run under RT priorities. (there was some NPTL related
buglet that caused such a symptom in earlier jackd versions.)

	Ingo
