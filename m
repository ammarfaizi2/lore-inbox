Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266254AbUHNJYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266254AbUHNJYK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 05:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266257AbUHNJYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 05:24:10 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:4022 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266254AbUHNJYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 05:24:07 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc4-O8
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20040814072009.GA6535@elte.hu>
References: <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu>
	 <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu>
	 <1092382825.3450.19.camel@mindpipe> <20040813104817.GI8135@elte.hu>
	 <1092432929.3450.78.camel@mindpipe>  <20040814072009.GA6535@elte.hu>
Content-Type: text/plain
Message-Id: <1092475486.803.70.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 14 Aug 2004 05:24:46 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-14 at 03:20, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Here is the trace resulting from the apt-get filemap_sync() issue:
> > 
> >  0.000ms (+0.000ms): filemap_sync_pte_range (filemap_sync)
> >  0.000ms (+0.000ms): filemap_sync_pte (filemap_sync_pte_range)
> 
> ok, this is one that is fixed in -mm already. I've put the fix into -O8:
> 
>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc4-O8
> 
> other changes in -O8: the massive kallsyms-lookup speedup from Paulo
> Marque, and tracing is default-on now.
> 

The extract_entropy issue seems to be the worst offender on my system. I
have collected some traces here:

http://krustophenia.net/testresults.php?dataset=2.6.8-rc4-bk3-O7

Lee

