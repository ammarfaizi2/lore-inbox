Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVDNHYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVDNHYM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 03:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVDNHYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 03:24:12 -0400
Received: from mx2.elte.hu ([157.181.151.9]:55749 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261452AbVDNHYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 03:24:08 -0400
Date: Thu, 14 Apr 2005 09:23:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: nickpiggin@yahoo.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix active load balance
Message-ID: <20050414072352.GA3978@elte.hu>
References: <20050413120713.A25137@unix-os.sc.intel.com> <20050413200828.GB27088@elte.hu> <20050413132833.B25137@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050413132833.B25137@unix-os.sc.intel.com>
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


* Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:

> Your suggestion also looks similar to my patch. You are also breaking 
> on the first one.

yeah.

> We want the first domain spanning both the cpu's. That is the domain 
> where normal load balance failed and we restore to active load 
> balance.

indeed.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
