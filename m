Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129272AbRCAUPo>; Thu, 1 Mar 2001 15:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129858AbRCAUPf>; Thu, 1 Mar 2001 15:15:35 -0500
Received: from [213.96.124.18] ([213.96.124.18]:51947 "HELO dardhal")
	by vger.kernel.org with SMTP id <S129272AbRCAUPQ>;
	Thu, 1 Mar 2001 15:15:16 -0500
Date: Thu, 1 Mar 2001 21:16:43 +0000
From: José Luis Domingo López 
	<jldomingo@crosswinds.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac7
Message-ID: <20010301211643.B1559@dardhal.mired.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E14YHw1-0006x4-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.12i
In-Reply-To: <E14YHw1-0006x4-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Mar 01, 2001 at 01:31:10AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 01 March 2001, at 01:31:10 +0000,
Alan Cox wrote:

> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/
> 
> 2.4.2-ac7
> o	Fix the non booting winchip/cyrix problem	(me)
> 
Linux 2.4.2-ac7 reports wrong CPU speed and model name for a Pentium III
correctly detected on, at least, 2.2.18, 2.4.2 and 2.4.2-ac4. The
processor is a 600 MHz one, with a 133 MHz front bus.

Linux 2.2.18
------------
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 598.475
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
pat p
se36 mmx fxsr xmm
bogomips        : 1192.75


Linux 2.4.2-ac4
---------------
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 598.481
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat p
se36 mmx fxsr sse
bogomips        : 1192.75

Linux 2.4.2-ac7
---------------
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Heavily Overclocked Pentium III (Katmai) (300Mhz/66Mhz
FSB)
stepping        : 3
cpu MHz         : 598.495
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat p
se36 mmx fxsr sse
bogomips        : 1192.75

-- 
José Luis Domingo López
Linux Registered User #189436     Debian GNU/Linux Potato (P166 64 MB RAM)
 
jdomingo AT internautas DOT   org  => Spam at your own risk

