Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030273AbVHKL3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbVHKL3S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 07:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbVHKL3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 07:29:18 -0400
Received: from mx2.elte.hu ([157.181.151.9]:39820 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S1030273AbVHKL3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 07:29:17 -0400
Date: Thu, 11 Aug 2005 13:30:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: yangyi <yang.yi@bmrtech.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Patch]: latency histogram patch cleanup
Message-ID: <20050811113005.GA21933@elte.hu>
References: <1123753388.4092.173.camel@montavista2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123753388.4092.173.camel@montavista2>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* yangyi <yang.yi@bmrtech.com> wrote:

> Hi, Ingo
> 
> According to your suggestion, I check your cleanup and correct some 
> errors and modify latency type decision.
> 
> This patch corrects some latency histogram configration options name, 
> adds a field to cpu_trace struct, removes that ugly latenct type 
> decision statement block, adds a latency_type parameter to 
> __start_critical_timing.

thanks - i've applied your changes and have released the -53-02 patch.

	Ingo
