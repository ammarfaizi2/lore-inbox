Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310632AbSCLL7y>; Tue, 12 Mar 2002 06:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310688AbSCLL7f>; Tue, 12 Mar 2002 06:59:35 -0500
Received: from unicef.org.yu ([194.247.200.148]:33799 "EHLO unicef.org.yu")
	by vger.kernel.org with ESMTP id <S310632AbSCLL7a>;
	Tue, 12 Mar 2002 06:59:30 -0500
Date: Tue, 12 Mar 2002 12:59:17 +0100 (CET)
From: Davidovac Zoran <zdavid@unicef.org.yu>
To: Shawn Starr <spstarr@sh0n.net>
cc: Linux <linux-kernel@vger.kernel.org>
Subject: Re: uname reports 'unknown'
In-Reply-To: <1015897420.3054.0.camel@coredump>
Message-ID: <Pine.LNX.4.33.0203121253001.11561-100000@unicef.org.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

same here, perhaps it is time to rewrite uname,
to use /proc/cpuinfo ?

root@www:~# uname -a
Linux www 2.2.20 #1 Wed Feb 6 11:23:03 CET 2002 i686 unknown
root@www:~# more /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 350.798
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr
bogomips

On 11 Mar 2002, Shawn Starr wrote:

> Date: 11 Mar 2002 20:43:37 -0500
> From: Shawn Starr <spstarr@sh0n.net>
> To: Linux <linux-kernel@vger.kernel.org>
> Subject: uname reports 'unknown'
>
> Linux coredump 2.4.19-pre2-ac4-xfs-shawn10 #2 Mon Mar 11 03:36:35 EST
> 2002 i586 unknown
>
>
> what should 'unknown' really be? I've never seen it different on Intel
> systems.
>
> Shawn.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

