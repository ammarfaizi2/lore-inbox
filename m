Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318500AbSIFKmW>; Fri, 6 Sep 2002 06:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318501AbSIFKmW>; Fri, 6 Sep 2002 06:42:22 -0400
Received: from p0058.as-l043.contactel.cz ([194.108.242.58]:30960 "EHLO
	SnowWhite.SuSE.cz") by vger.kernel.org with ESMTP
	id <S318500AbSIFKmT> convert rfc822-to-8bit; Fri, 6 Sep 2002 06:42:19 -0400
To: "Andrew Vasquez" <andrew.vasquez@qlogic.com>
Cc: vladimir.naprstek@scplyn.cz
Cc: linux-kernel@vger.kernel.org
Subject: qlogic QLA2200F/66 with Compaq HSG80?
From: Pavel@Janik.cz (Pavel =?iso-8859-2?q?Jan=EDk?=)
X-Face: $"d&^B_IKlTHX!y2d,3;grhwjOBqOli]LV`6d]58%5'x/kBd7.MO&n3bJ@Zkf&RfBu|^qL+
 ?/Re{MpTqanXS2'~Qp'J2p^M7uM:zp[1Xq#{|C!*'&NvCC[9!|=>#qHqIhroq_S"MH8nSH+d^9*BF:
 iHiAs(t(~b#1.{w.d[=Z
Date: Fri, 06 Sep 2002 12:49:45 +0200
Message-ID: <m3d6rrcrzq.fsf@Janik.cz>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i386-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we have Compaq Proliant DL380 with two FC cards Qlogic ISP2200A in 64bit
PCI bus.

The system has two CPUS:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 6
cpu MHz		: 996.893
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr xmm
bogomips	: 1992.29

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 6
cpu MHz		: 996.893
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr xmm
bogomips	: 1985.74

We have it running with 2.2.19 with qla driver version 4.46.12b. All
devices on FC switch are visible (on both cards):

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: DEC      Model: HSG80CCL         Rev: V86F
  Type:   Unknown                          ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 00 Lun: 01
  Vendor: DEC      Model: HSG80            Rev: V86F
  Type:   Unknown                          ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 00 Lun: 02
  Vendor: DEC      Model: HSG80            Rev: V86F
  Type:   Unknown                          ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 00 Lun: 03
  Vendor: DEC      Model: HSG80            Rev: V86F
  Type:   Unknown                          ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 00 Lun: 04
  Vendor: DEC      Model: HSG80            Rev: V86F
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 00 Lun: 05
  Vendor: DEC      Model: HSG80            Rev: V86F
  Type:   Unknown                          ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 00 Lun: 06
  Vendor: DEC      Model: HSG80            Rev: V86F
  Type:   Unknown                          ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 00 Lun: 07
  Vendor: DEC      Model: HSG80            Rev: V86F
  Type:   Unknown                          ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: DEC      Model: TL800    (C) DEC Rev: 0409
  Type:   Medium Changer                   ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 01
  Vendor: DEC      Model: TZ89     (C) DEC Rev: 2150
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 02
  Vendor: DEC      Model: TZ89     (C) DEC Rev: 2150
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 03
  Vendor: DEC      Model: TZ89     (C) DEC Rev: 2150
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 04
  Vendor: DEC      Model: TZ89     (C) DEC Rev: 2561
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: DEC      Model: HSG80CCL         Rev: V86F
  Type:   Unknown                          ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 01
  Vendor: DEC      Model: HSG80            Rev: V86F
  Type:   Unknown                          ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 02
  Vendor: DEC      Model: HSG80            Rev: V86F
  Type:   Unknown                          ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 03
  Vendor: DEC      Model: HSG80            Rev: V86F
  Type:   Unknown                          ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 04
  Vendor: DEC      Model: HSG80            Rev: V86F
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 05
  Vendor: DEC      Model: HSG80            Rev: V86F
  Type:   Unknown                          ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 06
  Vendor: DEC      Model: HSG80            Rev: V86F
  Type:   Unknown                          ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 07
  Vendor: DEC      Model: HSG80            Rev: V86F
  Type:   Unknown                          ANSI SCSI revision: 02

We would like to upgrade the system to 2.4.19 with the latest qlogic's
driver 6.1b5. We have succeeded, but HSG80s are no more visible...:

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: DEC      Model: HSG80CCL         Rev: V86F
  Type:   Unknown                          ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: DEC      Model: TL800    (C) DEC Rev: 0409
  Type:   Medium Changer                   ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 01
  Vendor: DEC      Model: TZ89     (C) DEC Rev: 2150
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 02
  Vendor: DEC      Model: TZ89     (C) DEC Rev: 2150
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 03
  Vendor: DEC      Model: TZ89     (C) DEC Rev: 2150
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 04
  Vendor: DEC      Model: TZ89     (C) DEC Rev: 2561
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: DEC      Model: HSG80CCL         Rev: V86F
  Type:   Unknown                          ANSI SCSI revision: 02

We have tried both SMP and NOSMP build, the result is the same (ie. all
device except HSG80s ae visible).

We have also tried to use kernel's qlogicfc:

Sep  7 01:37:37 intranet kernel: qlogicfc0 : Loop Reinitialized
Sep  7 01:37:37 intranet kernel: qlogicfc0 : Link is Up
Sep  7 01:37:37 intranet kernel: qlogicfc1 : Loop Reinitialized
Sep  7 01:37:37 intranet kernel: qlogicfc1 : Link is Up
Sep  7 01:37:37 intranet kernel: qlogicfc1 : Fabric found.
Sep  7 01:37:37 intranet kernel: qlogicfc1 : Port Database
Sep  7 01:37:37 intranet kernel: wwn: 210000e08b02b749  scsi_id: 0  loop_id: 0
Sep  7 01:37:37 intranet kernel: wwn: 50001fe1000e8803  scsi_id: 1  loop_id: 81
Sep  7 01:37:37 intranet kernel: scsi0 : QLogic ISP2200 SCSI on PCI bus 03 device 28 irq 15 base 0x3000
Sep  7 01:37:37 intranet kernel: scsi1 : QLogic ISP2200 SCSI on PCI bus 03 device 30 irq 5 base 0x3400
Sep  7 01:37:37 intranet kernel: qlogicfc0 : Fabric found.
Sep  7 01:37:37 intranet kernel: qlogicfc0 : Get All Next failed 4005.
Sep  7 01:37:37 intranet kernel: qlogicfc0 : Port Database
Sep  7 01:37:37 intranet kernel: wwn: 210000e08b033967  scsi_id: 0  loop_id: 0
Sep  7 01:37:38 intranet kernel: wwn: 500508b3001025f1  scsi_id: 1  loop_id: 81
Sep  7 01:37:41 intranet kernel: qlogicfc0 : Loop Reinitialized
Sep  7 01:37:42 intranet kernel: qlogicfc0 : Fabric found.
Sep  7 01:37:42 intranet kernel: qlogicfc0 : Port Database
Sep  7 01:37:42 intranet kernel: wwn: 210000e08b033967  scsi_id: 0  loop_id: 0
Sep  7 01:37:42 intranet kernel: wwn: 500508b3001025f1  scsi_id: 1  loop_id: 81
Sep  7 01:37:42 intranet kernel: wwn: 50001fe1000e8804  scsi_id: 2  loop_id: 82
Sep  7 01:37:42 intranet kernel:   Vendor: DEC       Model: TL800    (C) DEC  Rev: 0409
Sep  7 01:37:42 intranet kernel:   Type:   Medium Changer                     ANSI SCSI revision: 02
Sep  7 01:37:42 intranet kernel:   Vendor: DEC       Model: TZ89     (C) DEC  Rev: 2150
Sep  7 01:37:42 intranet kernel:   Type:   Sequential-Access                  ANSI SCSI revision: 02
Sep  7 01:37:42 intranet kernel:   Vendor: DEC       Model: TZ89     (C) DEC  Rev: 2150
Sep  7 01:37:42 intranet kernel:   Type:   Sequential-Access                  ANSI SCSI revision: 02
Sep  7 01:37:42 intranet kernel:   Vendor: DEC       Model: TZ89     (C) DEC  Rev: 2150
Sep  7 01:37:42 intranet kernel:   Type:   Sequential-Access                  ANSI SCSI revision: 02
Sep  7 01:37:42 intranet kernel:   Vendor: DEC       Model: TZ89     (C) DEC  Rev: 2561
Sep  7 01:37:42 intranet kernel:   Type:   Sequential-Access                  ANSI SCSI revision: 02
Sep  7 01:37:42 intranet kernel: scsi: unknown type 12
Sep  7 01:37:42 intranet kernel:   Vendor: DEC       Model: HSG80CCL          Rev: V86F
Sep  7 01:37:42 intranet kernel:   Type:   Unknown                            ANSI SCSI revision: 02
Sep  7 01:37:42 intranet kernel: scsi: unknown type 31
Sep  7 01:37:42 intranet kernel:   Vendor: DEC       Model: HSG80             Rev: V86F
Sep  7 01:37:42 intranet kernel:   Type:   Unknown                            ANSI SCSI revision: 02
Sep  7 01:37:42 intranet kernel: scsi: unknown type 31
Sep  7 01:37:42 intranet kernel:   Vendor: DEC       Model: HSG80             Rev: V86F
Sep  7 01:37:42 intranet kernel:   Type:   Unknown                            ANSI SCSI revision: 02
Sep  7 01:37:42 intranet kernel: scsi: unknown type 31
Sep  7 01:37:42 intranet kernel:   Vendor: DEC       Model: HSG80             Rev: V86F
Sep  7 01:37:42 intranet kernel:   Type:   Unknown                            ANSI SCSI revision: 02
Sep  7 01:37:42 intranet kernel:   Vendor: DEC       Model: HSG80             Rev: V86F
Sep  7 01:37:42 intranet kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Sep  7 01:37:42 intranet kernel: scsi: unknown type 31
Sep  7 01:37:42 intranet kernel:   Vendor: DEC       Model: HSG80             Rev: V86F
Sep  7 01:37:42 intranet kernel:   Type:   Unknown                            ANSI SCSI revision: 02
Sep  7 01:37:42 intranet kernel: scsi: unknown type 31
Sep  7 01:37:42 intranet kernel:   Vendor: DEC       Model: HSG80             Rev: V86F
Sep  7 01:37:42 intranet kernel:   Type:   Unknown                            ANSI SCSI revision: 02
Sep  7 01:37:42 intranet kernel: scsi: unknown type 31
Sep  7 01:37:42 intranet kernel:   Vendor: DEC       Model: HSG80             Rev: V86F
Sep  7 01:37:42 intranet kernel:   Type:   Unknown                            ANSI SCSI revision: 02
Sep  7 01:37:42 intranet kernel: scsi: unknown type 12
Sep  7 01:37:42 intranet kernel:   Vendor: DEC       Model: HSG80CCL          Rev: V86F
Sep  7 01:37:42 intranet kernel:   Type:   Unknown                            ANSI SCSI revision: 02
Sep  7 01:37:42 intranet kernel: scsi: unknown type 31
Sep  7 01:37:42 intranet kernel:   Vendor: DEC       Model: HSG80             Rev: V86F
Sep  7 01:37:42 intranet kernel:   Type:   Unknown                            ANSI SCSI revision: 02
Sep  7 01:37:42 intranet kernel: scsi: unknown type 31
Sep  7 01:37:42 intranet kernel:   Vendor: DEC       Model: HSG80             Rev: V86F
Sep  7 01:37:42 intranet kernel:   Type:   Unknown                            ANSI SCSI revision: 02
Sep  7 01:37:42 intranet kernel: scsi: unknown type 31
Sep  7 01:37:42 intranet kernel:   Vendor: DEC       Model: HSG80             Rev: V86F
Sep  7 01:37:42 intranet kernel:   Type:   Unknown                            ANSI SCSI revision: 02
Sep  7 01:37:42 intranet kernel:   Vendor: DEC       Model: HSG80             Rev: V86F
Sep  7 01:37:42 intranet kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Sep  7 01:37:42 intranet kernel: scsi: unknown type 31
Sep  7 01:37:42 intranet kernel:   Vendor: DEC       Model: HSG80             Rev: V86F
Sep  7 01:37:42 intranet kernel:   Type:   Unknown                            ANSI SCSI revision: 02
Sep  7 01:37:43 intranet kernel: scsi: unknown type 31
Sep  7 01:37:43 intranet kernel:   Vendor: DEC       Model: HSG80             Rev: V86F
Sep  7 01:37:43 intranet kernel:   Type:   Unknown                            ANSI SCSI revision: 02
Sep  7 01:37:43 intranet kernel: scsi: unknown type 31
Sep  7 01:37:43 intranet kernel:   Vendor: DEC       Model: HSG80             Rev: V86F
Sep  7 01:37:43 intranet kernel:   Type:   Unknown                            ANSI SCSI revision: 02
Sep  7 01:37:43 intranet kernel: Attached scsi disk sda at scsi0, channel 0, id 2, lun 4
Sep  7 01:37:43 intranet kernel: Attached scsi disk sdb at scsi1, channel 0, id 1, lun 4
Sep  7 01:37:43 intranet kernel: resize_dma_pool: unknown device type 12
Sep  7 01:37:43 intranet kernel: resize_dma_pool: unknown device type 31
Sep  7 01:37:43 intranet last message repeated 5 times
Sep  7 01:37:43 intranet kernel: resize_dma_pool: unknown device type 12
Sep  7 01:37:43 intranet kernel: resize_dma_pool: unknown device type 31
Sep  7 01:37:43 intranet last message repeated 5 times
Sep  7 01:37:43 intranet kernel: SCSI device sda: 71114623 512-byte hdwr sectors (36411 MB)
Sep  7 01:37:43 intranet kernel:  sda: sda1 sda3
Sep  7 01:37:43 intranet kernel: SCSI device sdb: 71114623 512-byte hdwr sectors (36411 MB)
Sep  7 01:37:43 intranet kernel:  sdb: sdb1 sdb3

So it to sees all devices, but there were problems when accessing
filesystems on the disks (ls -l in the directory from FC took about
a minute to finish and did not print correct informations). Kernel driver
is unusable for us. Our goal is to see HSG80s with the latest qlogic driver
so we can create multipath failover configuration then.

There are some comments about Compaq HSG80 in the sources and makefile. We
also tried to build the module with HSG80=y, but the result is the same. We
have also tried to modify values of HSG* variables, but no difference...

There is a tarball with all datas we collected at http://www.janik.cz/tmp/qlogic-compag-hsg80.tar.gz
We can provide any further details you want.

Is there anyone running that card with Compaq's HSG80? In multipath
failover configuration?
-- 
Pavel Janík

jfs (beta 0.3.4) has a major bug in "rm -rf tree/", so remove was done
twice for complete removal.
                  -- Matthias Eckermann in some mailing-list



