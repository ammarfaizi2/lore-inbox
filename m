Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbTHZPZv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 11:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbTHZPZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 11:25:51 -0400
Received: from modemcable009.53-202-24.mtl.mc.videotron.ca ([24.202.53.9]:51841
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261179AbTHZPZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 11:25:36 -0400
Date: Tue, 26 Aug 2003 11:24:34 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where'd my second proc go?
In-Reply-To: <20030826151225.GT16183@rdlg.net>
Message-ID: <Pine.LNX.4.53.0308261124200.6876@montezuma.fsmlabs.com>
References: <20030826151225.GT16183@rdlg.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Aug 2003, Robert L. Harris wrote:

> 
> 
> Dual-P3-850.  Bios reports both procs.  2.4.21-ac3 reported both procs.
> 2.4.22-rc2-ac1 only shows one.  The lilo used to have a "maxcpus=1"
> append but I removed that and I tried changing it to 4 even.  cat
> /proc/cpu only shows 1 still.

dmesg?

> root# cat /proc/cpuinfo 
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 8
> model name      : Pentium III (Coppermine)
> stepping        : 3
> cpu MHz         : 846.342
> cache size      : 256 KB
> physical id     : 0
> siblings        : 1
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 mmx fxsr sse
> bogomips        : 1684.27
> 
> root# uname -a
> Linux nms-hub2.acs.pnap.net 2.4.22-rc2-ac1 #1 SMP Sat Aug 9 12:32:27 EDT 2003 i686 unknown
> 
> 
> Pushing to the latest 2.4.22 kernel would be a nightmare as that means
> another testing cycle and 2.4.23 will be out before it gets passed.
> 
> Thoughts?
>   Robert
> 
> 
> 
> :wq!
> ---------------------------------------------------------------------------
> Robert L. Harris                     | GPG Key ID: E344DA3B
>                                          @ x-hkp://pgp.mit.edu
> DISCLAIMER:
>       These are MY OPINIONS ALONE.  I speak for no-one else.
> 
> Life is not a destination, it's a journey.
>   Microsoft produces 15 car pileups on the highway.
>     Don't stop traffic to stand and gawk at the tragedy.
> 
