Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136066AbRDVMXD>; Sun, 22 Apr 2001 08:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136068AbRDVMWx>; Sun, 22 Apr 2001 08:22:53 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33039 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136066AbRDVMWh>; Sun, 22 Apr 2001 08:22:37 -0400
Subject: Re: APIC-Errors+Crashes on GA 586DX, 2.2.17/2.4.3
To: dusty@strike.wu-wien.ac.at
Date: Sun, 22 Apr 2001 13:23:12 +0100 (BST)
Cc: kkeil@suse.de (Karsten Keil), linux-kernel@vger.kernel.org
In-Reply-To: <3AE2A2D0.80388594@violin.dyndns.org> from "Hermann Himmelbauer" at Apr 22, 2001 11:22:24 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rItX-0005j4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Yes, no APIC means all IRQ are handled by one CPU only, so communication
> > errors about IRQ events on the APIC bus don't care.
> 
> Hmmm, so does that mean that those checksum errors have no effect on the
> stability of my system?

If you have a lot of them eventually it will get you.

> How did you do that? The BIOS Option only enables the use of MPS 1.4 for
> single CPU but I could not find an option for switching between 1.1/1.4.
> Is there a way to force the Linux kernel to use 1.4?

It can only use what the BIOS offers.
