Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131138AbQLUXPF>; Thu, 21 Dec 2000 18:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131199AbQLUXO4>; Thu, 21 Dec 2000 18:14:56 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:58895 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131138AbQLUXOq>; Thu, 21 Dec 2000 18:14:46 -0500
Subject: Re: Cleanup (PCI API and general) of drivers/net/rcpci.c (240t13p3)
To: rasmus@jaquet.dk (Rasmus Andersen)
Date: Thu, 21 Dec 2000 22:46:52 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001221233805.E611@jaquet.dk> from "Rasmus Andersen" at Dec 21, 2000 11:38:05 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E149EUA-0003iN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Questions for the maintainers, should they read this (does anyone
> know their email addresses?) (others should feel free to chip in):

I've not heard from them for a long time

> o The driver currently allocates irqs during its initialization
>   instead of postponing it until it is opened for use. Is there
>   a reason for this?

Shouldnt be - its an I2O network interface with some extra bits for
the cryptoconfig


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
