Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbVBXI1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVBXI1E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 03:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVBXI1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 03:27:04 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:15067 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261964AbVBXI1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 03:27:01 -0500
Date: Thu, 24 Feb 2005 08:26:11 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: More latency regressions with 2.6.11-rc4-RT-V0.7.39-02
In-Reply-To: <1109226724.4957.16.camel@krustophenia.net>
Message-ID: <Pine.LNX.4.61.0502240821060.5932@goblin.wat.veritas.com>
References: <1109182061.16201.6.camel@krustophenia.net> 
    <Pine.LNX.4.61.0502231908040.13491@goblin.wat.veritas.com> 
    <1109187381.3174.5.camel@krustophenia.net> 
    <Pine.LNX.4.61.0502231952250.14603@goblin.wat.veritas.com> 
    <Pine.LNX.4.61.0502232048330.14747@goblin.wat.veritas.com> 
    <1109196824.4009.1.camel@krustophenia.net> 
    <Pine.LNX.4.61.0502240441260.5427@goblin.wat.veritas.com> 
    <1109226724.4957.16.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2005, Lee Revell wrote:
> On Thu, 2005-02-24 at 04:56 +0000, Hugh Dickins wrote:
> > 
> > In other mail, you do expect people still to be using Ingo's patches,
> > so probably this patch should stick there (and in -mm) for now.
> 
> Well all of these were fixed in the past so it may not be unreasonable
> to fix them for 2.6.11.

If we'd got to it earlier, yes.  But 2.6.11 looks to be just a day or
two away, and we've no idea why zap_pte_range or clear_page_range
would have reverted.  Nor have we heard from Ingo yet.

Hugh
