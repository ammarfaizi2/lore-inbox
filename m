Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287896AbSAMBR3>; Sat, 12 Jan 2002 20:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287899AbSAMBRU>; Sat, 12 Jan 2002 20:17:20 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9988 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287896AbSAMBRN>; Sat, 12 Jan 2002 20:17:13 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: zippel@linux-m68k.org (Roman Zippel)
Date: Sun, 13 Jan 2002 01:28:36 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), yodaiken@fsmlabs.com,
        landley@trommello.org (Rob Landley), rml@tech9.net (Robert Love),
        nigel@nrg.org, akpm@zip.com.au (Andrew Morton),
        linux-kernel@vger.kernel.org
In-Reply-To: <3C409FB2.8D93354F@linux-m68k.org> from "Roman Zippel" at Jan 12, 2002 09:42:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PZRs-0003g8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Preemption doesn't solve of course every problem. It's mainly useful to
> get an event as fast as possible from kernel to user space. This can be
> the mouse click or the buffer your process is waiting for. Latencies can
> quickly sum up here to be sensible.

The pre-emption patch doesn't change the average latencies. Go run some real
benchmarks. Its lost in the noise after the low latency patch. A single inw
from some I/O cards can cost as much as the latency target we hit.

Its not a case of the 90% of the result with 10% of the work, the pre-empt
patch is firmly in the all pain no gain camp

