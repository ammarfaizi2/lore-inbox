Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267242AbTAPTqn>; Thu, 16 Jan 2003 14:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267238AbTAPTqn>; Thu, 16 Jan 2003 14:46:43 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:32734
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267242AbTAPTqm>; Thu, 16 Jan 2003 14:46:42 -0500
Date: Thu, 16 Jan 2003 14:54:04 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: sfr@canb.auug.org.au, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_APM_DISPLAY_BLANK problem in the 2.5 kernel
In-Reply-To: <15910.35488.252418.356477@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.44.0301161451330.24067-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2003, Mikael Pettersson wrote:

> However, 2.5 kernels tend to hang the machine when the console screen
> blanker kicks in. "Tend to" as in almost but not quite always.
> Recently I found that disabling APM_DISPLAY_BLANK eliminates the hangs.
> 
> My other boxes don't have any problems with APM_DISPLAY_BLANK, and this
> box does run 2.4 fine with APM_DISPLAY_BLANK, so it seems there must
> be some change in the 2.5 kernel's APM driver that is problematic on
> this particular box.
> 
> (UP_APIC, APM, and APM_DO_ENABLE are enabled; IO_APIC, SMP, PREEMPT, ACPI,
> and the other APM options are disabled. PCI S3 Trio64V2/DX graphics card.)

I've seen the same thing on a laptop, on my system the display just never 
comes back on again, although i can still use it via a serial console or 
network. I only know it was CONFIG_APM related because i can't reproduce 
without it, i just never looked into it.

	Zwane
-- 
function.linuxpower.ca

