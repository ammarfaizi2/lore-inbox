Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274309AbRITE41>; Thu, 20 Sep 2001 00:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274310AbRITE4R>; Thu, 20 Sep 2001 00:56:17 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:21520 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S274309AbRITE4H>;
	Thu, 20 Sep 2001 00:56:07 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200109200456.f8K4uBM383195@saturn.cs.uml.edu>
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 20 Sep 2001 00:56:11 -0400 (EDT)
Cc: VDA@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
In-Reply-To: <E15jN29-00017p-00@the-village.bc.nu> from "Alan Cox" at Sep 18, 2001 04:43:37 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> [somebody]

>> stomper, I think patch could be applied to
>> arch/i386/kernel/pci-pc.c in mainline kernel.
>> Diffed against 4.2.9.
>> BTW, there are similar fixup routines in drivers/pci/quirks.c
>
> arch/i386/kernel/pci-pc   PC specific fixups
> 
> drivers/pci/quirks.c 	Cross platform fixes

memcopy is kind of fundamental you know... sure it can never get
used before the PCI fix-up code gets a chance to run?
