Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130570AbRCIQ7k>; Fri, 9 Mar 2001 11:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130577AbRCIQ73>; Fri, 9 Mar 2001 11:59:29 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7428 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130570AbRCIQ7S>; Fri, 9 Mar 2001 11:59:18 -0500
Subject: Re: [linux-usb-devel] Re: SLAB vs. pci_alloc_xxx in usb-uhci patc h
To: linux-usb-devel@lists.sourceforge.net
Date: Fri, 9 Mar 2001 17:00:51 +0000 (GMT)
Cc: Jamey.Hicks@compaq.com (Hicks Jamey), david-b@pacbell.net (David Brownell),
        manfred@colorfullife.com (Manfred Spraul), zaitcev@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010309153812.A29122@flint.arm.linux.org.uk> from "Russell King" at Mar 09, 2001 03:38:12 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14bQG5-0005GW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	ioremap space:	512MB	(from PhilB)
> 	io space:	256MB
> 
> In order to follow your suggestion, we'd have to drop the kernel from 0xc*
> down to 0xb*.

And there are PA risc boxes with > 2Gig of RAM you might want to plug USB
controllers into
