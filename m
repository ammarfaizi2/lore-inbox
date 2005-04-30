Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVD3Phz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVD3Phz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 11:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVD3Phz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 11:37:55 -0400
Received: from 70-57-132-14.albq.qwest.net ([70.57.132.14]:9674 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261255AbVD3Phr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 11:37:47 -0400
Date: Sat, 30 Apr 2005 09:39:46 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: coywolf@lovecn.org
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm1
In-Reply-To: <2cd57c90050430082928eae1fb@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0504300937190.12903@montezuma.fsmlabs.com>
References: <20050429231653.32d2f091.akpm@osdl.org> <2cd57c90050430082928eae1fb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Apr 2005, Coywolf Qi Hunt wrote:

>   CC      arch/i386/kernel/cpu/amd.o
>   CC      arch/i386/kernel/cpu/cyrix.o
>   CC      arch/i386/kernel/cpu/intel_cacheinfo.o
>   CC      arch/i386/kernel/cpu/mcheck/init.o
>   CC      arch/i386/kernel/cpu/mcheck/mce.o
>   CC      arch/i386/kernel/cpu/mcheck/p5.o
>   CC      arch/i386/kernel/cpu/mcheck/winchip.o
>   CC      arch/i386/kernel/cpu/mcheck/mce_intel.o
> /home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:
> In function `smp_thermal_interrupt':
> /home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:25:
> warning: implicit declaration of function `ack_APIC_irq'
> /home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:
> In function `intel_init_thermal':
> /home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:67:
> warning: implicit declaration of function `apic_read'
> /home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:67:
> error: `APIC_LVTTHMR' undeclared (first use in this function)
> /home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:67:
> error: (Each undeclared identifie r is reported only once
> /home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:67:
> error: for each function it appea rs in.)
> /home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:68:
> error: `APIC_DM_SMI' undeclared ( first use in this function)
> /home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:77:
> error: `APIC_VECTOR_MASK' undecla red (first use in this function)
> /home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:85:
> error: `APIC_DM_FIXED' undeclared  (first use in this function)
> /home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:85:
> error: `APIC_LVT_MASKED' undeclar ed (first use in this function)
> /home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:86:
> warning: implicit declaration of function `apic_write_around'
> make[4]: *** [arch/i386/kernel/cpu/mcheck/mce_intel.o] Error 1
> make[3]: *** [arch/i386/kernel/cpu/mcheck] Error 2
> make[2]: *** [arch/i386/kernel/cpu] Error 2
> make[1]: *** [arch/i386/kernel] Error 2
> make: *** [_all] Error 2

Could you send your .config please?

Thanks,
	Zwane

