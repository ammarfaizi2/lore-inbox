Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130540AbQLIN2W>; Sat, 9 Dec 2000 08:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131494AbQLIN2N>; Sat, 9 Dec 2000 08:28:13 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6406 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130540AbQLIN17>; Sat, 9 Dec 2000 08:27:59 -0500
Subject: Re: pdev_enable_device no longer used ?
To: davej@suse.de
Date: Sat, 9 Dec 2000 12:53:46 +0000 (GMT)
Cc: ink@jurassic.park.msu.ru (Ivan Kokshaysky),
        rmk@arm.linux.org.uk (Russell King),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.21.0012091233130.4121-100000@neo.local> from "davej@suse.de" at Dec 09, 2000 12:36:43 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144jVc-0005Lk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If/When x86 (or all?) architectures use this, will it make sense to
> remove the PCI space cache line setting from drivers ?
> Or is there borked hardware out there that require drivers to say
> "This cacheline size must be xxx bytes, anything else will break" ?

If there is surely the driver can override it again before enabling the
master bit or talking to the device ?


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
