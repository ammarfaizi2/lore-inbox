Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131430AbQKYSzk>; Sat, 25 Nov 2000 13:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129770AbQKYSza>; Sat, 25 Nov 2000 13:55:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47170 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S129648AbQKYSzS>; Sat, 25 Nov 2000 13:55:18 -0500
Subject: Re: PROBLEM: crashing kernels
To: mrbig@sneaker.sch.bme.hu
Date: Sat, 25 Nov 2000 18:25:07 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1001124183828.385A-100000@sneaker.sch.bme.hu> from "Mr. Big" at Nov 25, 2000 07:18:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13zk0b-0001CU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> benn compiled into the kernel, and not as a module) always gave the
> errors:
> 
> eth0: Transmit timed out: status 0050  0090 at 134704418/134704432 
> eth0: Trying to restart the transmitter...

Known problem. This one might be fixed in current 2.2.18pre. SOme people
see it some dont

> mistake... But we couldn't go back to oldier kernels (because of the Mylex
> card) so the only possibility is to go forward: we compiled the
> 2.4.0-test11 kernel. It could be usefull also because of the khttpd, at
> least we could free up some memory used by the apache.

You can copy the 2.2.17 updated mylex driver into 2.2.14 and rebuild a kernel
that way. In fact that would be a good test

I'd also be interested to know if 2.2.17 + Rik's vm patch (or + Andrea's
vm patch) is stable. (Rik and Andrea have differing views how to fix it but
both claim they have 8))

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
