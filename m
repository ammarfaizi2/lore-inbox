Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143622AbRAHN6l>; Mon, 8 Jan 2001 08:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143665AbRAHN6b>; Mon, 8 Jan 2001 08:58:31 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:14091 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S143622AbRAHN6V>; Mon, 8 Jan 2001 08:58:21 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Mon, 8 Jan 2001 14:58:16 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: 2.4: header file confusion (interrupts)
Message-ID: <3A59D57C.390.1806CA2@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Inspecting some code I found out that in 2.4.0test12

request_irq() is declared in sched.h, and not in interrupt.h,

SA_SHIRQ is declared in asm/signal.h, and not in interrupt.h

Isn't that a bit confusing? Maybe for 2.5 let's re-sort some things to 
clean up dependencies...

Regards,
Ulrich

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
