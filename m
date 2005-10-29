Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbVJ2LPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbVJ2LPp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 07:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbVJ2LPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 07:15:45 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:49544 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1750946AbVJ2LPo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 07:15:44 -0400
Subject: Re: 4GB memory and Intel Dual-Core system
From: Marcel Holtmann <marcel@holtmann.org>
To: Dave Jones <davej@redhat.com>
Cc: Lukas Hejtmanek <xhejtman@mail.muni.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20051029033229.GA13257@redhat.com>
References: <20051028205833.GM2533@mail.muni.cz>
	 <20051029033229.GA13257@redhat.com>
Content-Type: text/plain
Date: Sat, 29 Oct 2005 13:15:24 +0200
Message-Id: <1130584524.5360.1.camel@blade>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

>  > I have system with 2 Pentium 4 Xeon EM64T processors using 4GB of RAM.
>  > 
>  > Kernel is 2.6.13.4 compiled for x86_64 architecture.
>  > 
>  > Btw, /proc/cpuinfo reports, that only 36 bits are availalable for physical 
>  > memory. Not 40.
> 
> That should be fixed in 2.6.14

is this only true for the Xeon series or should it be 40 bits for every
EM64T capable CPU from Intel? I ask, because mine still shows 36 bits
with the latest vanilla from today.

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      :               Intel(R) Pentium(R) D CPU 2.80GHz
stepping        : 4
cpu MHz         : 2800.229
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall lm constant_tsc pni monitor ds_cpl cid cx16 xtpr
bogomips        : 5609.23
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:

Regards

Marcel


