Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318207AbSHZS7Z>; Mon, 26 Aug 2002 14:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318216AbSHZS7Z>; Mon, 26 Aug 2002 14:59:25 -0400
Received: from stargazer.compendium-tech.com ([64.156.208.76]:10756 "EHLO
	stargazer.compendium.us") by vger.kernel.org with ESMTP
	id <S318207AbSHZS7X>; Mon, 26 Aug 2002 14:59:23 -0400
Date: Mon, 26 Aug 2002 12:00:35 -0700 (PDT)
From: Kelsey Hudson <khudson@compendium.us>
X-X-Sender: khudson@betelgeuse.compendium-tech.com
To: Banai Zoltan <bazooka@emitel.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Hyperthreading
In-Reply-To: <20020821215503.GC1669@bazooka.saturnus.vein.hu>
Message-ID: <Pine.LNX.4.44.0208261157200.6621-100000@betelgeuse.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2002, Banai Zoltan wrote:

> If this is correct, and there is not destop P4 capable of ht,
> then what does mean the ht flag in cpuinfo?

That's a good question. I'm not sure.

> $cat /proc/cpuinfo 
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 1
> model name      : Intel(R) Pentium(R) 4 CPU 1.70GHz
> stepping        : 2
> cpu MHz         : 1694.907
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> bogomips        : 3381.65
>                                                          ^^

You could always compile an SMP kernel and turn on ACPI System support... 
If your machine boots up and shows two CPUs, it's hyperthread-capable. 
Note that your BIOS also must support this feature...

-- 
 Kelsey Hudson                                       khudson@compendium.us
 Software Engineer/UNIX Systems Administrator
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------

