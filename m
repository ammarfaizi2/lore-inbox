Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268324AbTBMX2u>; Thu, 13 Feb 2003 18:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268322AbTBMX2u>; Thu, 13 Feb 2003 18:28:50 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:36881 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S268324AbTBMX2t>; Thu, 13 Feb 2003 18:28:49 -0500
Date: Thu, 13 Feb 2003 18:35:20 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.20][2.5.60] /proc/interrupts comparsion - two irqs for i8042?
In-Reply-To: <20030212091916.1989c531.rddunlap@osdl.org>
Message-ID: <Pine.LNX.3.96.1030213183228.13517A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2003, Randy.Dunlap wrote:

> Do you have a PS/2 mouse enabled/configured in 2.4?
> I do, and it shows this on 2.4.20:
> 
>   0:   78505022          XT-PIC  timer
>   1:     305438          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   3:    2013477          XT-PIC  xirc2ps_cs
>   5:          0          XT-PIC  usb-uhci
>   8:          1          XT-PIC  rtc
>  10:          4          XT-PIC  i82365
>  11:    2188569          XT-PIC  i82365, cs46xx
>  12:    1555382          XT-PIC  PS/2 Mouse
>  14:     872963          XT-PIC  ide0
>  15:          3          XT-PIC  ide1
> 
> and the driver code certainly requests IRQ 12 for the PS/2 mouse
> when it's configured.

I would agree that the identification is far more useful in 2.4, but it
still takes the same number of IRQ.

Could I ask why the usage information has been de-clarified without
starting a flame war on the politics of the change? I assume there's a
good reason for not just identifying the usage to those who haven't
memorized the PC interrupt defaults.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

