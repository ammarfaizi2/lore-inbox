Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293677AbSCPCqX>; Fri, 15 Mar 2002 21:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293678AbSCPCqN>; Fri, 15 Mar 2002 21:46:13 -0500
Received: from pcls4.std.com ([199.172.62.106]:23475 "EHLO TheWorld.com")
	by vger.kernel.org with ESMTP id <S293677AbSCPCqJ>;
	Fri, 15 Mar 2002 21:46:09 -0500
Message-ID: <3C92B1EA.F40BDBD5@world.std.com>
Date: Fri, 15 Mar 2002 21:46:02 -0500
From: Gordon J Lee <gordonl@world.std.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.18-m1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: IBM x360 2.2.x boot failure, 2.4.9 works fine
In-Reply-To: <3C927F3E.7C7FB075@world.std.com> <20020315234333.GH5563@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 2.4.9     works fine!
>
> Forgot to mention, how many processors does this kernel show you having?

It has two physical packages, and shows two processors.  See below.


> I think you need to run the latest 2.4.19-ac kernel to get the second
> processors to show up properly.

I suppose that you mean the second logical processors, right ?
It appears to show only one logical processor for each physical package.
Is there anything else you would like to see while I have an xterm open
on this ?

Straight from the horses mouth, an x360 running 2.4.9:

[root@x360-gw /root]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Xeon(TM) CPU 1.60GHz
stepping        : 1
cpu MHz         : 1600.337
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss tm
bogomips        : 3191.60

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Xeon(TM) CPU 1.60GHz
stepping        : 1
cpu MHz         : 1600.337
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss tm
bogomips        : 3198.15



