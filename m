Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVD3P3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVD3P3h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 11:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVD3P3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 11:29:36 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:14508 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261250AbVD3P3a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 11:29:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WfBaEpSOdUVMaUbw0oXvTeU+ylU8JV3/u4sh9hTBlaGmFGuqPLqrwtdvxYHSng7k5rMkf87bDRf/C1cKOPXBGBn3AeyGHFRplrHE+1ot2O04Tpj83EsA9xYNyUB75EpHUlnDwju8Sn97hHhSCei12GGzjm3TCGBua5Sc2c1S8Zg=
Message-ID: <2cd57c90050430082928eae1fb@mail.gmail.com>
Date: Sat, 30 Apr 2005 23:29:24 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc3-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050429231653.32d2f091.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050429231653.32d2f091.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      arch/i386/kernel/cpu/amd.o
  CC      arch/i386/kernel/cpu/cyrix.o
  CC      arch/i386/kernel/cpu/intel_cacheinfo.o
  CC      arch/i386/kernel/cpu/mcheck/init.o
  CC      arch/i386/kernel/cpu/mcheck/mce.o
  CC      arch/i386/kernel/cpu/mcheck/p5.o
  CC      arch/i386/kernel/cpu/mcheck/winchip.o
  CC      arch/i386/kernel/cpu/mcheck/mce_intel.o
/home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:
In function `smp_thermal_interrupt':
/home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:25:
warning: implicit declaration of function `ack_APIC_irq'
/home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:
In function `intel_init_thermal':
/home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:67:
warning: implicit declaration of function `apic_read'
/home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:67:
error: `APIC_LVTTHMR' undeclared (first use in this function)
/home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:67:
error: (Each undeclared identifie r is reported only once
/home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:67:
error: for each function it appea rs in.)
/home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:68:
error: `APIC_DM_SMI' undeclared ( first use in this function)
/home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:77:
error: `APIC_VECTOR_MASK' undecla red (first use in this function)
/home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:85:
error: `APIC_DM_FIXED' undeclared  (first use in this function)
/home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:85:
error: `APIC_LVT_MASKED' undeclar ed (first use in this function)
/home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:86:
warning: implicit declaration of function `apic_write_around'
make[4]: *** [arch/i386/kernel/cpu/mcheck/mce_intel.o] Error 1
make[3]: *** [arch/i386/kernel/cpu/mcheck] Error 2
make[2]: *** [arch/i386/kernel/cpu] Error 2
make[1]: *** [arch/i386/kernel] Error 2
make: *** [_all] Error 2

-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
