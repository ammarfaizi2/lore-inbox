Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbWFSX4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbWFSX4B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 19:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWFSX4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 19:56:00 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:24287 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932553AbWFSX4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 19:56:00 -0400
Date: Mon, 19 Jun 2006 17:53:29 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: kernel-x64-smp-multiprocessor-speed & bogomips problem in
 /proc/cpuinfo
In-reply-to: <fa.dmtq+XkP55RoiOTQhW+l7Whdwqk@ifi.uio.no>
To: art@usfltd.com
Cc: linux-kernel@vger.kernel.org
Message-id: <449738F9.7020505@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.dmtq+XkP55RoiOTQhW+l7Whdwqk@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

art@usfltd.com wrote:
> kernel-x64-smp-multiprocessor-speed & bogomips problem in /proc/cpuinfo
> 
> $cat /proc/cpuinfo
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 15
> model           : 43
> model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4200+
> stepping        : 1
> cpu MHz         : 1000.000
> cache size      : 512 KB
> physical id     : 0
> siblings        : 2
> core id         : 0
> cpu cores       : 2
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
> mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext 
> fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy
> bogomips        : 2005.64
> TLB size        : 1024 4K pages
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 40 bits physical, 48 bits virtual
> power management: ts fid vid ttp

If the CPU supports clock frequency changes then this clock 
speed/BogoMIPS value may be correct at the time the file was viewed if 
CPU load was low.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

