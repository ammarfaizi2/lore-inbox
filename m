Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129165AbRBWAPG>; Thu, 22 Feb 2001 19:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129290AbRBWAO4>; Thu, 22 Feb 2001 19:14:56 -0500
Received: from e23.nc.us.ibm.com ([32.97.136.229]:38531 "EHLO
	e23.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S129165AbRBWAOo>; Thu, 22 Feb 2001 19:14:44 -0500
Message-ID: <3A95AB71.FCECB41F@us.ibm.com>
Date: Thu, 22 Feb 2001 18:14:41 -0600
From: Peter Bergner <bergner@us.ibm.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; AIX 4.3)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
        linuxppc-announce@lists.linuxppc.org
Subject: [ANNOUNCE] Boot log for Linux PPC64 on POWER3 hardware
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is a boot log for a 64 bit port of Linux for IBM's 64 bit
PowerPC processors.  This log was made on a pSeries model 270 which uses
a POWER3 microprocessor.

-- The Linux for PowerPC-64 team from IBM.
   Dave Engebretsen
   Peter Bergner
   Todd Inglett
   Pat Mccarthy
   Don Reed
   Tom Gall
   Paul Albrecht
   Mike Corrigan
   Adam Litke
   Tillman Biterberg



instantiating rtas
 at 000000000022f000... done
starting cpu /cpus/PowerPC,POWER3@1...ok
starting cpu /cpus/PowerPC,POWER3@2...ok
starting cpu /cpus/PowerPC,POWER3@3...ok
copying OF device tree...done
 (translate ok) rtas testing start
00000000a0000000
0000000000003000
returning from prom_init
phys_mem: 
 [0, 80000000)
phys_avail: 
 [6000000, 80000000)
IO rempped IsaIoBase=f8000000 as e000000000002000 
Linux version 2.4.0-tg11 (bergner@skunk) (gcc version 2.95.2 19991024 (release))
#188 Thu Feb 22 19:55:45 CST 2001
Boot arguments: root=/dev/sdb3 console=ttyS0
RTAS Event Scan Rate: 1 (2999 jiffies)
OpenPIC addrs: ffc00000 feff7c00 feef7c00
IO remapped OpenPIC = 0xffff0000ffc00000 as 0xe000000001002000 
Setting up ISU(0) at 0xffff0000feff7c00 remapped to 0xe000000001042c00
Setting up ISU(1) at 0xffff0000feef7c00 remapped to 0xe000000001043c00
IO remapped Python0 = 0xffff0000fef00000 as 0xe000000001044000
This OpenPIC can handle 32 interrupt sources
On node 0 totalpages: 524288
zone(0): 524288 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/sdb3 console=ttyS0
OpenPIC Version 1.2 (8 CPUs and 32 IRQ sources) at e000000001002000
OpenPIC timer frequency is 0 MHz
time_init: decrementer frequency = 2812402770/30 (89 MHz)
Calibrating delay loop... 748.75 BogoMIPS
Memory: 1929072k available (1376k kernel code, 96928k data, 0k init)
[00000000,c000000080000000]
Dentry-cache hash table entries: 131072 (order: 9, 2097152 bytes)
Page-cache hash table entries: 262144 (order: 9, 2097152 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Starting kswapd v1.8
PCI: Enabling device 00:0e.0 (0000 -> 0002)
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
sym53c8xx: at PCI bus 0, device 12, function 0
sym53c8xx: setting PCI_COMMAND_IO PCI_COMMAND_MEMORY...
sym53c8xx: setting PCI_COMMAND_MASTER...(fix-up)
sym53c8xx: 53c875 detected 
sym53c8xx: at PCI bus 0, device 17, function 0
sym53c8xx: setting PCI_COMMAND_IO PCI_COMMAND_MEMORY...
sym53c8xx: setting PCI_COMMAND_MASTER...(fix-up)
sym53c8xx: 53c895 detected 
sym53c875-0: rev 0x4 on pci bus 0 device 12 function 0 irq 17
sym53c875-0: ID 7, Fast-20, Parity Checking
sym53c875-0: initial SCNTL3/DMODE/DCNTL/CTEST3/4/5 = (hex) 05/02/00/00/00/24
sym53c875-0: final   SCNTL3/DMODE/DCNTL/CTEST3/4/5 = (hex) 05/46/80/00/08/24
sym53c875-0: on-chip RAM at 0xc1919000
sym53c875-0: restart (scsi reset).
sym53c875-0: Downloading SCSI SCRIPTS.
sym53c895-1: rev 0x2 on pci bus 0 device 17 function 0 irq 20
sym53c895-1: Delay (GEN=11): 249 msec, 35696 KHz
sym53c895-1: Delay (GEN=11): 220 msec, 40401 KHz
sym53c895-1: Delay (GEN=11): 219 msec, 40585 KHz
sym53c895-1: NCR clock is 40401KHz
sym53c895-1: ID 7, Fast-40, Parity Checking
sym53c895-1: initial SCNTL3/DMODE/DCNTL/CTEST3/4/5 = (hex) 00/00/00/00/00/00
sym53c895-1: final   SCNTL3/DMODE/DCNTL/CTEST3/4/5 = (hex) 07/4e/80/00/08/24
sym53c895-1: on-chip RAM at 0xc1918000
sym53c895-1: Delay (GEN=11): 282 msec, 31518 KHz
sym53c895-1: Delay (GEN=11): 275 msec, 32321 KHz
sym53c895-1: Delay (GEN=11): 276 msec, 32204 KHz
sym53c895-1: restart (scsi reset).
sym53c895-1: Downloading SCSI SCRIPTS.
  Vendor: IBM       Model: CDRM00203     !K  Rev: 1_02
  Type:   CD-ROM                             ANSI SCSI revision: 02
sym53c875-0-<8,0>: wide msgin: 1-2-3-1.
sym53c875-0-<8,0>: wide: wide=1 chg=0.
sym53c875-0-<8,0>: wide msgout: 1-2-3-1.
sym53c875-0-<8,0>: sync msg in: 1-3-1-c-3f.
sym53c875-0-<8,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=16 fak=0 chg=1.
sym53c875-0-<8,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
sym53c875-0-<8,0>: sync msgout: 1-3-1-c-10.
  Vendor: IBM       Model: DDYS-T18350M      Rev: S96F
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym53c875-0-<9,0>: wide msgin: 1-2-3-1.
sym53c875-0-<9,0>: wide: wide=1 chg=0.
sym53c875-0-<9,0>: wide msgout: 1-2-3-1.
sym53c875-0-<9,0>: sync msg in: 1-3-1-c-3f.
sym53c875-0-<9,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=16 fak=0 chg=1.
sym53c875-0-<9,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
sym53c875-0-<9,0>: sync msgout: 1-3-1-c-10.
  Vendor: IBM       Model: DDYS-T18350M      Rev: S96F
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym53c875-0-<8,0>: tagged command queue depth set to 8
sym53c875-0-<9,0>: tagged command queue depth set to 8
sym53c875-0-<8,0>: wide msgout: 1-2-3-1.
sym53c875-0-<8,0>: wide msgin: 1-2-3-1.
sym53c875-0-<8,0>: wide: wide=1 chg=0.
sym53c875-0-<8,0>: sync msgout: 1-3-1-c-10.
sym53c875-0-<8,0>: sync msg in: 1-3-1-c-10.
sym53c875-0-<8,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=16 fak=0 chg=0.
sym53c875-0-<8,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
sym53c875-0-<9,0>: wide msgout: 1-2-3-1.
sym53c875-0-<9,0>: wide msgin: 1-2-3-1.
sym53c875-0-<9,0>: wide: wide=1 chg=0.
sym53c875-0-<9,0>: sync msgout: 1-3-1-c-10.sym53c875-0-<9,0>: sync msg in:
1-3-1-c-10.
sym53c875-0-<9,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=16 fak=0 chg=0.
sym53c875-0-<9,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
Freeing unused kernel memory: 0k init
try execve /sbin/init
INIT: version 2.78 booting
Running /sbin/init.d/boot
Mounting /proc device                                                  done
Starting kerneld:kerneld: you almost certainly don't want to be running kerneld
with >= 2.2.x
Adding Swap: 132088k swap-space (priority -1)
         kernels; read /usr/src/linux/Documentation/kmod.txt.
Starting kerneld, version 2.3.11 (pid 18)                              done
Activating swap-devices in /etc/fstab...                               done
Checking file systems...
Parallelizing fsck version 1.18a (11-Nov-1999)
/dev/sdb3: clean, 139290/832320 files, 554540/1664256 blocks
Checking file systems                                                  done
Setting up /lib/modules/2.4.0-tg11                                     failed
Mounting local file systems...
proc on /proc type proc (rw)
not mounted anything
Mounting local file systems                                            done
Setting up timezone data                                               done
Setting up loopback deviceNo usable address families found.
socket: No such file or directory                                      done
Setting up hostname                                                    done
Configuring serial ports...
ttyS0 at 0x03f8 (irq = 4) is a 16550A
ttyS1 at 0x02f8 (irq = 3) is a 16550A
Configuring serial ports                                               done
Running /sbin/init.d/boot.local                                        done
Creating /var/log/boot.msg                                             done
INIT: Entering runlevel: 2
Master Resource Control: previous runlevel: N, switching to runlevel:  2
Re-kerneld: you almost certainly don't want to be running kerneld with >= 2.2.x
         kernels; read /usr/src/linux/Documentation/kmod.txt.
Starting kerneld, version 2.3.11 (pid 110)                             done
Initializing random number generator                                   done
modprobe: Can't open dependencies file /lib/modules/2.4.0-tg11/modules.dep (No
such file or directory)
Master Resource Control: runlevel 2 has been                           reached


Welcome to SuSE Linux 7.0 (PPC) - Kernel 2.4.0-tg11 (ttyS0).

swamsauger login: root
Password: 
You have old mail in /var/spool/mail/root.
Last login: Thu Feb 22 19:51:25 on tty1
Have a lot of fun...
swamsauger:~ # uname -a
Linux swamsauger 2.4.0-tg11 #188 Thu Feb 22 19:55:45 CST 2001 ppc64 unknown
swamsauger:~ # 
swamsauger:~ # cat /proc/cpuinfo 
processor       : 0
cpu             : POWER3 (630+)
clock           : 375MHz
revision        : 1.4
bogomips        : 748.75
zero pages      : total: 0 (0Kb) current: 0 (0Kb) hits: 0/0 (0%)
machine         : CHRP IBM,7044-270
swamsauger:~ #
