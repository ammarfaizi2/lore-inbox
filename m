Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbTJRW32 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 18:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbTJRW3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 18:29:03 -0400
Received: from tdlnx.student.utwente.nl ([130.89.163.214]:30186 "EHLO
	tdlnx.student.utwente.nl") by vger.kernel.org with ESMTP
	id S261885AbTJRW27 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 18:28:59 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Bas Nedermeijer <basneder@tdlnx.student.utwente.nl>
To: linux-kernel@vger.kernel.org
Subject: Network module (de4x5) wont load
Date: Sun, 19 Oct 2003 00:28:57 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200310190028.57264.basneder@tdlnx.student.utwente.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i tried the kernel-2.6.0-test7 and -test8, but my network driver doesnt seem 
te load properly, the system hangs after it reports the driver is in "100 
mbit" mode. I'm using the de4x5 module, and i have the 
module-init-tools-0.9.15-pre2 to load my modules. I'm not sure the problem is 
in the module loading, becausing compiling the module in kernel also hangs 
the system.

Sysinfo (info taken from my 2.4.22 kernel):

Mem: 256MB
Abit BP6 mobo

# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 400.915
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr
bogomips        : 799.53

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 400.915
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr
bogomips        : 801.17


	- Bas Nedermeijer
