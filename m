Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136714AbREIQ4c>; Wed, 9 May 2001 12:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136679AbREIQ4W>; Wed, 9 May 2001 12:56:22 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15883 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136714AbREIQ4M>; Wed, 9 May 2001 12:56:12 -0400
Subject: Re: 2.4.4-ac5 aic7xxx causes hang on my machine
To: dledford@redhat.com (Doug Ledford)
Date: Wed, 9 May 2001 17:59:53 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        bennyb@ntplx.net (Benedict Bridgwater),
        linux-kernel@vger.kernel.org (Linux-Kernel)
In-Reply-To: <3AF96E87.98357637@redhat.com> from "Doug Ledford" at May 09, 2001 12:21:27 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xXJc-0002mc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Which is what I said also in my last email.  I'm more than happy to write this
> off as a BIOS bug, and it is highly likely that the fact that Windows doesn't
> see a problem is because of the exact test I mentioned above.  The BIOS has to

I very much doubt windows is using that test.

> setup all possible boot devices, only devices non-essential to the boot
> process (sound cards, modems, crap like that) get left unconfigured.  Not

It only has to do minimal setup on them. If the BIOS calls are polled then
assigning an IRQ is quite optional

