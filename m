Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312854AbSCZXfU>; Tue, 26 Mar 2002 18:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312843AbSCZXeQ>; Tue, 26 Mar 2002 18:34:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23564 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312842AbSCZXct>;
	Tue, 26 Mar 2002 18:32:49 -0500
Message-ID: <3CA104CE.7070001@mandrakesoft.com>
Date: Tue, 26 Mar 2002 18:31:26 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: up-to-date bk repository?
In-Reply-To: <3CA0FEF7.90003@candelatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Getting farther on ia32, you reach this, too:

gcc -D__KERNEL__ -I/home/jgarzik/repo/marcelo-2.4/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686   -DKBUILD_BASENAME=pci_pc  -c -o pci-pc.o pci-pc.c
pci-pc.c: In function `pci_fixup_i450nx':
pci-pc.c:1094: warning: unused variable `quad'
gcc -D__KERNEL__ -I/home/jgarzik/repo/marcelo-2.4/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686   -DKBUILD_BASENAME=pci_irq  -c -o pci-irq.o pci-irq.c
pci-irq.c:468: `PCI_DEVICE_ID_ITE_IT8330G_0' undeclared here (not in a 
function)
pci-irq.c:468: initializer element is not constant
pci-irq.c:468: (near initialization for `pirq_routers[7].device')
make[1]: *** [pci-irq.o] Error 1
make[1]: Leaving directory `/home/jgarzik/repo/marcelo-2.4/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2


