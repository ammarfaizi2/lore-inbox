Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263502AbTIIKMQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 06:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263965AbTIIKMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 06:12:16 -0400
Received: from indianer.linux-kernel.at ([212.24.125.53]:25024 "EHLO
	indianer.linux-kernel.at") by vger.kernel.org with ESMTP
	id S263502AbTIIKMN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 06:12:13 -0400
Message-Id: <200309091008.h89A8VWZ026604@indianer.linux-kernel.at>
From: Oliver Pitzeier <oliver@linux-kernel.at>
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.6.0-test5
Date: Tue, 9 Sep 2003 12:10:47 +0200
Organization: linux-kernel.at
X-Mailer: Oracle Connector for Outlook 9.0.4 50618 (10.0.4608)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information-linux-kernel.at: Please contact your Internet E-Mail Service Provider for more information
X-MailScanner-linux-kernel.at: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!
Hi folks!

[ ... ]

> Lots of small stuff, as usual. I think the biggest "core" 
> change is the Futex changes by Jamie and Hugh, and the dev_t 
> preparations by Al Viro.

[ ... ]

Thanks a lot! Good job!

 I just compiled/rebooted two of my machines with -test5. And since now everything seems fine/stable. I noticed that rebooting my Digital Alpha AS1000 now works without problems. Before -test5 I had to recycle the machine completly after rebooting, because the SCSI-controller was not resettet correctly (it's a Qlogic ISP1020).

The other machine is an old Intel Celeron with 300 MHz.

Both kernels were compiled without problems. They are pretty small, because I do not need much stuff on those machines... They are just for compiling 2.6.x :)

Details about the Alpha machine:
[root@track /root]# uname -a; rpm -q gcc; rpm -q glibc; rpm -q modutils; \
rpm -q initscripts; cat /proc/cpuinfo
Linux track.uptime.at 2.6.0-test5 #1 Tue Sep 9 12:55:02 CEST 2003 alpha unknown
gcc-3.1-6
glibc-2.2.4-31
modutils-2.4.21-18
initscripts-5.84.1-1
cpu                     : Alpha
cpu model               : EV56
cpu variation           : 7
cpu revision            : 0
cpu serial number       :
system type             : Noritake
system variation        : 0
system revision         : 0
system serial number    :
cycle frequency [Hz]    : 333333333
timer frequency [Hz]    : 1024.00
page size [bytes]       : 8192
phys. address bits      : 40
max. addr. space #      : 127
BogoMIPS                : 663.96
kernel unaligned acc    : 0 (pc=0,va=0)
user unaligned acc      : 0 (pc=0,va=0)
platform string         : AlphaServer 1000A 5/333
cpus detected           : 1

Details about the Intel machine:
[root@moonbase root]# uname -a; rpm -q gcc; rpm -q glibc; rpm -q modutils; \
rpm -q initscripts; cat /proc/cpuinfo
Linux moonbase 2.6.0-test5 #1 Tue Sep 9 10:53:18 CEST 2003 i686 i686 i386 GNU/Linux
gcc-3.2-7
glibc-2.3.2-4.80.6
modutils-2.4.25-8
initscripts-7.28-1
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 0
cpu MHz         : 300.771
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 591.87

Best regards,
 Oliver

