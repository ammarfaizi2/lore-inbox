Return-Path: <linux-kernel-owner+w=401wt.eu-S1751286AbWLLM4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWLLM4B (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 07:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWLLM4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 07:56:01 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2647 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751286AbWLLM4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 07:56:01 -0500
Date: Tue, 12 Dec 2006 13:56:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Avi Kivity <avi@qumranet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/kvm/: possible cleanups
Message-ID: <20061212125610.GK28443@stusta.de>
References: <20061211184051.GC28443@stusta.de> <457E7374.3000704@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457E7374.3000704@qumranet.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 11:16:36AM +0200, Avi Kivity wrote:
> Adrian Bunk wrote:
> >This patch contains the following possible cleanups:
> >- make needlessly global code static
> >- proper prototype for kvm_main.c:find_msr_entry()
> >- #if 0 the unused svm.c:inject_db()
> >
> >  
> 
> Please copy kvm patches to kvm-devel@lists.sourceforge.net in the future.

-ENOMAINTAINERSENTRY  ;-)

> find_msr_entry() has been moved to vmx.c by another patch (now queued in 
> -mm), so this patch does not apply.  The rest of the cleanups do look 
> good though.
> 
> While I'll accept cleanup patches for kvm, there are other sources of 
> churn right now, so it might be more efficient to wait with the cleanups 
> for a few weeks.

OK

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

