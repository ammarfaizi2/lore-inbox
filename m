Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312925AbSC0ByW>; Tue, 26 Mar 2002 20:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312953AbSC0ByN>; Tue, 26 Mar 2002 20:54:13 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25868 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312925AbSC0Bx7>; Tue, 26 Mar 2002 20:53:59 -0500
Subject: Re: Linux 2.4.19-pre4-ac2
To: davis@jdhouse.org (Jonathan A. Davis)
Date: Wed, 27 Mar 2002 02:10:33 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <1017193625.1435.18.camel@bacchus.jdhouse.org> from "Jonathan A. Davis" at Mar 26, 2002 07:47:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16q2tV-0004VQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> By chance I was culling through my boot log and noticed the following:
> 
> Initializing CPU#0
> Detected 8132.282 MHz processor.

Fascinating - that suggest timer interrupts are going missing (the alternative
would involve clouds of smoke from your PC)

> Looking through my boot logs, this problem seems to start somewhere
> between 2.4.19-pre2-ac4 and 2.4.19-pre4-ac1 (I didn't run any of the
> intervening releases).

I would suspect APIC/IRQ routing changes.

Do you see the same break between 2.4.19-pre2 and 2.4.19-pre4 vanilla releases ?
