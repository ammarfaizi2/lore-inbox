Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266185AbUHNHSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266185AbUHNHSr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 03:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266189AbUHNHSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 03:18:47 -0400
Received: from mx2.elte.hu ([157.181.151.9]:38558 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266185AbUHNHSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 03:18:37 -0400
Date: Sat, 14 Aug 2004 09:20:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: [patch] voluntary-preempt-2.6.8-rc4-O8
Message-ID: <20040814072009.GA6535@elte.hu>
References: <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <1092382825.3450.19.camel@mindpipe> <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092432929.3450.78.camel@mindpipe>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> Here is the trace resulting from the apt-get filemap_sync() issue:
> 
>  0.000ms (+0.000ms): filemap_sync_pte_range (filemap_sync)
>  0.000ms (+0.000ms): filemap_sync_pte (filemap_sync_pte_range)

ok, this is one that is fixed in -mm already. I've put the fix into -O8:

 http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc4-O8

other changes in -O8: the massive kallsyms-lookup speedup from Paulo
Marque, and tracing is default-on now.

	Ingo
