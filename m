Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSGUV1I>; Sun, 21 Jul 2002 17:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314284AbSGUV1H>; Sun, 21 Jul 2002 17:27:07 -0400
Received: from mx2.elte.hu ([157.181.151.9]:3736 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S314138AbSGUV1H>;
	Sun, 21 Jul 2002 17:27:07 -0400
Date: Sun, 21 Jul 2002 23:29:09 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] "big IRQ lock" removal, 2.5.27-A1
In-Reply-To: <20020721221815.E26376@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207212327430.29143-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


new-serial boot messages:

 Serial: 8250/16550 driver $Revision: 1.80 $ IRQ sharing enabled
 ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
 ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A

and it does not crash on UP. (will re-try with SMP now.) Still no serial
console output though.

	Ingo

