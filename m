Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271063AbTG1U2p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271055AbTG1U2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:28:34 -0400
Received: from lidskialf.net ([62.3.233.115]:65498 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S271038AbTG1U0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:26:32 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] ACPI patch which fixes all my IRQ problems on nforce2 -- linux-2.5.75-acpi-irqparams-final4.patch
Date: Mon, 28 Jul 2003 21:26:30 +0100
User-Agent: KMail/1.5.2
Cc: al.rau@gmx.de, linux-kernel@vger.kernel.org
References: <200307272305.12412.adq_dvb@lidskialf.net> <200307281638.24474.adq_dvb@lidskialf.net> <20030728125152.4a185090.akpm@osdl.org>
In-Reply-To: <20030728125152.4a185090.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307282126.30584.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I fixed this in test2-mm1: it needs a
>
> 	ACPI_FUNCTION_TRACE("acpi_pci_link_allocate");
>
> at the start of that function.
>
> I made a bunch of other changes to that patch - mainly whitespace fixups.
> It is at
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2
>.6.0-test2-mm1/broken-out/nforce2-acpi-fixes.patch

Great, thanks.

> I'm thinking that perhaps io_apic_irq_read_proc() and print_IO_APIC()
> should be consolidated.

I agree. I was going to fix that problem in a later patch; this one is already 
changing a little too much in one go for my liking.

