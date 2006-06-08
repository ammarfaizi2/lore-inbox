Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965042AbWFHXXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbWFHXXQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 19:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbWFHXXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 19:23:16 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:43920 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S965042AbWFHXXP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 19:23:15 -0400
Message-ID: <4488B159.2070806@cmu.edu>
Date: Thu, 08 Jun 2006 19:23:05 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060529)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: what processor family does intel core duo L2400 belong to?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am configuring the 2.6.17 kernel for a new thinkpad x60s, and I am 
wondering what processor family to select.  The processor is an Intel 
Core Duo L2400, and the gcc people suggested using the prescott march 
for cflags.  It is *not* a celeron.

My guess is the "Pentium-4/Celeron(P4-based)/Pentium-4 M/Xeon" family, 
but maybe someone has a different opinion or can support it.

Here is the /proc/cpuinfo:
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 14
model name	: Genuine Intel(R) CPU           L2400  @ 1.66GHz
stepping	: 8
cpu MHz		: 1662.571
cache size	: 2048 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx pni monitor vmx 
est tm2 xtpr
bogomips	: 3331.72

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 14
model name	: Genuine Intel(R) CPU           L2400  @ 1.66GHz
stepping	: 8
cpu MHz		: 1662.571
cache size	: 2048 KB
physical id	: 0
siblings	: 2
core id		: 1
cpu cores	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx pni monitor vmx 
est tm2 xtpr
bogomips	: 3325.15

Thanks!
George
