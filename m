Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131795AbQLZSEp>; Tue, 26 Dec 2000 13:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131952AbQLZSEf>; Tue, 26 Dec 2000 13:04:35 -0500
Received: from [192.122.208.4] ([192.122.208.4]:62221 "HELO
	merlot.oragroup.com") by vger.kernel.org with SMTP
	id <S131950AbQLZSEW>; Tue, 26 Dec 2000 13:04:22 -0500
Date: Tue, 26 Dec 2000 07:24:39 -0500 (EST)
From: <indyj@oragroup.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test12: PCMCIA IRQ assignments?
Message-ID: <Pine.LNX.4.21.0012260719440.29885-100000@merlot.oragroup.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have a Sager NP9820 laptop with an ALI chipset and a TI PCI1251BGFN
PCMCIA chipset.  For some reason, when I use the yenta module under 2.4.0,
it gets an incorrect IRQ assignment.  It uses IRQ11, which is also used by
my ATI Rage Pro card... therefore, when you install this module, the
machine locks up.

If I use the pcmcia card services under 2.2.16, then the PCMCIA bridge
gets a correct assignment of IRQ 10.  I've poked around a bit and haven't
found a way to force the 2.4.0 module to use a specific IRQ... is there a
way to do this without hardcoding it?

Otherwise, this is an ideal laptop to run Linux.

Thanks,
--J




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
