Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274250AbRIXXii>; Mon, 24 Sep 2001 19:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274251AbRIXXi2>; Mon, 24 Sep 2001 19:38:28 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17934 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274250AbRIXXiV>; Mon, 24 Sep 2001 19:38:21 -0400
Subject: Re: 2.4.10-pre15 -> final breaks IOAPIC on UP?
To: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 25 Sep 2001 00:43:52 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        matthias.andree@stud.uni-dortmund.de (Matthias Andree),
        linux-kernel@vger.kernel.org (Linux-Kernel mailing list),
        mingo@redhat.com
In-Reply-To: <m1ofo07867.fsf@frodo.biederman.org> from "Eric W. Biederman" at Sep 24, 2001 12:30:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15lfOD-00048u-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Uniprocessor IO-APIC only works for some machines. It also subtly changes
> > IRQ delivery timing properties which may be worth checking too
> 
> All athlon motherboards with the via686 southbridge and an AMD northbridge
> should fail according to the AMD errata.  This may also happen with a via
> northbridge.  The AMD apic bus is subtely different from the intel apic
> bus in implementation.

Care to knock up a PCI quirks patch for it ?
