Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129991AbQLINHj>; Sat, 9 Dec 2000 08:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130393AbQLINH2>; Sat, 9 Dec 2000 08:07:28 -0500
Received: from gadolinium.btinternet.com ([194.73.73.111]:25546 "EHLO
	gadolinium.btinternet.com") by vger.kernel.org with ESMTP
	id <S129991AbQLINHT>; Sat, 9 Dec 2000 08:07:19 -0500
Date: Sat, 9 Dec 2000 12:36:43 +0000 (GMT)
From: davej@suse.de
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Russell King <rmk@arm.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pdev_enable_device no longer used ?
In-Reply-To: <20001209151549.A1729@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.21.0012091233130.4121-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2000, Ivan Kokshaysky wrote:

> > It is used from pci_assign_unassigned_resources.  iirc, its just that
> > x86 doesn't call this function.
> Yes, only alpha, arm and mips are using that code.

Ok, thanks Ivan/Russell for clearing this up for me.

If/When x86 (or all?) architectures use this, will it make sense to
remove the PCI space cache line setting from drivers ?
Or is there borked hardware out there that require drivers to say
"This cacheline size must be xxx bytes, anything else will break" ?

regards,

Davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
