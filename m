Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129605AbQLIM6Q>; Sat, 9 Dec 2000 07:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129744AbQLIM6G>; Sat, 9 Dec 2000 07:58:06 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:45572 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S129605AbQLIM5y>; Sat, 9 Dec 2000 07:57:54 -0500
Date: Sat, 9 Dec 2000 15:15:49 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Russell King <rmk@arm.linux.org.uk>
Cc: davej@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mj@suse.cz
Subject: Re: pdev_enable_device no longer used ?
Message-ID: <20001209151549.A1729@jurassic.park.msu.ru>
In-Reply-To: <Pine.LNX.4.21.0012091122460.3465-100000@neo.local> <200012091138.eB9Bc5l29476@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200012091138.eB9Bc5l29476@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Dec 09, 2000 at 11:38:05AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2000 at 11:38:05AM +0000, Russell King wrote:
> davej@suse.de writes:
> > 2. Why is pdev_device_enable no longer used ?

Right question would be "why is it not used yet?" ;-)
This routine appeared a while ago in one of test12-pre.

> It is used from pci_assign_unassigned_resources.  iirc, its just that
> x86 doesn't call this function.

Yes, only alpha, arm and mips are using that code.

Ivan.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
