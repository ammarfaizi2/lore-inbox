Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129119AbRBANZ4>; Thu, 1 Feb 2001 08:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129278AbRBANZq>; Thu, 1 Feb 2001 08:25:46 -0500
Received: from ckmso1.att.com ([12.20.58.69]:56216 "EHLO ckmso1.proxy.att.com")
	by vger.kernel.org with ESMTP id <S129119AbRBANZf>;
	Thu, 1 Feb 2001 08:25:35 -0500
Message-ID: <0DDEC5E8B4C3D311BE0800902799EC360388FFB3@mo3980po04.ems.att.com>
From: "Willson, Wayne M, NTCOM" <wwillson@att.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Different L2 cache size - will it hurt stability?
Date: Thu, 1 Feb 2001 07:25:19 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I just noticed that one of my production boxes has one CPU with 256K L2
cache and the other has 512K L2 cache.  Will this make the server any less
stable?  If it reduced performance I don't really care, but stability is
paramount.

[root@il05037a /proc]# more cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 1
model name      : Pentium Pro
stepping        : 7
cpu MHz         : 199.455
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov
bogomips        : 398.13

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 1
model name      : Pentium Pro
stepping        : 9
cpu MHz         : 199.455
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
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov
bogomips        : 397.31


Thanks in advance,

Wayne Willson
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
