Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279467AbRK0Nzu>; Tue, 27 Nov 2001 08:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279768AbRK0Nzk>; Tue, 27 Nov 2001 08:55:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60430 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279722AbRK0Nzh>; Tue, 27 Nov 2001 08:55:37 -0500
Subject: Re: "spurious 8259A interrupt: IRQ7"
To: martin@jtrix.com (Martin A. Brooks)
Date: Tue, 27 Nov 2001 14:03:42 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3511.10.119.8.1.1006856832.squirrel@extranet.jtrix.com> from "Martin A. Brooks" at Nov 27, 2001 10:27:12 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E168ipq-00019Y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I get this with 2.4.16 vanilla, though. IRQ 7 appears to be unassigned
> according to /proc/pci.
> 
> Machine is a 1ghz Athlon on a VIA VT82C686 mobo and a DEC 21140 NIC.
> 
> Any pointers appreciated.

IRQ7 is asserted when the PIC sees an interrupt but nobody appears to be
generating it when it looks.
