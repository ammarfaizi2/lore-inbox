Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263387AbTC2Gco>; Sat, 29 Mar 2003 01:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263388AbTC2Gco>; Sat, 29 Mar 2003 01:32:44 -0500
Received: from [61.3.64.2] ([61.3.64.2]:59397 "EHLO Gateway.bksys.co.in")
	by vger.kernel.org with ESMTP id <S263387AbTC2Gcn>;
	Sat, 29 Mar 2003 01:32:43 -0500
Subject: Issues in 2.5.65-ac4
From: "S.Gopi" <sekargopi@yahoo.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 Mar 2003 12:16:21 +0530
Message-Id: <1048920381.2383.22.camel@Agni>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hai,
 
  I recently downloaded kernel 2.5.65, then applied subsequent patch
released by linus for 2.5.66 (patch-2.5.66.bz2),and then applied AC
patch (patch-2.5.66-ac1.bz2)

I got thrugh compilation except few errors in WAN drivers compilation
and character drivers compilation. Thats not my question is about. 

I am using this kernel on RedHat 7.3 filesystem. I have few questions
and here they are.

Question 1:
problem on /proc/cpuinfo. cpuinfo doesnt showup speed in MHz. It shows
it as 0.00. and it shows different bogomips too.

I compared this with 2.4.18-18(kernel distributed by redhat), I am
attaching both the outputs below

2.4.18 /proc/cpuinfo
--------------------
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 1
model name	: Intel(R) Pentium(R) 4 CPU 1.60GHz
stepping	: 2
cpu MHz		: 1594.840
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3164.53



/proc/cpuinfo from 2.5.65-ac4 (that is what being showed up in
/proc/version)
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Pentium(R) 4 CPU 1.60GHz
stepping        : 2
cpu MHz         : 0.000
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 2093.05

either the information provided in 2.4.18 or 2.5.65 is wrong. which is
correct then?

my /proc/version details
Linux version 2.5.65-ac4 (root@Agni) (gcc version 2.96 20000731 (Red Hat
Linux 7.3 2.96-113)) #9 Fri Mar 28 16:13:18 IST 2003

what could be wrong.

Second question: where is /proc/pci gone?

Third question: my KDE kicker doesnt startup, it gets crashed even if i
run as root. It happens so only in kernel 2.5.x and not 2.4.18. what
could be wrong for this?

If any of you want further details, i can post in too. 

Thank you,
Gopi




