Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312842AbSCZXia>; Tue, 26 Mar 2002 18:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312846AbSCZXiV>; Tue, 26 Mar 2002 18:38:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3595 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312842AbSCZXiG>; Tue, 26 Mar 2002 18:38:06 -0500
Subject: Re: SMP motherboards (760 MPX chipset) and SMP howto
To: emmanuel_michon@realmagic.fr (Emmanuel Michon)
Date: Tue, 26 Mar 2002 23:54:40 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7wsn6mx6up.fsf@frog.soft.sdesigns.com> from "Emmanuel Michon" at Mar 27, 2002 12:11:10 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16q0m1-0004Fo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It seems AMD Athlon SMP spec is compatible with Intel's one; can
> someone report that the A7M266-D motherboard with the 760 MPX chipset
> is running fine linux SMP?

When you get past the BIOS problems it works a treat. Just don't believe
the manual or trust the BIOS. Set the BIOS to MP 1.1 not MP 1.4 too,
and don't put a 33Mhz card in a 66MHz slot unless you have the clock
jumpers set to software not fixed (ie how the manual doesnt recommend)

Once you deal with those bios/doc problems its a really nice board. You
want 2.4.19pre3-ac or 2.4.19pre4 for IDE performance.

> People reported that this combo works properly even with two Athlon XP's
> instead of MP's: how do you force this motherboard into SMP mode?

Two older XP cpus normally just work (but remember its not tested cpus then)
The new ones require you modify the athlon mounting to bridge a laser cut

Alan
