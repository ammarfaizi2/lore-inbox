Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262717AbVBYPET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262717AbVBYPET (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 10:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbVBYPET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 10:04:19 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:15841 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262714AbVBYPCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 10:02:34 -0500
Subject: Re: More latency regressions with 2.6.11-rc4-RT-V0.7.39-02
From: Lee Revell <rlrevell@joe-job.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0502250554420.15862@goblin.wat.veritas.com>
References: <1109182061.16201.6.camel@krustophenia.net>
	 <Pine.LNX.4.61.0502231908040.13491@goblin.wat.veritas.com>
	 <1109187381.3174.5.camel@krustophenia.net>
	 <Pine.LNX.4.61.0502231952250.14603@goblin.wat.veritas.com>
	 <Pine.LNX.4.61.0502232048330.14747@goblin.wat.veritas.com>
	 <1109196824.4009.1.camel@krustophenia.net>
	 <Pine.LNX.4.61.0502240441260.5427@goblin.wat.veritas.com>
	 <1109226724.4957.16.camel@krustophenia.net>
	 <Pine.LNX.4.61.0502240821060.5932@goblin.wat.veritas.com>
	 <1109302249.7807.1.camel@krustophenia.net>
	 <Pine.LNX.4.61.0502250554420.15862@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Fri, 25 Feb 2005 10:02:29 -0500
Message-Id: <1109343749.9456.0.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-25 at 05:58 +0000, Hugh Dickins wrote:
> On Thu, 24 Feb 2005, Lee Revell wrote:
> > On Thu, 2005-02-24 at 08:26 +0000, Hugh Dickins wrote:
> > > 
> > > If we'd got to it earlier, yes.  But 2.6.11 looks to be just a day or
> > > two away, and we've no idea why zap_pte_range or clear_page_range
> > > would have reverted.  Nor have we heard from Ingo yet.
> > 
> > It's also not clear that the patch completely fixes the copy_pte_range
> > latency.  This trace is from the Athlon XP.
> 
> Then we need Ingo to investigate and explain all these reversions.
> I'm not _blaming_ Ingo for them, but I'm not familiar with his patches
> nor with deciphering latency traces - he's the magician around here.
> 

Yup.  Oh well.

I'll try to compile a comprehensive list of these so we can fix them for
2.6.12.

Lee

