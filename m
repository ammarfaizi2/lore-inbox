Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129790AbRAKOAO>; Thu, 11 Jan 2001 09:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129810AbRAKOAF>; Thu, 11 Jan 2001 09:00:05 -0500
Received: from tor.igf.edu.pl ([148.81.235.26]:19904 "EHLO tor.igf.edu.pl")
	by vger.kernel.org with ESMTP id <S129790AbRAKN7w>;
	Thu, 11 Jan 2001 08:59:52 -0500
From: Wojciech Czuba <wojt@igf.edu.pl>
Message-Id: <200101111359.OAA16967@seismol1.igf.edu.pl>
Subject: CRC and ECC error burning CD (adaptec 2940), kernel 2.2.18
To: linux-kernel@vger.kernel.org
Date: Thu, 11 Jan 2001 14:59:29 +0100 (MET)
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi,

  Please, get the information below and help me, if possible...

  Regards,

  Wojtek Czuba
wojt@igf.edu.pl



[1.] CRC and ECC error burning CD (adaptec 2940), kernel 2.2.18
[2.] VMWARE Workstation said that my cdrom will work as an audio
device with Windows 9x under the vmware with the 2.2.16-22 kernel, so
I moved to the 2.2.18. I can't start it with aic7xxx (for adaptec 2940
PCI) compiled as a module (booting stops trying to load this module).
It works with aic7xxx compiled into the kernel and scsi interface
works rather well except of burning cdroms using xcdroast (installed
together with RedHat 7.0). I've got crc or ecc error about 1% after
starting writing cdrom...
[3.] scsi, adaptec 2940, modules
[4.] Linux version 2.2.18 (root@dsswc.igf.edu.pl) (gcc version
egcs-2.91.66 19990314/
Linux (egcs-1.1.2 release)) #1 Thu Jan 11 10:34:29 CET 2001
[5.] no message
[7.] Pentium II 266 MHz, 128 MB RAM, Adaptec 2940
[7.1.]
-- Versions installed: (if some fields are empty or looks
-- unusual then possibly you have very old versions)
Linux dsswc.igf.edu.pl 2.2.18 #1 Thu Jan 11 10:34:29 CET 2001 i686
unknown
Kernel modules         2.3.14
Gnu C                  2.96
Binutils               2.10.0.18
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.7
Mount                  2.10m
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         vmnet vmppuser parport_pc vmmon nfsd autofs
ne2k-pci 8390 nls_cp437

[7.2.] 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 3
model name      : Pentium II (Klamath)
stepping        : 3
cpu MHz         : 266.445
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
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov mmx
bogomips        : 530.84

[7.3.] 
vmnet                  16320   3
vmppuser                5528   0
parport_pc              7480   0 [vmppuser]
vmmon                  17792   0
nfsd                  162888   8 (autoclean)
autofs                  9160   1 (autoclean)
ne2k-pci                4648   1 (autoclean)
8390                    6420   0 (autoclean) [ne2k-pci]
nls_cp437               3872   4 (autoclean)

[7.4.]
Attached devices: 
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: RICOH    Model: MP6200S          Rev: 2.20
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.5.]
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel 440LX - 82443LX PAC Host (rev 3).
      Medium devsel.  Fast back-to-back capable.  Master Capable.
Latency=32.  
      Prefetchable 32 bit memory at 0xf8000000 [0xf8000008].
  Bus  0, device   1, function  0:
    PCI bridge: Intel 440LX - 82443LX PAC AGP (rev 3).
      Medium devsel.  Fast back-to-back capable.  Master Capable.
Latency=64.  
Min Gnt=8.
  Bus  0, device   7, function  0:
    ISA bridge: Intel 82371AB PIIX4 ISA (rev 1).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  No
bursts.  
  Bus  0, device   7, function  1:
    IDE interface: Intel 82371AB PIIX4 IDE (rev 1).
      Medium devsel.  Fast back-to-back capable.  Master Capable.
Latency=64.  
      I/O at 0xfcb0 [0xfcb1].
  Bus  0, device   7, function  2:
    USB Controller: Intel 82371AB PIIX4 USB (rev 1).
      Medium devsel.  Fast back-to-back capable.  IRQ 9.  Master
Capable.  Laten
cy=64.  
      I/O at 0xfce0 [0xfce1].
  Bus  0, device   7, function  3:
    Bridge: Intel 82371AB PIIX4 ACPI (rev 1).
      Medium devsel.  Fast back-to-back capable.  
  Bus  0, device  13, function  0:
    Ethernet controller: Compex ReadyLink 2000 (rev 10).
      Medium devsel.  Fast back-to-back capable.  IRQ 10.  
      I/O at 0xfcc0 [0xfcc1].
  Bus  0, device  14, function  0:
    SCSI storage controller: Adaptec AIC-7871 (rev 3).
      Medium devsel.  Fast back-to-back capable.  IRQ 11.  Master
Capable.  Late
ncy=64.  Min Gnt=8.Max Lat=8.
      I/O at 0xf800 [0xf801].
      Non-prefetchable 32 bit memory at 0xfedff000 [0xfedff000].
  Bus  1, device   0, function  0:
    VGA compatible controller: Matrox Millennium II AGP (rev 0).
      Medium devsel.  Fast back-to-back capable.  IRQ 11.  Master
Capable.  Late
ncy=64.  
      Prefetchable 32 bit memory at 0xf6000000 [0xf6000008].
      Non-prefetchable 32 bit memory at 0xfecf8000 [0xfecf8000].
      Non-prefetchable 32 bit memory at 0xfe000000 [0xfe000000].


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
