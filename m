Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132366AbQLRBGA>; Sun, 17 Dec 2000 20:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132398AbQLRBFu>; Sun, 17 Dec 2000 20:05:50 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26129 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132366AbQLRBFn>; Sun, 17 Dec 2000 20:05:43 -0500
Subject: Re: [BUG] 2.4.0test13-pre3 apm.o unresolved symbols
To: barryn@pobox.com
Date: Mon, 18 Dec 2000 00:37:47 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200012180030.QAA00753@pobox.com> from "Barry K. Nathan" at Dec 17, 2000 04:30:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E147oJK-0004nf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /lib/modules/2.4.0-test13-pre3/kernel/arch/i386/kernel/apm.o: unresolved
> symbol pm_active
> 
> This is my first time building APM as a module, so I don't know when the
> error was first introduced...

13pre in the Makefile redo

pm.o should be listed as a symbol exporting object in kernel/Makefile

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
