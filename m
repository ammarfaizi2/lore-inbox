Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318058AbSIJU0W>; Tue, 10 Sep 2002 16:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318061AbSIJU0W>; Tue, 10 Sep 2002 16:26:22 -0400
Received: from pD9E23544.dip.t-dialin.net ([217.226.53.68]:50366 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318058AbSIJU0V>; Tue, 10 Sep 2002 16:26:21 -0400
Date: Tue, 10 Sep 2002 14:31:17 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] undo 2.5.34 ftape damage
In-Reply-To: <15742.2206.709234.102259@kim.it.uu.se>
Message-ID: <Pine.LNX.4.44.0209101430090.10048-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 10 Sep 2002, Mikael Pettersson wrote:
> In the 2.5.33->2.5.34 step someone removed "export-objs" from
> drivers/char/ftape/lowlevel/Makefile, which makes it impossible to build
> ftape as a module since is _does_ have a number of EXPORT_SYMBOL's.

This is the expsyms output. Draw your own conclusions on what should be 
done.

Remove arch/arm/kernel/apm.o.
Remove arch/arm/mach-clps711x/leds-p720t.o.
Remove arch/arm/mach-integrator/leds.o.
Add arch/arm/mach-ftvpci/leds.o.
Remove arch/arm/mach-pxa/irq.o.
Remove arch/arm/mach-pxa/sa1111.o.
Remove arch/arm/mach-sa1100/irq.o.
Remove arch/arm/mach-sa1100/usb_ctl.o.
Remove arch/arm/mach-sa1100/usb_recv.o.
Remove arch/arm/mach-sa1100/usb_send.o.
Remove arch/ppc/amiga/amiga_ksyms.o.
Remove drivers/char/ftape/zftape/zftape_syms.o. <-- Bugger?
Remove drivers/char/pty.o.
Add drivers/usb/class/usb-midi.o.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

