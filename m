Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267514AbRG2CoP>; Sat, 28 Jul 2001 22:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267513AbRG2Cn4>; Sat, 28 Jul 2001 22:43:56 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:4110 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S267512AbRG2Cnt>; Sat, 28 Jul 2001 22:43:49 -0400
Date: Sun, 29 Jul 2001 03:43:54 +0100
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Detecting x86 SMP on a UP kernel
Message-ID: <20010729034354.A65028@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: 0898 Dave - Brack Dragon
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Hi, I need to be able to detect underlying x86 SMP hardware
when running a UP kernel, from a module.

This is to avoid trashing the APIC setup on SMP hardware (normally
I have to enable the APIC, re-do the fixmap etc. so I can use the local
APIC with a stock kernel).

I don't want to require a kernel patch if possible (I suppose just 
EXPORT_SYMBOL(smp_found_config) would do ...).

So can someone give me a hint on how I can detect underlying SMP hardware ?

I wouldn't need to do this if the ac tree APIC patches were in the kernel btw

thanks
john

-- 
"I'd rather be rudely informed than politely left in the dark."
