Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVD3Poi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVD3Poi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 11:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVD3Poi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 11:44:38 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:53902 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261257AbVD3Po3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 11:44:29 -0400
Message-ID: <4273A7CD.8000305@ens-lyon.fr>
Date: Sat, 30 Apr 2005 17:44:13 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>, coywolf@lovecn.org
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm1
References: <20050429231653.32d2f091.akpm@osdl.org> <2cd57c90050430082928eae1fb@mail.gmail.com> <Pine.LNX.4.61.0504300937190.12903@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0504300937190.12903@montezuma.fsmlabs.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000308030900060106080005"
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000308030900060106080005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I posted this patch to fix this error (asm/apic.h must be included).

Regards,
Brice




Zwane Mwaikambo a écrit :
> On Sat, 30 Apr 2005, Coywolf Qi Hunt wrote:
> 
> 
>>  CC      arch/i386/kernel/cpu/amd.o
>>  CC      arch/i386/kernel/cpu/cyrix.o
>>  CC      arch/i386/kernel/cpu/intel_cacheinfo.o
>>  CC      arch/i386/kernel/cpu/mcheck/init.o
>>  CC      arch/i386/kernel/cpu/mcheck/mce.o
>>  CC      arch/i386/kernel/cpu/mcheck/p5.o
>>  CC      arch/i386/kernel/cpu/mcheck/winchip.o
>>  CC      arch/i386/kernel/cpu/mcheck/mce_intel.o
>>/home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:
>>In function `smp_thermal_interrupt':
>>/home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:25:
>>warning: implicit declaration of function `ack_APIC_irq'
>>/home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:
>>In function `intel_init_thermal':
>>/home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:67:
>>warning: implicit declaration of function `apic_read'
>>/home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:67:
>>error: `APIC_LVTTHMR' undeclared (first use in this function)
>>/home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:67:
>>error: (Each undeclared identifie r is reported only once
>>/home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:67:
>>error: for each function it appea rs in.)
>>/home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:68:
>>error: `APIC_DM_SMI' undeclared ( first use in this function)
>>/home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:77:
>>error: `APIC_VECTOR_MASK' undecla red (first use in this function)
>>/home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:85:
>>error: `APIC_DM_FIXED' undeclared  (first use in this function)
>>/home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:85:
>>error: `APIC_LVT_MASKED' undeclar ed (first use in this function)
>>/home/coywolf/2.6.12-rc3-mm1-cy/arch/i386/kernel/cpu/mcheck/mce_intel.c:86:
>>warning: implicit declaration of function `apic_write_around'
>>make[4]: *** [arch/i386/kernel/cpu/mcheck/mce_intel.o] Error 1
>>make[3]: *** [arch/i386/kernel/cpu/mcheck] Error 2
>>make[2]: *** [arch/i386/kernel/cpu] Error 2
>>make[1]: *** [arch/i386/kernel] Error 2
>>make: *** [_all] Error 2
> 
> 
> Could you send your .config please?
> 
> Thanks,
> 	Zwane

-- 
Brice Goglin
================================================
Etudiant en These                     Bureau 343
Laboratoire de l'Informatique et du Parallélisme
UMR CNRS-INRIA-ENS Lyon 5668
46, allée d'Italie 69364 Lyon Cedex 07
Tél 04 72 72 87 59            Fax 04 72 72 80 80

Ph.D Student
Laboratoire de l'Informatique et du Parallélisme
CNRS-ENS Lyon-INRIA-UCB Lyon
France

--------------000308030900060106080005
Content-Type: text/x-patch;
 name="01_include_apic_in_intel_mce.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01_include_apic_in_intel_mce.patch"

--- linux-mm/arch/i386/kernel/cpu/mcheck/mce_intel.c.old	2005-04-30 11:36:56.000000000 +0200
+++ linux-mm/arch/i386/kernel/cpu/mcheck/mce_intel.c	2005-04-30 11:36:19.000000000 +0200
@@ -9,6 +9,7 @@
 #include <asm/processor.h>
 #include <asm/msr.h>
 #include <asm/hw_irq.h>
+#include <asm/apic.h>
 #include "mce.h"
 
 static DEFINE_PER_CPU(unsigned long, next_check);

--------------000308030900060106080005--
