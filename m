Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131900AbQKRXCQ>; Sat, 18 Nov 2000 18:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131932AbQKRXCH>; Sat, 18 Nov 2000 18:02:07 -0500
Received: from kootenai.mcn.net ([204.212.170.6]:34060 "EHLO kootenai.mcn.net")
	by vger.kernel.org with ESMTP id <S131900AbQKRXB5>;
	Sat, 18 Nov 2000 18:01:57 -0500
Message-ID: <3A1703A2.E1448155@mcn.net>
Date: Sat, 18 Nov 2000 15:33:06 -0700
From: TimO <hairballmt@mcn.net>
Organization: Don't you mean Disorganization!?
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: adrian <jimbud@lostland.net>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Freeze on FPU exception with Athlon
In-Reply-To: <Pine.BSO.4.30.0011181332030.1052-100000@getafix.lostland.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

adrian wrote:
> 
> On Sat, 18 Nov 2000, Linus Torvalds wrote:
> 
> > There's almost certainly more than that. I'd love to have a report on my
> > asm-only version, but even so I suspect it also requires the 3dnow stuff,
> 
> I tried all three versions, and no freezes.  I forgot to mention the tests
> were run on a model 2 Athlon (original slot K7, .18 micron).  The kernel
> is compiled with 3dnow support.
> 
> Regards,
> Adrian
> 
>

Mine freezes with both versions of C versions, haven't tried the asm
yet.
gcc-2.95.2 and glibc-2.1.3 both of which are compiled for 486.

-- 
===============processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 2
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 751.000719
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
features        : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1500.77

-- Tim
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
