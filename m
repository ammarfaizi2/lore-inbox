Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265368AbSLPGZW>; Mon, 16 Dec 2002 01:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265369AbSLPGZW>; Mon, 16 Dec 2002 01:25:22 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:8758
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265368AbSLPGZV>; Mon, 16 Dec 2002 01:25:21 -0500
Date: Mon, 16 Dec 2002 01:35:48 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Scott Robert Ladd <scott@coyotegulch.com>
cc: Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: /proc/cpuinfo and hyperthreading
In-Reply-To: <Pine.LNX.4.50.0212160126110.12535-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0212160133300.12535-100000@montezuma.mastecende.com>
References: <FKEAJLBKJCGBDJJIPJLJEEKADLAA.scott@coyotegulch.com>
 <Pine.LNX.4.50.0212160126110.12535-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2002, Zwane Mwaikambo wrote:

> On Sun, 15 Dec 2002, Scott Robert Ladd wrote:
>
> > But later in the boot, it also states:
> >
> > Dec 15 11:51:18 Tycho kernel: SMP motherboard not detected.
> >
> > Something just doesn't look right about this.
>
> Thats just the MP table parsing code whining. Which is ok since you're
> using ACPI... hmm then again...
>
> if (!smp_found_config) {
>                 printk(KERN_NOTICE "SMP motherboard not detected.\n");
>                 smpboot_clear_io_apic_irqs();
>                 phys_cpu_present_map = 1;
>                 if (APIC_init_uniprocessor())

Dec 15 14:30:34 Tycho kernel: CPUS done 2

It's ok.

(I feel like Jekyll & Hyde)...

-- 
function.linuxpower.ca
