Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWIAWkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWIAWkj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 18:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWIAWkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 18:40:39 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38608 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751090AbWIAWki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 18:40:38 -0400
Subject: Re: 2.6.18-rc4-mm1 ATA oops on HPT302 controller
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Stoffel <john@stoffel.org>
Cc: linux-kernel@vger.kernel.org, jeff@garzik.org, alan@redhat.com
In-Reply-To: <17648.47873.675155.821074@stoffel.org>
References: <17648.47873.675155.821074@stoffel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 02 Sep 2006 00:00:12 +0100
Message-Id: <1157151612.6271.338.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-08-26 am 17:20 -0400, ysgrifennodd John Stoffel:
>   irq 16: nobody cared (try booting with the "irqpoll" option)
>    [<c013e3e4>] __report_bad_irq+0x24/0x90
>    [<c013e668>] note_interrupt+0x218/0x250
>    [<c013d8f3>] handle_IRQ_event+0x33/0x70

Looks like ACPI routing problems

>    [<c013ef9a>] handle_fasteoi_irq+0xca/0xe0
>    [<c013eed0>] handle_fasteoi_irq+0x0/0xe0

The fact it's a 440GX also suggests the IRQ stuff is likely to be first
bet


-- 
VGER BF report: U 0.5
