Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132418AbRDNPlb>; Sat, 14 Apr 2001 11:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132422AbRDNPlU>; Sat, 14 Apr 2001 11:41:20 -0400
Received: from harrier.mail.pas.earthlink.net ([207.217.121.12]:750 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S132418AbRDNPlJ>; Sat, 14 Apr 2001 11:41:09 -0400
Date: Sat, 14 Apr 2001 11:43:16 -0400 (EDT)
From: Tim lawless <lawless@netdoor.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Athlon runtime problems
In-Reply-To: <E14oRie-000556-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0104141140370.1157-100000@ebola.conservatory>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Apr 2001, Alan Cox wrote:

> Can the folks who are seeing crashes running athlon optimised kernels all mail
> me
>
> -	CPU model/stepping
Athlon Thunderbird 700mhz

/proc/cpu:

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 4
model name	: AMD Athlon(tm) Processor
stepping	: 2
cpu MHz		: 700.034
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 1395.91

> -	Chipset

VIA KT133

> -	Amount of RAM

256MB

> -	/proc/mtrr output

reg00: base=0x00000000 (   0MB), size= 256MB: write-back, count=1
reg01: base=0xd4000000 (3392MB), size=  32MB: write-combining, count=2
reg05: base=0xd0000000 (3328MB), size=  64MB: write-combining, count=3

> -	compiler used

kgcc under redhat:
gcc driver version 2.95.3 19991030 (prerelease) executing gcc version
egcs-2.91.66

>
> Alan
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
There are a thousand hacking at the branches of evil to the one
who is striking at the root.
				--Henry D. Thoreau


