Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbUDKElq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 00:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbUDKElq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 00:41:46 -0400
Received: from 10.69-93-172.reverse.theplanet.com ([69.93.172.10]:17090 "EHLO
	gsf.ironcreek.net") by vger.kernel.org with ESMTP id S262221AbUDKEln convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 00:41:43 -0400
From: Andre Eisenbach <andre@ironcreek.net>
Organization: IronCreek.net
To: linux-kernel@vger.kernel.org
Subject: Athlon Mobile XP CPU speed problem
Date: Fri, 9 Apr 2004 17:23:55 +0000
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404091723.55628.andre@ironcreek.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux-Kernel developers,

My notebook [1], powered by a AMD Athlon XP2400+ (k7) is slowing down when 
running on battery. This happens regardless of whether or not cpu frequency 
scaling is enabled or not. /proc/cpuinfo still shows maximum frequency, but 
the computer is definitely slowed down considerably.

ACPI cpu info shows "throttling contro: no" and "limit interface: no".

It seems like the slowdown occurs out of control of linux cpu frequency 
scaling or ACPI.

What may cause this slow-down?
Is there any driver/kernel option which may let me control this behaviour?

Current kernel version used 2.6.5-mm1 with cpufreq and ACPI compiled in.

Thanks,
    André Eisenbach

------
[1] Compaq Presario 2100z


/proc/cpuinfo:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : mobile AMD Athlon(tm) XP2400+
stepping        : 0
cpu MHz         : 1788.568
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3538.94

/proc/acpi/processor/CPU0/info

processor id:            0
acpi id:                 0
bus mastering control:   yes
power management:        yes
throttling control:      no
limit interface:         no
