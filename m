Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313087AbSGYNFO>; Thu, 25 Jul 2002 09:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSGYNFO>; Thu, 25 Jul 2002 09:05:14 -0400
Received: from [196.26.86.1] ([196.26.86.1]:1947 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S313087AbSGYNFO>; Thu, 25 Jul 2002 09:05:14 -0400
Date: Thu, 25 Jul 2002 15:26:06 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-rc3-ac2 SMP
In-Reply-To: <200207242034.01605.jamesclv@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0207251458380.18907-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2002, James Cleverdon wrote:

> Ah ha!  Note that while the CPU records in the {MPS,ACPI/MADT} table are in 
> numerical order (as preserved in raw_phys_apicid), the boot CPU is # 02.  The 
> flat code in smp_boot_cpus assumes that the boot CPU will be the first record 
> in the list.  Oops.
> 
> Try the attached patch and see if it helps.

Ok that one goes all the way, but i don't think i've covered everything 
(e.g. tested all the IPI functions). But otherwise looks good, i'll give 
it a go on a bigger box later (tested on 4-way, i'll try 12)

Cheers,
	Zwane
-- 
function.linuxpower.ca


