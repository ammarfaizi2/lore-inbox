Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268614AbRHGP1t>; Tue, 7 Aug 2001 11:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268712AbRHGP1k>; Tue, 7 Aug 2001 11:27:40 -0400
Received: from ns.suse.de ([213.95.15.193]:21261 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S268614AbRHGP1a>;
	Tue, 7 Aug 2001 11:27:30 -0400
Date: Tue, 7 Aug 2001 17:27:31 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Nico Schottelius <nicos@pcsystems.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cpu not detected(x86)
In-Reply-To: <3B7004B2.6351C900@pcsystems.de>
Message-ID: <Pine.LNX.4.30.0108071723040.1610-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2001, Nico Schottelius wrote:

> Hello!
>
> I am trying to run 2.4.7 and have heavily problems with my cpu.
> The kernel retected another speed at every start! I attached
> three times CPUINFO. The cpu in reality is a p3 650 mhz speedstep.
> (may switch down to 500 mhz, but 126 _not_).

Speedstep is voodoo. No-one other than Intel have knowledge of
how it works. On my P3-700 I've seen speeds range from as low
as 2MHz[1] -> 266MHz (using an ACPI kernel), and the 550/700 on APM.
I've also seen other laptops do speed scaling between 2MHz->full clock
speed whilst on APM.

Run the MHz tester (URL below), and put the box under some load.
It should increase the MHz accordingly.  How high it goes seems
to depend on how good your BIOS support for it is.

Also try switching between ACPI & APM kernels, to see what
difference it makes.

regards,

Dave.

[1] Actually slower than this, the MHz calculation code takes some
cycles, so it's an estimate only. http://www.codemonkey.org.uk/MHz.c

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

