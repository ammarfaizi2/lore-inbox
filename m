Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268922AbUIMULV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268922AbUIMULV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 16:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268937AbUIMULV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 16:11:21 -0400
Received: from web13911.mail.yahoo.com ([216.136.174.59]:20638 "HELO
	web13911.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268922AbUIMUJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 16:09:42 -0400
Message-ID: <20040913200941.83688.qmail@web13911.mail.yahoo.com>
Date: Mon, 13 Sep 2004 13:09:41 -0700 (PDT)
From: <spaminos-ker@yahoo.com>
Reply-To: spaminos-ker@yahoo.com
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin and others)
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <413131DD.4060604@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Peter Williams <pwil3058@bigpond.net.au> wrote:

>> Nicolas,
>> 	I'll generate a combined patch and let you know when it's ready.  In 
>> the mean time, could you try increasing the "base_promotion_interval" to 
>> about twice the time slice size?
> 

>A patch for the ZAPHOD compiler on top of the R5 voluntary preemption 
>patches is available at:
>
><http://prdownloads.sourceforge.net/cpuse/patch-2.6.9-rc1-vp-R5-zaphod-v5.0.1?download>
>
>Due to the fact that the R5 patch requires the bk12 patch to be applied 
>to 2.6.9-rc1 before it is applied, generating a combined patch resulted 
>in a very large patch (and lots of duplicated effort) so this patch is 
>not a combined patch but is relative to a 2.6.9-rc1 kernel with bk12 and 
>  voluntary preempt R5 patches already applied.

I have been running for several days with this patched kernel, with
0 for max_ia_bonus
and 0 for max_tpt_bonus
in "pb" mode

and there are no slow downs at all: my system is running very steadily now!

So it seems that we are getting somewhere!!

Nicolas

