Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318168AbSIJV6X>; Tue, 10 Sep 2002 17:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318169AbSIJV6X>; Tue, 10 Sep 2002 17:58:23 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20240 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318168AbSIJV6V>; Tue, 10 Sep 2002 17:58:21 -0400
Date: Tue, 10 Sep 2002 23:03:01 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] undo 2.5.34 ftape damage
Message-ID: <20020910230301.A15349@flint.arm.linux.org.uk>
References: <15742.2206.709234.102259@kim.it.uu.se> <Pine.LNX.4.44.0209101430090.10048-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209101430090.10048-100000@hawkeye.luckynet.adm>; from thunder@lightweight.ods.org on Tue, Sep 10, 2002 at 02:31:17PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 02:31:17PM -0600, Thunder from the hill wrote:
> This is the expsyms output. Draw your own conclusions on what should be 
> done.

We've been through this before.  I'd have thought you'd have learnt by
now, but you've obviously got some bug bear here that you can't get
over.

This is getting worse than ESR.

> Remove arch/arm/kernel/apm.o.
> Remove arch/arm/mach-clps711x/leds-p720t.o.
> Remove arch/arm/mach-integrator/leds.o.
> Add arch/arm/mach-ftvpci/leds.o.
> Remove arch/arm/mach-pxa/irq.o.
> Remove arch/arm/mach-pxa/sa1111.o.
> Remove arch/arm/mach-sa1100/irq.o.
> Remove arch/arm/mach-sa1100/usb_ctl.o.
> Remove arch/arm/mach-sa1100/usb_recv.o.
> Remove arch/arm/mach-sa1100/usb_send.o.
> Remove arch/ppc/amiga/amiga_ksyms.o.
> Remove drivers/char/ftape/zftape/zftape_syms.o. <-- Bugger?
> Remove drivers/char/pty.o.
> Add drivers/usb/class/usb-midi.o.
> 
> 			Thunder
> -- 
> --./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
> --/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
> .- -/---/--/---/.-./.-./---/.--/.-.-.-
> --./.-/-.../.-./.././.-../.-.-.-
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

