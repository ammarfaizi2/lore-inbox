Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289171AbSAMMwp>; Sun, 13 Jan 2002 07:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289172AbSAMMwf>; Sun, 13 Jan 2002 07:52:35 -0500
Received: from linux.kappa.ro ([194.102.255.131]:38350 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S289171AbSAMMwS>;
	Sun, 13 Jan 2002 07:52:18 -0500
Date: Sun, 13 Jan 2002 14:51:57 +0200 (EET)
From: Teodor Iacob <theo@astral.kappa.ro>
X-X-Sender: <theo@linux.kappa.ro>
Reply-To: <Teodor.Iacob@astral.kappa.ro>
To: <linux-kernel@vger.kernel.org>
Subject: APIC error on CPUx
Message-ID: <Pine.LNX.4.31.0201131451270.28863-100000@linux.kappa.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-RAVMilter-Version: 8.3.0(snapshot 20011220) (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just got the following message in syslog:
Jan 13 14:35:00 firelog kernel: APIC error on CPU1: 00(02)

And from what I saw in the source it seems to be something bad that
shouldn't happen. Could someone explain this?

I am using kernel 2.4.18-pre3 with the latest ext3 patch especially for
this release.

The hardware configuration would be:

PCI listing:
00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev
22)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
10)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 30)
00:0c.0 RAID bus controller: Promise Technology, Inc.: Unknown device 0d30
(rev 02)
00:0e.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)
00:0f.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)
00:11.0 SCSI storage controller: Adaptec 7892B (rev 02)
00:12.0 VGA compatible controller: Cirrus Logic GD 5446 (rev 45)

CPU listing:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 668.208
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1333.65

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 668.208
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1333.65


Teo



