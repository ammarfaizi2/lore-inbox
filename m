Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269421AbUJFTyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269421AbUJFTyy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 15:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269409AbUJFTyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 15:54:53 -0400
Received: from mx2.elte.hu ([157.181.151.9]:32187 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269421AbUJFTx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 15:53:58 -0400
Date: Wed, 6 Oct 2004 21:55:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Ingo Molnar'" <mingo@redhat.com>, linux-kernel@vger.kernel.org,
       "'Andrew Morton'" <akpm@osdl.org>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Subject: Re: Default cache_hot_time value back to 10ms
Message-ID: <20041006195515.GA14501@elte.hu>
References: <20041006074815.GC1137@elte.hu> <200410061718.i96HI9606629@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410061718.i96HI9606629@unix-os.sc.intel.com>
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


* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:

>  5   ms 106.0
>  7.5 ms 110.3
> 10   ms 112.5
> 12.5 ms 112.0
> 15   ms 111.6

ok, great. 9ms and 11ms would still be interesting. My guess would be
that the maximum is at 9. (albeit the numbers, when plotted, indicate
that the measurement might be a bit noisy.)

	Ingo
