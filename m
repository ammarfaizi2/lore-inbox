Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVEXOGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVEXOGu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 10:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVEXOGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 10:06:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:8116 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261263AbVEXOGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 10:06:48 -0400
Date: Tue, 24 May 2005 16:06:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [patch] remove set_tsk_need_resched() from init_idle()
Message-ID: <20050524140623.GA3500@elte.hu>
References: <20050524121541.GA17049@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050524121541.GA17049@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> this patch (ontop of the current -mm scheduler patchset, in particular 
> ontop of Nick's idle-thread optimization patches) tweaks cpu_idle() 
> semantics a bit: [...]

i just noticed that Nick's latest idle-optimizations patch is not in 
-rc4-mm2, so this will cause some clashes.

	Ingo
