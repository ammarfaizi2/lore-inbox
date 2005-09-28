Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbVI1Mqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbVI1Mqf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 08:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbVI1Mqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 08:46:35 -0400
Received: from mailer2-1.key-systems.net ([81.3.43.253]:19842 "HELO
	mailer2-1.key-systems.net") by vger.kernel.org with SMTP
	id S1751279AbVI1Mqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 08:46:34 -0400
Message-ID: <433A900D.3030308@mathematica.scientia.net>
Date: Wed, 28 Sep 2005 14:43:57 +0200
From: Christoph Anton Mitterer <cam@mathematica.scientia.net>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Kernel configuration questions
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,.. :-)
I've got some questions about kernel configuration... and hope someone 
could possibly help me.
I'm using a Tyan S2895 Thunder K8WE mainboard,.. with two AMD Opterons 
Model 275 (=2,2 GHz and DualCore). My total amoun of physical RAM is 4 
GB (2 GB for each CPU).

So,...
1) Maximum number of CPUs (CONFIG_NR_CPUS)
Should I specify physical CPUs (=2) or total number of cores (=4)?

2) SMT (Hyperthreading) scheduler support (CONFIG_SCHED_SMT)
I know only Intel CPUs have HT,... but has this any effect on my system 
(see above)?

3) Check for non-fatal errors on AMD Athlon/Duron / Intel P4 
(CONFIG_X86_MCE_NONFATAL)
Does this work on my Opterons, too?

4) High memory support
Ok the help says "Select this if you have a 32-bit processor and between 
1 and 4 gigabytes of physical RAM." but the Opertons have that AMD64 
extension. What should I do here? (btw: Im going to use the 
compatibility mode of the CPU as I'm going to use the AMD64 port of 
Debian but also a chroot with some 32bit applications, e.g. OpenOffice)

5) Allocate 3rd-level pagetables from highmem (CONFIG_HIGHPTE)
Same question: Should I activate this?

6) The mainboard has one conventional PCI slot, t 16x PCIe and three 
PCI-X slots.
I've activatet PCI and PCIe support (CONFIG_PCI and CONFIG_PCIEPORTBUS; 
and I acticated CONFIG_PCI_MSI, too). Does this already cover PCI-X?

7) The mainboard have the following chipset: Nvidia nForce professional 
2200, Nvidia nForce professional 2050 and AMD 8131.
The help says that AMD and nVidia IDE support (CONFIG_BLK_DEV_AMD74XX) 
"adds explicit support for AMD-7xx and AMD-8111 chips and also for the 
nVidia nForce chip".
Does this work for my Chipset, too? Or do I need anything different?

8) Which configuration option from the SCSI-menu enables SATA-II? Is 
CONFIG_BLK_DEV_SD enough?

9) The board has two GigaBit Ethernet controllers,... according the 
mainboard manual one is from the Nvidia nForce professional 2200 and the 
other from the 2050.
Any ide which one is the correct kernel-driver?

10) Ok... I've seen on the Nvidia homepage that they prvoide some 
binary-only drivers for some stuff *sigh*
I'd like to not use them =) Is there any replacement for them that is 
alredy in the vanilla tree or that I should patch into the sources?
I mean support for the chipset or Tyan mainboard or something like this :-)


Ok, for the moment this is enough :-)

Lots of thanks *hugs*

Regards,
Christoph.
--
http://christoph.anton.mitterer.name/
Munich University of Applied Sciences / Department of Mathematics and 
Computer Science
