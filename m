Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267378AbTGLCuI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 22:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267381AbTGLCuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 22:50:08 -0400
Received: from sps.nus.edu.sg ([137.132.69.89]:54287 "HELO sps.nus.edu.sg")
	by vger.kernel.org with SMTP id S267378AbTGLCuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 22:50:03 -0400
Date: Sat, 12 Jul 2003 10:58:14 +0800 (SGT)
From: Didier Casse <didierbe@sps.nus.edu.sg>
To: linux-kernel@vger.kernel.org
Subject: cpufreq.c compilation error when recompiling kernel 
Message-ID: <Pine.LNX.4.44.0307121057360.26536-100000@kepler.sps.nus.edu.sg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
   I tried to recompile the kernel of my redhat 9 to add a parport scanner 
but when I tried "make modules", I got this error:

-----------------------------------------------------------
/usr/src/linux-2.4.20-8/include/linux/dcache.h: In function `dget':
/usr/src/linux-2.4.20-8/include/linux/dcache.h:254: warning: implicit 
declaratio 
n of function `__out_of_line_bug_R8b0fd3c5'
cpufreq.c: In function `cpufreq_parse_policy':
cpufreq.c:111: warning: implicit declaration of function 
`sscanf_R859204af'
cpufreq.c: In function `cpufreq_proc_read':
cpufreq.c:225: warning: implicit declaration of function 
`sprintf_R1d26aa98'
cpufreq.c: In function `cpufreq_proc_init':
cpufreq.c:327: warning: implicit declaration of function 
`printk_R1b7d4074'
cpufreq.c: In function `cpufreq_notify_transition_R974516e6':
cpufreq.c:961: parse error before "int"
cpufreq.c: In function `cpufreq_restore':
cpufreq.c:1110: warning: implicit declaration of function 
`panic_R01075bf0'
cpufreq.c: At top level:
cpufreq.c:192: warning: `cpufreq_setup' defined but not used
make[1]: *** [cpufreq.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.20-8/kernel'
make: *** [_mod_kernel] Error 2
-------------------------------------------------------------

and it just ended. Anybody got this problem before and know the turnaround 
for this?  Thanks for helping out.




-- 

Didier

PhD student

Singapore Synchrotron Light Source (SSLS)
5 Research Link,
Singapore 117603

Email: slsbdfc@nus.edu.sg or didierbe@sps.nus.edu.sg
Website: http://ssls.nus.edu.sg





