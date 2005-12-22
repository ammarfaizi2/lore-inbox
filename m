Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbVLVW7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbVLVW7d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 17:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbVLVW7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 17:59:33 -0500
Received: from pat.uio.no ([129.240.130.16]:1717 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030352AbVLVW7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 17:59:32 -0500
Subject: Re: [PATCH] sched: Fix adverse effects
	of	NFS	client	on	interactive response
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <43AB29B8.7050204@bigpond.net.au>
References: <43A8EF87.1080108@bigpond.net.au>
	 <1135145341.7910.17.camel@lade.trondhjem.org>
	 <43A8F714.4020406@bigpond.net.au>
	 <1135171280.7958.16.camel@lade.trondhjem.org>
	 <962C9716-6F84-477B-8B2A-FA771C21CDE8@mac.com>
	 <1135172453.7958.26.camel@lade.trondhjem.org>
	 <43AA0EEA.8070205@bigpond.net.au>
	 <1135289282.9769.2.camel@lade.trondhjem.org>
	 <43AB29B8.7050204@bigpond.net.au>
Content-Type: text/plain
Date: Thu, 22 Dec 2005 17:59:23 -0500
Message-Id: <1135292364.9769.58.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.117, required 12,
	autolearn=disabled, AWL 0.83, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-23 at 09:33 +1100, Peter Williams wrote:
> > It still has sod all business being in the NFS code. We don't touch task
> > scheduling in the filesystem code.
> 
> How do you explain the use of the TASK_INTERRUPTIBLE flag then?

Oh, please...

TASK_INTERRUPTIBLE is used to set the task to sleep. It has NOTHING to
do with scheduling.

Trond

