Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315919AbSHFV22>; Tue, 6 Aug 2002 17:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315921AbSHFV22>; Tue, 6 Aug 2002 17:28:28 -0400
Received: from [209.184.141.189] ([209.184.141.189]:19589 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S315919AbSHFV21>;
	Tue, 6 Aug 2002 17:28:27 -0400
Subject: 2.4.19 See's incorrect cache size on P4 Xeons!?
From: Austin Gonyou <austin@digitalroadkill.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1028669517.6549.100.camel@UberGeek.coremetrics.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 06 Aug 2002 16:31:58 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

from cat /proc/cpuinfo:

processor       : 7
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Xeon(TM) CPU 1.60GHz
stepping        : 1
cpu MHz         : 1592.180
>>>>cache size      : 256 KB<<<<<<
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
bogomips        : 3178.49

On boot each processor is says it has 1MB L3, is 2.4.19 unable to read
that or something?

TIA

-- 
Austin Gonyou <austin@digitalroadkill.net>
