Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131155AbRBJT3Q>; Sat, 10 Feb 2001 14:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131402AbRBJT3G>; Sat, 10 Feb 2001 14:29:06 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:47370 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131155AbRBJT2z>; Sat, 10 Feb 2001 14:28:55 -0500
Subject: Re: IRQ conflicts
To: bgerst@didntduck.org (Brian Gerst)
Date: Sat, 10 Feb 2001 19:28:51 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A8579C9.5511286F@didntduck.org> from "Brian Gerst" at Feb 10, 2001 12:26:33 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14RfhV-0002A1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> <SoundBlaster EMU8000 (RAM2048k)>
> ACPI: Core Subsystem version [20010208]
> ACPI: SCI (IRQ9) allocation failed
> ACPI: Subsystem enable failed
> Trying to free free IRQ9

That seems to indicate acpi is freeing a free irq. Turn ACPI off. Its a
good bet it will fix any random irq/driver problem right now


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
