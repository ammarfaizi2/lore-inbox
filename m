Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262624AbVBYF7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbVBYF7O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 00:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbVBYF7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 00:59:14 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:11927 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262624AbVBYF7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 00:59:11 -0500
Date: Fri, 25 Feb 2005 05:58:19 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: More latency regressions with 2.6.11-rc4-RT-V0.7.39-02
In-Reply-To: <1109302249.7807.1.camel@krustophenia.net>
Message-ID: <Pine.LNX.4.61.0502250554420.15862@goblin.wat.veritas.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2005, Lee Revell wrote:
> On Thu, 2005-02-24 at 08:26 +0000, Hugh Dickins wrote:
> > 
> > If we'd got to it earlier, yes.  But 2.6.11 looks to be just a day or
> > two away, and we've no idea why zap_pte_range or clear_page_range
> > would have reverted.  Nor have we heard from Ingo yet.
> 
> It's also not clear that the patch completely fixes the copy_pte_range
> latency.  This trace is from the Athlon XP.

Then we need Ingo to investigate and explain all these reversions.
I'm not _blaming_ Ingo for them, but I'm not familiar with his patches
nor with deciphering latency traces - he's the magician around here.

Hugh
