Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130376AbQLIV1Y>; Sat, 9 Dec 2000 16:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131165AbQLIV1O>; Sat, 9 Dec 2000 16:27:14 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130376AbQLIV1E>; Sat, 9 Dec 2000 16:27:04 -0500
Subject: Re: pdev_enable_device no longer used ?
To: groudier@club-internet.fr (Gérard Roudier)
Date: Sat, 9 Dec 2000 20:57:32 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), davej@suse.de,
        ink@jurassic.park.msu.ru (Ivan Kokshaysky),
        rmk@arm.linux.org.uk (Russell King),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.10.10012091500230.1058-100000@linux.local> from "Gérard Roudier" at Dec 09, 2000 03:26:43 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144r3l-0005i9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - A driver that blindly shoe-horns some value for the cache-line size must
> be fixed. Basically, it should not change the value if it is not zero and,
> at least, warn user if it has changed the value because it was zero.
> 
> What are the strong reasons that let some POST softwares not fill properly
> the cache line size of PCI devices ?

In part because it is not required to, and on x86 because there may be no
PCI configuration before the OS loader completes

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
