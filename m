Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264146AbTIINeB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 09:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264148AbTIINeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 09:34:01 -0400
Received: from lidskialf.net ([62.3.233.115]:17878 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S264146AbTIINd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 09:33:59 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Subject: Re: acpi-irq-fixes from test5-mm1 broken with acpi=off
Date: Tue, 9 Sep 2003 14:32:27 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200309091518.07368.arekm@pld-linux.org>
In-Reply-To: <200309091518.07368.arekm@pld-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309091432.27245.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Now the problem is that with vanilla test5 acpi=off works well - see dmesg
> http://lkml.org/lkml/2003/9/9/31 but after applying acpi-irq-fixes I get:

>  [<c035b3cc>] acpi_pci_irq_init+0xb/0x47
>  [<c0368aa3>] pci_acpi_init+0x23/0x60
>  [<c034c7bc>] do_initcalls+0x2c/0xa0
>  [<c0130432>] init_workqueues+0x12/0x60
>  [<c01050a1>] init+0x31/0x1d0
>  [<c0105070>] init+0x0/0x1d0
>  [<c0109259>] kernel_thread_helper+0x5/0xc

Cool thanks, looks like acpi=off isn't as off as it should be. Will fix.

