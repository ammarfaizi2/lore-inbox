Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129213AbQKQN4s>; Fri, 17 Nov 2000 08:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbQKQN4i>; Fri, 17 Nov 2000 08:56:38 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:32760 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129213AbQKQN41>; Fri, 17 Nov 2000 08:56:27 -0500
Message-ID: <3A153200.63670F64@haque.net>
Date: Fri, 17 Nov 2000 08:26:24 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jordan <ledzep37@home.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Error in x86 CPU capabilities starting with test5/6
In-Reply-To: <3A14FF48.E554BE1B@home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It used to be..
	flags           : fpu vme de pse tsc msr pae 

but now called features

It's a simple enough change. Contact me privately if you can't any
avifile people to help.

Jordan wrote:
> 
> I have been running a plug in for xmms for some time that uses the
> aviplay program and avifile library...then when upgrading to test5/6 I
> start getting this error message when running xmms:
> 
> ERROR: no time-stamp counter found! Quitting.
> 
> I finally trace it down to my avi plugin and  then from there to the
> actual aviplay program.  I have played with a newer version that had
> more specific error messages one of which told me I had a non-intel
> compatible x86 with no time-stamp counter and to use ./configure
> --disable-tsc to fix  the situation, this is all well and good if the
> plugin didn't rely on an older version where even using the config
> option will not work, here is my /proc/cpuinfo which shows tsc but
> something has got to be wrong with it in recent versions.
> 
> contents of /proc/cpuinfo:
> 
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 8
> model name      : Pentium III (Coppermine)
> stepping        : 3
> cpu MHz         : 733.000092
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> features        : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
> cmov pat pse36 mmx fxsr sse
> bogomips        : 1461.45
> 
> Jordan Breeding
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
