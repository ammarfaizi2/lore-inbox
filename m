Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267650AbRGZHGh>; Thu, 26 Jul 2001 03:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267664AbRGZHG1>; Thu, 26 Jul 2001 03:06:27 -0400
Received: from wawura.off.connect.com.au ([202.21.9.2]:64691 "HELO
	wawura.off.connect.com.au") by vger.kernel.org with SMTP
	id <S267650AbRGZHGR>; Thu, 26 Jul 2001 03:06:17 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: how to tell Linux *not* to share IRQs ? 
In-Reply-To: Your message of "Thu, 26 Jul 2001 00:37:08 +0100."
             <E15PYDE-0002tj-00@the-village.bc.nu> 
Date: Thu, 26 Jul 2001 17:06:21 +1000
From: Andrew McNamara <andrewm@connect.com.au>
Message-Id: <20010726070621.D69A1BE91@wawura.off.connect.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

>The actual sharing rules for PCI interrupt lines are frequently determined
>by the actual wiring on the motherboard. It is quite possible the interrupt
>lines on some of your slots are physically wired together, and indeed quite
>likely that this is true if you have five or more slots

Does this mean the ISRs for every driver sharing an interrupt have to
poll their device when an interrupt comes in (in the case of shared PCI
interrupts), or is there some additional hardware smarts so the kernel
knows which driver's ISRs need to be invoked?

 ---
Andrew McNamara (System Architect)

connect.com.au Pty Ltd
Lvl 3, 213 Miller St, North Sydney, NSW 2060, Australia
Phone: +61 2 9409 2117, Fax: +61 2 9409 2111
