Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310460AbSCPR2P>; Sat, 16 Mar 2002 12:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310468AbSCPR2G>; Sat, 16 Mar 2002 12:28:06 -0500
Received: from pcls2.std.com ([199.172.62.104]:44241 "EHLO TheWorld.com")
	by vger.kernel.org with ESMTP id <S310460AbSCPR15>;
	Sat, 16 Mar 2002 12:27:57 -0500
Message-ID: <3C938093.D1640CB6@world.std.com>
Date: Sat, 16 Mar 2002 12:27:48 -0500
From: Gordon J Lee <gordonl@world.std.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.18-m1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: IBM x360 2.2.x boot failure, 2.4.9 works fine
In-Reply-To: <3C927F3E.7C7FB075@world.std.com> <20020315234333.GH5563@kroah.com> <3C92B1EA.F40BDBD5@world.std.com> <20020316055542.GA8125@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > 2.4.9     works fine!
> > >
> > > Forgot to mention, how many processors does this kernel show you having?
> >
> > It has two physical packages, and shows two processors.  See below.
>
> Ah, can you try the latest 2.4.19-ac tree and make sure that the rest of
> your processors (the "evil" twins) show up?

Yes, they show up.  I tried 'cat /proc/cpuinfo' on the following:

2.4.18  shows two processors
2.4.19-pre3 shows two processors
2.4.19-pre3-ac1 shows four processors

Here is the output from 2.4.19-pre3-ac1:

[root@x360 /root]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Xeon(TM) CPU 1.60GHz
stepping        : 1
cpu MHz         : 1600.400
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3191.60

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Xeon(TM) CPU 1.60GHz
stepping        : 1
cpu MHz         : 1600.400
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3198.15

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Xeon(TM) CPU 1.60GHz
stepping        : 1
cpu MHz         : 1600.400
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3198.15

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Xeon(TM) CPU 1.60GHz
stepping        : 1
cpu MHz         : 1600.400
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3198.15



