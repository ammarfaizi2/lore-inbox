Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161069AbVLWWLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161069AbVLWWLM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161071AbVLWWLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:11:12 -0500
Received: from pat.uio.no ([129.240.130.16]:12188 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1161069AbVLWWLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:11:11 -0500
Subject: Re: [PATCH] sched: Fix
	adverse	effects	of	NFS	client	on	interactive response
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Kyle Moffett <mrmacman_g4@mac.com>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1135375452.22177.62.camel@mindpipe>
References: <43A8EF87.1080108@bigpond.net.au>
	 <1135145341.7910.17.camel@lade.trondhjem.org>
	 <43A8F714.4020406@bigpond.net.au>
	 <1135171280.7958.16.camel@lade.trondhjem.org>
	 <962C9716-6F84-477B-8B2A-FA771C21CDE8@mac.com>
	 <1135172453.7958.26.camel@lade.trondhjem.org>
	 <43AA0EEA.8070205@bigpond.net.au>
	 <1135289282.9769.2.camel@lade.trondhjem.org>
	 <43AB29B8.7050204@bigpond.net.au>
	 <1135292364.9769.58.camel@lade.trondhjem.org>
	 <AAF94E06-ACB9-4ABE-AC15-49C6B3BE21A0@mac.com>
	 <1135297525.3685.57.camel@lade.trondhjem.org>
	 <43AB69B8.4080707@bigpond.net.au>
	 <1135330757.8167.44.camel@lade.trondhjem.org>
	 <1135364822.22177.13.camel@mindpipe>
	 <1135372090.8555.9.camel@lade.trondhjem.org>
	 <1135372661.22177.46.camel@mindpipe>
	 <1135372999.8555.19.camel@lade.trondhjem.org>
	 <1135375452.22177.62.camel@mindpipe>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 23:10:57 +0100
Message-Id: <1135375857.8555.55.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.867, required 12,
	autolearn=disabled, AWL 2.08, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-23 at 17:04 -0500, Lee Revell wrote:

> cond_resched is really a temporary hack to make the desktop usable until
> the kernel becomes fully preemptible.

...and my argument is that we should avoid adding yet another load of
scheduling hacks deep in unrelated code in order to satisfy yet another
minority of users. The Linux way has always been to emphasise
maintainability, and hence clean coding, over functionality.

Cheers,
  Trond

