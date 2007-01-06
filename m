Return-Path: <linux-kernel-owner+w=401wt.eu-S932283AbXAGAb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbXAGAb6 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 19:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbXAGAb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 19:31:58 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4915 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932283AbXAGAb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 19:31:57 -0500
Date: Sat, 6 Jan 2007 13:08:18 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org,
       Avi Kivity <avi@qumranet.com>
Subject: Re: [announce] [patch] KVM paravirtualization for Linux
Message-ID: <20070106130817.GB5660@ucw.cz>
References: <20070105215223.GA5361@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070105215223.GA5361@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> i'm pleased to announce the first release of paravirtualized KVM (Linux 
> under Linux), which includes support for the hardware cr3-cache feature 
> of Intel-VMX CPUs. (which speeds up context switches and TLB flushes)
> 
> the patch is against 2.6.20-rc3 + KVM trunk and can be found at:
> 
>    http://redhat.com/~mingo/kvm-paravirt-patches/
> 
> Some aspects of the code are still a bit ad-hoc and incomplete, but the 
> code is stable enough in my testing and i'd like to have some feedback. 
> 
> Firstly, here are some numbers:
> 
> 2-task context-switch performance (in microseconds, lower is better):
> 
>  native:                       1.11
>  ----------------------------------
>  Qemu:                        61.18
>  KVM upstream:                53.01
>  KVM trunk:                    6.36
>  KVM trunk+paravirt/cr3:       1.60

Does this make Xen obsolete? I mean... we have xen patches in suse
kernels, should we keep updating them, or just drop them in favour of
KVM?
							Pavel
-- 
Thanks for all the (sleeping) penguins.
