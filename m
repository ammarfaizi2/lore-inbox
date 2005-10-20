Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751774AbVJTGoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbVJTGoI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 02:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbVJTGoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 02:44:08 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:48057 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751774AbVJTGoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 02:44:06 -0400
Date: Thu, 20 Oct 2005 02:43:58 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Frank Sorenson <frank@tuxrocks.com>
cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
In-Reply-To: <435677DE.9010805@tuxrocks.com>
Message-ID: <Pine.LNX.4.58.0510200242300.27683@localhost.localdomain>
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain>
 <435677DE.9010805@tuxrocks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Oct 2005, Frank Sorenson wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Steven Rostedt wrote:
> > 358.069795728 secs then later 355.981483177.  Should this ever happen?
>
> Pretty sure that "NO" is the correct answer :)

By definition, I figured as much :-)

>
> > FYI, the system is UP. And I compiled without CONFIG_KTIME_SCALAR.
>
> What sort of CPU?  Does it have frequency scaling?
>

Well, it's a normal desktop PC (not a laptop) but here's cpuinfo:

snoopy:~/rt_linux# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.00GHz
stepping        : 7
cpu MHz         : 1994.256
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 3990.73


-- Steve

