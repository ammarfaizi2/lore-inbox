Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVE0Nz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVE0Nz2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 09:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVE0Nz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 09:55:27 -0400
Received: from mx1.elte.hu ([157.181.1.137]:8895 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261677AbVE0Ny5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 09:54:57 -0400
Date: Fri, 27 May 2005 15:53:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@muc.de>
Cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       bhuey@lnxw.com, nickpiggin@yahoo.com.au, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050527135310.GC16158@elte.hu>
References: <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <20050526200424.GA27162@elte.hu> <20050527123529.GD86087@muc.de> <20050527124837.GA7253@elte.hu> <20050527125630.GE86087@muc.de> <20050527131317.GA11071@elte.hu> <20050527133122.GF86087@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050527133122.GF86087@muc.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@muc.de> wrote:

> AFAIK the kernel has quite regressed recently, but that was not true 
> (for reasonable sound) at least for some earlier 2.6 kernels and some 
> of the low latency patchkit 2.4 kernels.

(putting my scheduler maintainer hat on) was this under a stock !PREEMPT 
kernel? If you can reproduce it personally, could you try the 
PREEMPT_VOLUNTARY option available in 2.6.12-rc5-mm1? [Despite its name 
it only adds cond_resched()s, not any heavier preempt mechanism.]

	Ingo
