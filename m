Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263401AbTHVOhl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 10:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263552AbTHVOhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 10:37:41 -0400
Received: from mail.north-cyprus.net ([212.175.247.6]:22678 "EHLO
	mail.north-cyprus.net") by vger.kernel.org with ESMTP
	id S263401AbTHVOhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 10:37:38 -0400
Date: Fri, 22 Aug 2003 17:42:03 +0300
From: Mehmet Ali Suzen <msuzen@mail.north-cyprus.net>
To: linux-kernel@vger.kernel.org
Subject: Running SMP 2.4.21 #2 SMP Kernel on single processor : Memory Leakage?
Message-ID: <20030822174203.C18548@mail.north-cyprus.net>
References: <3F4601A5.6010600@riptidesoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F4601A5.6010600@riptidesoftware.com>; from chris.curtis@riptidesoftware.com on Fri, Aug 22, 2003 at 07:42:29AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi All,
I am running RedHat Linux 9 Linux 2.4.21 SMP and 
memory usage is increasing regularly even if 
no heavy service like (radiusd,mysqld, httpd, named) is not
running. After some time I get Out of Memory 
messages and system hungs!

It sounds stupid but we are running single cpu.
Would it be possible to have a memory leakage due to SMP 
operations? Board is Intel Server Board SE7501BR2 and 
cpu info:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2392.346
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4771.02

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2392.346
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm


Many thanks for the commets
Cheers,
Mehmet
bogomips        : 4784.12


