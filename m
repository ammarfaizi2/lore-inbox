Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWHVWkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWHVWkL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 18:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWHVWkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 18:40:10 -0400
Received: from lug.demon.co.uk ([83.104.159.110]:33898 "EHLO lug.demon.co.uk")
	by vger.kernel.org with ESMTP id S932145AbWHVWkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 18:40:05 -0400
From: David Johnson <dj@david-web.co.uk>
Reply-To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
To: David Miller <davem@davemloft.net>
Subject: Re: sym53c8xx PCI card broken in 2.6.18
Date: Tue, 22 Aug 2006 23:39:43 +0100
User-Agent: KMail/1.9.4
References: <200608221546.11532.dj@david-web.co.uk> <20060822.133901.110902970.davem@davemloft.net>
In-Reply-To: <20060822.133901.110902970.davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ve46EwlMizQz5P4"
Message-Id: <200608222339.43511.dj@david-web.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_ve46EwlMizQz5P4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 22 August 2006 21:39, you wrote:
> Sounds like the interrupts are being misconfigured for the
> PCI card.  Please post 2 pieces of information:
>
> 1) Boot logs with "ofdebug=2" given on the kernel command line
> 2) Output of "/usr/sbin/prtconf -pv"
>

Both attached.

Now that I've let the system finish booting, there are also a few oopses that 
seem related to the new openprom interface.

Regards,
David.

-- 
David Johnson
www.david-web.co.uk - My Personal Website
www.penguincomputing.co.uk - Need a Web Developer?

--Boundary-00=_ve46EwlMizQz5P4
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg"

PROMLIB: Sun IEEE Boot Prom 'OBP 3.7.107 1998/02/19 17:54'
PROMLIB: Root node compatible: sun4u
Linux version 2.6.18-rc4 (root@lug) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #2 SMP Tue Aug 22 14:30:37 BST 2006
ARCH: SUN4U
Ethernet address: 08:00:20:90:ca:21
PROM: Built device tree with 92893 bytes of memory.
On node 0 totalpages: 130147
  DMA zone: 130147 pages, LIFO batch:15
Built 1 zonelists.  Total pages: 130147
Kernel command line: root=/dev/sdb1 ro ofdebug=2
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
Memory: 1031496k available (2120k kernel code, 768k data, 160k init) [fffff80000000000,000000003fe86000]
Calibrating delay using timer specific routine.. 592.47 BogoMIPS (lpj=1184952)
Mount-cache hash table entries: 512
CPU[0]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)] E[sz(2097152):line_sz(64)]
Using max_cache_size of 2MB
Calibrating delay using timer specific routine.. 592.03 BogoMIPS (lpj=1184076)
CPU[1]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)] E[sz(2097152):line_sz(64)]
CPU 1: synchronized TICK with master CPU (last diff 0 cycles,maxerr 442 cycles)
Calibrating delay using timer specific routine.. 592.04 BogoMIPS (lpj=1184080)
CPU[2]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)] E[sz(2097152):line_sz(64)]
CPU 2: synchronized TICK with master CPU (last diff 0 cycles,maxerr 446 cycles)
Calibrating delay using timer specific routine.. 592.03 BogoMIPS (lpj=1184077)
CPU[3]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)] E[sz(2097152):line_sz(64)]
CPU 3: synchronized TICK with master CPU (last diff -1 cycles,maxerr 448 cycles)
Brought up 4 CPUs
Total of 4 processors activated (2368.59 BogoMIPS).
migration_cost=27075
checking if image is initramfs...it isn't (bad gzip magic numbers); looks like an initrd
Freeing initrd memory: 2400k freed
NET: Registered protocol family 16
PCI: Probing for controllers.
/pci@1f,4000: PSYCHO PCI Bus Module ver[4:0]
/pci@1f,2000: PSYCHO PCI Bus Module ver[4:0]
/pci@4,4000: PSYCHO PCI Bus Module ver[4:0]
/pci@4,2000: PSYCHO PCI Bus Module ver[4:0]
/pci@6,4000: PSYCHO PCI Bus Module ver[4:0]
/pci@6,2000: PSYCHO PCI Bus Module ver[4:0]
PCI2(PBMB): Bus running at 33MHz
PCI2(PBMA): Bus running at 66MHz
PCI1(PBMB): Bus running at 33MHz
PCI1(PBMA): Bus running at 66MHz
PCI0(PBMB): Bus running at 33MHz
PCI0(PBMA): Bus running at 66MHz
ebus0: [auxio] [power] [SUNW,pll] [sc] [se] [su] [su] [ecpp] [fdthree] [eeprom] [flashprom] [SUNW,envctrl]
power: Control reg at 1fff1724000 ... not using powerd.
AUXIO: Found device at /pci@1f,4000/ebus@1/auxio@14,726000
/pci@1f,4000/ebus@1/eeprom@14,0: Clock regs at 000001fff1000000
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 65536 bytes)
TCP established hash table entries: 32768 (order: 6, 524288 bytes)
TCP bind hash table entries: 16384 (order: 5, 262144 bytes)
TCP: Hash tables configured (established 32768 bind 16384)
TCP reno registered
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Console: switching to colour frame buffer device 160x64
/SUNW,ffb@1d,0: FFB at 000001fa00000000, type 8, DAC revision 10
rtc_init: no PC rtc found
/pci@1f,4000/ebus@1/su@14,3083f8: Keyboard port at 1fff13083f8, irq 8
/pci@1f,4000/ebus@1/su@14,3062f8: Mouse port at 1fff13062f8, irq 9
se@14,400000: ttyS0 at MMIO 0x1fff1400000 (irq = 7) is a SAB82532 V3.2
se@14,400000: ttyS1 at MMIO 0x1fff1400040 (irq = 7) is a SAB82532 V3.2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
rtc_sun_init: Registered Mostek RTC driver.
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 2400KiB [1 disk] into ram disk... |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/done.
VFS: Mounted root (cramfs filesystem) readonly.
SCSI subsystem initialized
sym0: <875> rev 0x3 at pci 0001:00:02.0 irq 14
sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.2.3
input: Sun Type 5 keyboard as /class/input/input0
input: Sun Mouse as /class/input/input1
  Vendor: TOSHIBA   Model: XM5701TASUN12XCD  Rev: 0997
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target0:0:6: Beginning Domain Validation
 target0:0:6: asynchronous
 target0:0:6: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 8)
 target0:0:6: Domain Validation skipping write tests
 target0:0:6: Ending Domain Validation
sym1: <875> rev 0x3 at pci 0001:00:03.0 irq 13
sym1: No NVRAM, ID 7, Fast-20, SE, parity checking
sym1: SCSI BUS has been reset.
scsi1 : sym-2.2.3
  Vendor: SEAGATE   Model: ST39102LCSUN9.0G  Rev: 0828
  Type:   Direct-Access                      ANSI SCSI revision: 02
 target1:0:0: tagged command queuing enabled, command queue depth 16.
 target1:0:0: Beginning Domain Validation
 target1:0:0: asynchronous
 target1:0:0: wide asynchronous
 target1:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 15)
 target1:0:0: Domain Validation skipping write tests
 target1:0:0: Ending Domain Validation
  Vendor: SEAGATE   Model: ST39102LCSUN9.0G  Rev: 0828
  Type:   Direct-Access                      ANSI SCSI revision: 02
 target1:0:1: tagged command queuing enabled, command queue depth 16.
 target1:0:1: Beginning Domain Validation
 target1:0:1: asynchronous
 target1:0:1: wide asynchronous
 target1:0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 15)
 target1:0:1: Domain Validation skipping write tests
 target1:0:1: Ending Domain Validation
  Vendor: SEAGATE   Model: ST39102LCSUN9.0G  Rev: 0828
  Type:   Direct-Access                      ANSI SCSI revision: 02
 target1:0:2: tagged command queuing enabled, command queue depth 16.
 target1:0:2: Beginning Domain Validation
 target1:0:2: asynchronous
 target1:0:2: wide asynchronous
 target1:0:2: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 15)
 target1:0:2: Domain Validation skipping write tests
 target1:0:2: Ending Domain Validation
  Vendor: IBM-PSG   Model: DNES-318350Y  !#  Rev: SAB0
  Type:   Direct-Access                      ANSI SCSI revision: 03
 target1:0:3: tagged command queuing enabled, command queue depth 16.
 target1:0:3: Beginning Domain Validation
 target1:0:3: asynchronous
 target1:0:3: wide asynchronous
 target1:0:3: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 16)
 target1:0:3: Domain Validation skipping write tests
 target1:0:3: Ending Domain Validation
scsi 1:0:3:0: phase change 2-3 12@c0038f60 resid=11.
sym2: <875> rev 0x14 at pci 0001:00:04.0 irq 15
sym2: No NVRAM, ID 7, Fast-20, SE, parity checking
sym2: SCSI BUS has been reset.
scsi2 : sym-2.2.3
scsi 2:0:0:0: ABORT operation started.
scsi 2:0:0:0: ABORT operation timed-out.
scsi 2:0:0:0: DEVICE RESET operation started.
scsi 2:0:0:0: DEVICE RESET operation timed-out.
scsi 2:0:0:0: BUS RESET operation started.
scsi 2:0:0:0: BUS RESET operation timed-out.
scsi 2:0:0:0: HOST RESET operation started.
sym2: SCSI BUS has been reset.
scsi 2:0:0:0: HOST RESET operation timed-out.
scsi 2:0:0:0: scsi: Device offlined - not ready after error recovery
scsi 2:0:1:0: ABORT operation started.
scsi 2:0:1:0: ABORT operation timed-out.
scsi 2:0:1:0: DEVICE RESET operation started.
scsi 2:0:1:0: DEVICE RESET operation timed-out.
scsi 2:0:1:0: BUS RESET operation started.
scsi 2:0:1:0: BUS RESET operation timed-out.
scsi 2:0:1:0: HOST RESET operation started.
sym2: SCSI BUS has been reset.
scsi 2:0:1:0: HOST RESET operation timed-out.
scsi 2:0:1:0: scsi: Device offlined - not ready after error recovery
scsi 2:0:2:0: ABORT operation started.
scsi 2:0:2:0: ABORT operation timed-out.
scsi 2:0:2:0: DEVICE RESET operation started.
scsi 2:0:2:0: DEVICE RESET operation timed-out.
scsi 2:0:2:0: BUS RESET operation started.
scsi 2:0:2:0: BUS RESET operation timed-out.
scsi 2:0:2:0: HOST RESET operation started.
sym2: SCSI BUS has been reset.
scsi 2:0:2:0: HOST RESET operation timed-out.
scsi 2:0:2:0: scsi: Device offlined - not ready after error recovery
scsi 2:0:3:0: ABORT operation started.
scsi 2:0:3:0: ABORT operation timed-out.
scsi 2:0:3:0: DEVICE RESET operation started.
scsi 2:0:3:0: DEVICE RESET operation timed-out.
scsi 2:0:3:0: BUS RESET operation started.
scsi 2:0:3:0: BUS RESET operation timed-out.
scsi 2:0:3:0: HOST RESET operation started.
sym2: SCSI BUS has been reset.
scsi 2:0:3:0: HOST RESET operation timed-out.
scsi 2:0:3:0: scsi: Device offlined - not ready after error recovery
scsi 2:0:4:0: ABORT operation started.
scsi 2:0:4:0: ABORT operation timed-out.
scsi 2:0:4:0: DEVICE RESET operation started.
scsi 2:0:4:0: DEVICE RESET operation timed-out.
scsi 2:0:4:0: BUS RESET operation started.
scsi 2:0:4:0: BUS RESET operation timed-out.
scsi 2:0:4:0: HOST RESET operation started.
sym2: SCSI BUS has been reset.
scsi 2:0:4:0: HOST RESET operation timed-out.
scsi 2:0:4:0: scsi: Device offlined - not ready after error recovery
scsi 2:0:5:0: ABORT operation started.
scsi 2:0:5:0: ABORT operation timed-out.
scsi 2:0:5:0: DEVICE RESET operation started.
scsi 2:0:5:0: DEVICE RESET operation timed-out.
scsi 2:0:5:0: BUS RESET operation started.
scsi 2:0:5:0: BUS RESET operation timed-out.
scsi 2:0:5:0: HOST RESET operation started.
sym2: SCSI BUS has been reset.
scsi 2:0:5:0: HOST RESET operation timed-out.
scsi 2:0:5:0: scsi: Device offlined - not ready after error recovery
scsi 2:0:6:0: ABORT operation started.
scsi 2:0:6:0: ABORT operation timed-out.
scsi 2:0:6:0: DEVICE RESET operation started.
scsi 2:0:6:0: DEVICE RESET operation timed-out.
scsi 2:0:6:0: BUS RESET operation started.
scsi 2:0:6:0: BUS RESET operation timed-out.
scsi 2:0:6:0: HOST RESET operation started.
sym2: SCSI BUS has been reset.
scsi 2:0:6:0: HOST RESET operation timed-out.
scsi 2:0:6:0: scsi: Device offlined - not ready after error recovery
scsi 2:0:8:0: ABORT operation started.
scsi 2:0:8:0: ABORT operation timed-out.
scsi 2:0:8:0: DEVICE RESET operation started.
scsi 2:0:8:0: DEVICE RESET operation timed-out.
scsi 2:0:8:0: BUS RESET operation started.
scsi 2:0:8:0: BUS RESET operation timed-out.
scsi 2:0:8:0: HOST RESET operation started.
sym2: SCSI BUS has been reset.
scsi 2:0:8:0: HOST RESET operation timed-out.
scsi 2:0:8:0: scsi: Device offlined - not ready after error recovery
scsi 2:0:9:0: ABORT operation started.
scsi 2:0:9:0: ABORT operation timed-out.
scsi 2:0:9:0: DEVICE RESET operation started.
scsi 2:0:9:0: DEVICE RESET operation timed-out.
scsi 2:0:9:0: BUS RESET operation started.
scsi 2:0:9:0: BUS RESET operation timed-out.
scsi 2:0:9:0: HOST RESET operation started.
sym2: SCSI BUS has been reset.
scsi 2:0:9:0: HOST RESET operation timed-out.
scsi 2:0:9:0: scsi: Device offlined - not ready after error recovery
scsi 2:0:10:0: ABORT operation started.
scsi 2:0:10:0: ABORT operation timed-out.
scsi 2:0:10:0: DEVICE RESET operation started.
scsi 2:0:10:0: DEVICE RESET operation timed-out.
scsi 2:0:10:0: BUS RESET operation started.
scsi 2:0:10:0: BUS RESET operation timed-out.
scsi 2:0:10:0: HOST RESET operation started.
sym2: SCSI BUS has been reset.
scsi 2:0:10:0: HOST RESET operation timed-out.
scsi 2:0:10:0: scsi: Device offlined - not ready after error recovery
scsi 2:0:11:0: ABORT operation started.
scsi 2:0:11:0: ABORT operation timed-out.
scsi 2:0:11:0: DEVICE RESET operation started.
scsi 2:0:11:0: DEVICE RESET operation timed-out.
scsi 2:0:11:0: BUS RESET operation started.
scsi 2:0:11:0: BUS RESET operation timed-out.
scsi 2:0:11:0: HOST RESET operation started.
sym2: SCSI BUS has been reset.
scsi 2:0:11:0: HOST RESET operation timed-out.
scsi 2:0:11:0: scsi: Device offlined - not ready after error recovery
scsi 2:0:12:0: ABORT operation started.
scsi 2:0:12:0: ABORT operation timed-out.
scsi 2:0:12:0: DEVICE RESET operation started.
scsi 2:0:12:0: DEVICE RESET operation timed-out.
scsi 2:0:12:0: BUS RESET operation started.
scsi 2:0:12:0: BUS RESET operation timed-out.
scsi 2:0:12:0: HOST RESET operation started.
sym2: SCSI BUS has been reset.
scsi 2:0:12:0: HOST RESET operation timed-out.
scsi 2:0:12:0: scsi: Device offlined - not ready after error recovery
scsi 2:0:13:0: ABORT operation started.
scsi 2:0:13:0: ABORT operation timed-out.
scsi 2:0:13:0: DEVICE RESET operation started.
scsi 2:0:13:0: DEVICE RESET operation timed-out.
scsi 2:0:13:0: BUS RESET operation started.
scsi 2:0:13:0: BUS RESET operation timed-out.
scsi 2:0:13:0: HOST RESET operation started.
sym2: SCSI BUS has been reset.
scsi 2:0:13:0: HOST RESET operation timed-out.
scsi 2:0:13:0: scsi: Device offlined - not ready after error recovery
scsi 2:0:14:0: ABORT operation started.
scsi 2:0:14:0: ABORT operation timed-out.
scsi 2:0:14:0: DEVICE RESET operation started.
scsi 2:0:14:0: DEVICE RESET operation timed-out.
scsi 2:0:14:0: BUS RESET operation started.
scsi 2:0:14:0: BUS RESET operation timed-out.
scsi 2:0:14:0: HOST RESET operation started.
sym2: SCSI BUS has been reset.
scsi 2:0:14:0: HOST RESET operation timed-out.
scsi 2:0:14:0: scsi: Device offlined - not ready after error recovery
scsi 2:0:15:0: ABORT operation started.
scsi 2:0:15:0: ABORT operation timed-out.
scsi 2:0:15:0: DEVICE RESET operation started.
scsi 2:0:15:0: DEVICE RESET operation timed-out.
scsi 2:0:15:0: BUS RESET operation started.
scsi 2:0:15:0: BUS RESET operation timed-out.
scsi 2:0:15:0: HOST RESET operation started.
sym2: SCSI BUS has been reset.
scsi 2:0:15:0: HOST RESET operation timed-out.
scsi 2:0:15:0: scsi: Device offlined - not ready after error recovery
sym3: <875> rev 0x14 at pci 0001:00:04.1 irq 16
sym3: No NVRAM, ID 7, Fast-20, SE, parity checking
sym3: SCSI BUS has been reset.
scsi3 : sym-2.2.3
scsi 3:0:0:0: ABORT operation started.
scsi 3:0:0:0: ABORT operation timed-out.
scsi 3:0:0:0: DEVICE RESET operation started.
scsi 3:0:0:0: DEVICE RESET operation timed-out.
scsi 3:0:0:0: BUS RESET operation started.
scsi 3:0:0:0: BUS RESET operation timed-out.
scsi 3:0:0:0: HOST RESET operation started.
sym3: SCSI BUS has been reset.
scsi 3:0:0:0: HOST RESET operation timed-out.
scsi 3:0:0:0: scsi: Device offlined - not ready after error recovery
scsi 3:0:1:0: ABORT operation started.
scsi 3:0:1:0: ABORT operation timed-out.
scsi 3:0:1:0: DEVICE RESET operation started.
scsi 3:0:1:0: DEVICE RESET operation timed-out.
scsi 3:0:1:0: BUS RESET operation started.
scsi 3:0:1:0: BUS RESET operation timed-out.
scsi 3:0:1:0: HOST RESET operation started.
sym3: SCSI BUS has been reset.
scsi 3:0:1:0: HOST RESET operation timed-out.
scsi 3:0:1:0: scsi: Device offlined - not ready after error recovery
scsi 3:0:2:0: ABORT operation started.
scsi 3:0:2:0: ABORT operation timed-out.
scsi 3:0:2:0: DEVICE RESET operation started.
scsi 3:0:2:0: DEVICE RESET operation timed-out.
scsi 3:0:2:0: BUS RESET operation started.
scsi 3:0:2:0: BUS RESET operation timed-out.
scsi 3:0:2:0: HOST RESET operation started.
sym3: SCSI BUS has been reset.
scsi 3:0:2:0: HOST RESET operation timed-out.
scsi 3:0:2:0: scsi: Device offlined - not ready after error recovery
scsi 3:0:3:0: ABORT operation started.
scsi 3:0:3:0: ABORT operation timed-out.
scsi 3:0:3:0: DEVICE RESET operation started.
scsi 3:0:3:0: DEVICE RESET operation timed-out.
scsi 3:0:3:0: BUS RESET operation started.
scsi 3:0:3:0: BUS RESET operation timed-out.
scsi 3:0:3:0: HOST RESET operation started.
sym3: SCSI BUS has been reset.
scsi 3:0:3:0: HOST RESET operation timed-out.
scsi 3:0:3:0: scsi: Device offlined - not ready after error recovery
scsi 3:0:4:0: ABORT operation started.
scsi 3:0:4:0: ABORT operation timed-out.
scsi 3:0:4:0: DEVICE RESET operation started.
scsi 3:0:4:0: DEVICE RESET operation timed-out.
scsi 3:0:4:0: BUS RESET operation started.
scsi 3:0:4:0: BUS RESET operation timed-out.
scsi 3:0:4:0: HOST RESET operation started.
sym3: SCSI BUS has been reset.
scsi 3:0:4:0: HOST RESET operation timed-out.
scsi 3:0:4:0: scsi: Device offlined - not ready after error recovery
scsi 3:0:5:0: ABORT operation started.
scsi 3:0:5:0: ABORT operation timed-out.
scsi 3:0:5:0: DEVICE RESET operation started.
scsi 3:0:5:0: DEVICE RESET operation timed-out.
scsi 3:0:5:0: BUS RESET operation started.
scsi 3:0:5:0: BUS RESET operation timed-out.
scsi 3:0:5:0: HOST RESET operation started.
sym3: SCSI BUS has been reset.
scsi 3:0:5:0: HOST RESET operation timed-out.
scsi 3:0:5:0: scsi: Device offlined - not ready after error recovery
scsi 3:0:6:0: ABORT operation started.
scsi 3:0:6:0: ABORT operation timed-out.
scsi 3:0:6:0: DEVICE RESET operation started.
scsi 3:0:6:0: DEVICE RESET operation timed-out.
scsi 3:0:6:0: BUS RESET operation started.
scsi 3:0:6:0: BUS RESET operation timed-out.
scsi 3:0:6:0: HOST RESET operation started.
sym3: SCSI BUS has been reset.
scsi 3:0:6:0: HOST RESET operation timed-out.
scsi 3:0:6:0: scsi: Device offlined - not ready after error recovery
scsi 3:0:8:0: ABORT operation started.
scsi 3:0:8:0: ABORT operation timed-out.
scsi 3:0:8:0: DEVICE RESET operation started.
scsi 3:0:8:0: DEVICE RESET operation timed-out.
scsi 3:0:8:0: BUS RESET operation started.
scsi 3:0:8:0: BUS RESET operation timed-out.
scsi 3:0:8:0: HOST RESET operation started.
sym3: SCSI BUS has been reset.
scsi 3:0:8:0: HOST RESET operation timed-out.
scsi 3:0:8:0: scsi: Device offlined - not ready after error recovery
scsi 3:0:9:0: ABORT operation started.
scsi 3:0:9:0: ABORT operation timed-out.
scsi 3:0:9:0: DEVICE RESET operation started.
scsi 3:0:9:0: DEVICE RESET operation timed-out.
scsi 3:0:9:0: BUS RESET operation started.
scsi 3:0:9:0: BUS RESET operation timed-out.
scsi 3:0:9:0: HOST RESET operation started.
sym3: SCSI BUS has been reset.
scsi 3:0:9:0: HOST RESET operation timed-out.
scsi 3:0:9:0: scsi: Device offlined - not ready after error recovery
scsi 3:0:10:0: ABORT operation started.
scsi 3:0:10:0: ABORT operation timed-out.
scsi 3:0:10:0: DEVICE RESET operation started.
scsi 3:0:10:0: DEVICE RESET operation timed-out.
scsi 3:0:10:0: BUS RESET operation started.
scsi 3:0:10:0: BUS RESET operation timed-out.
scsi 3:0:10:0: HOST RESET operation started.
sym3: SCSI BUS has been reset.
scsi 3:0:10:0: HOST RESET operation timed-out.
scsi 3:0:10:0: scsi: Device offlined - not ready after error recovery
scsi 3:0:11:0: ABORT operation started.
scsi 3:0:11:0: ABORT operation timed-out.
scsi 3:0:11:0: DEVICE RESET operation started.
scsi 3:0:11:0: DEVICE RESET operation timed-out.
scsi 3:0:11:0: BUS RESET operation started.
scsi 3:0:11:0: BUS RESET operation timed-out.
scsi 3:0:11:0: HOST RESET operation started.
sym3: SCSI BUS has been reset.
scsi 3:0:11:0: HOST RESET operation timed-out.
scsi 3:0:11:0: scsi: Device offlined - not ready after error recovery
scsi 3:0:12:0: ABORT operation started.
scsi 3:0:12:0: ABORT operation timed-out.
scsi 3:0:12:0: DEVICE RESET operation started.
scsi 3:0:12:0: DEVICE RESET operation timed-out.
scsi 3:0:12:0: BUS RESET operation started.
scsi 3:0:12:0: BUS RESET operation timed-out.
scsi 3:0:12:0: HOST RESET operation started.
sym3: SCSI BUS has been reset.
scsi 3:0:12:0: HOST RESET operation timed-out.
scsi 3:0:12:0: scsi: Device offlined - not ready after error recovery
scsi 3:0:13:0: ABORT operation started.
scsi 3:0:13:0: ABORT operation timed-out.
scsi 3:0:13:0: DEVICE RESET operation started.
scsi 3:0:13:0: DEVICE RESET operation timed-out.
scsi 3:0:13:0: BUS RESET operation started.
scsi 3:0:13:0: BUS RESET operation timed-out.
scsi 3:0:13:0: HOST RESET operation started.
sym3: SCSI BUS has been reset.
scsi 3:0:13:0: HOST RESET operation timed-out.
scsi 3:0:13:0: scsi: Device offlined - not ready after error recovery
scsi 3:0:14:0: ABORT operation started.
scsi 3:0:14:0: ABORT operation timed-out.
scsi 3:0:14:0: DEVICE RESET operation started.
scsi 3:0:14:0: DEVICE RESET operation timed-out.
scsi 3:0:14:0: BUS RESET operation started.
scsi 3:0:14:0: BUS RESET operation timed-out.
scsi 3:0:14:0: HOST RESET operation started.
sym3: SCSI BUS has been reset.
scsi 3:0:14:0: HOST RESET operation timed-out.
scsi 3:0:14:0: scsi: Device offlined - not ready after error recovery
scsi 3:0:15:0: ABORT operation started.
scsi 3:0:15:0: ABORT operation timed-out.
scsi 3:0:15:0: DEVICE RESET operation started.
scsi 3:0:15:0: DEVICE RESET operation timed-out.
scsi 3:0:15:0: BUS RESET operation started.
scsi 3:0:15:0: BUS RESET operation timed-out.
scsi 3:0:15:0: HOST RESET operation started.
sym3: SCSI BUS has been reset.
scsi 3:0:15:0: HOST RESET operation timed-out.
scsi 3:0:15:0: scsi: Device offlined - not ready after error recovery
scsi 0:0:6:0: Attached scsi generic sg0 type 5
scsi 1:0:0:0: Attached scsi generic sg1 type 0
scsi 1:0:1:0: Attached scsi generic sg2 type 0
scsi 1:0:2:0: Attached scsi generic sg3 type 0
scsi 1:0:3:0: Attached scsi generic sg4 type 0
SCSI device sda: 17689267 512-byte hdwr sectors (9057 MB)
sda: Write Protect is off
sda: Mode Sense: cf 00 10 08
SCSI device sda: drive cache: write through w/ FUA
SCSI device sda: 17689267 512-byte hdwr sectors (9057 MB)
sda: Write Protect is off
sda: Mode Sense: cf 00 10 08
SCSI device sda: drive cache: write through w/ FUA
 sda: sda1 sda2 sda3
sd 1:0:0:0: Attached scsi disk sda
SCSI device sdb: 17689267 512-byte hdwr sectors (9057 MB)
sdb: Write Protect is off
sdb: Mode Sense: cf 00 10 08
SCSI device sdb: drive cache: write through w/ FUA
SCSI device sdb: 17689267 512-byte hdwr sectors (9057 MB)
sdb: Write Protect is off
sdb: Mode Sense: cf 00 10 08
SCSI device sdb: drive cache: write through w/ FUA
 sdb: sdb1 sdb3
sd 1:0:1:0: Attached scsi disk sdb
SCSI device sdc: 17689267 512-byte hdwr sectors (9057 MB)
sdc: Write Protect is off
sdc: Mode Sense: cf 00 10 08
SCSI device sdc: drive cache: write through w/ FUA
SCSI device sdc: 17689267 512-byte hdwr sectors (9057 MB)
sdc: Write Protect is off
sdc: Mode Sense: cf 00 10 08
SCSI device sdc: drive cache: write through w/ FUA
 sdc: sdc1 sdc3
sd 1:0:2:0: Attached scsi disk sdc
SCSI device sdd: 35548320 512-byte hdwr sectors (18201 MB)
sdd: Write Protect is off
sdd: Mode Sense: c3 00 00 08
SCSI device sdd: drive cache: write through
SCSI device sdd: 35548320 512-byte hdwr sectors (18201 MB)
sdd: Write Protect is off
sdd: Mode Sense: c3 00 00 08
SCSI device sdd: drive cache: write through
 sdd: sdd1
sd 1:0:3:0: Attached scsi disk sdd
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.20
sr 0:0:6:0: Attached scsi CD-ROM sr0
sunhme.c:v3.00 June 23, 2006 David S. Miller (davem@davemloft.net)
eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:90:ca:21 
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Adding 8648688k swap on /dev/sda2.  Priority:-1 extents:1 across:8648688k
EXT3 FS on sdb1, internal journal
i2c-algo-pcf.o: deteted and initialized PCF8584.
i2c-envctrl: SUNW,envctrl PCF8584 bus nexus at 0x1fff1600000
envctrl: unexpected cpu-temp-factors table size (is 1062468864, expected 254)
envctrl: using default cpu-temp-factors table
envctrl: unexpected ps-temp-factors table size (is 112, expected 254)
envctrl: using default ps-temp-factors table
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 00000000000003ff
tsk->{mm,active_mm}->pgd = fffff8003f43a000
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
modprobe(1647): Oops [#1]
TSTATE: 0000001111009602 TPC: 00000000100f2470 TNPC: 00000000100f2498 Y: 00000000    Not tainted
TPC: <env_init_thermisters+0x254/0x4a0 [envctrl]>
g0: 00000000100ee140 g1: 0000000000000070 g2: fffffffffffffffa g3: 000000006e000000
g4: fffff80000e27640 g5: fffff8000039fa00 g6: fffff8003f53c000 g7: 0000000000000000
o0: 0000000000000000 o1: 00000000100ea428 o2: fffff8003f53fd0c o3: 000008000f6753f0
o4: 00000000100ee530 o5: 3f3f3f3f3f3f3f3f sp: fffff8003f53f451 ret_pc: 00000000100f245c
RPC: <env_init_thermisters+0x240/0x4a0 [envctrl]>
l0: 00000000100ee400 l1: 00000000007299f8 l2: 0000000000000000 l3: 00000000100ee400
l4: 000000000066cc00 l5: 0000000000000001 l6: 0000000000000000 l7: 0000000000000008
i0: 0000000000000000 i1: 00000000100e3918 i2: 0000000000000001 i3: 0000000100225570
i4: 0000000000000000 i5: 0000000000000015 i6: fffff8003f53f521 i7: 00000000100f2a84
I7: <env_init+0x90/0x234 [envctrl]>
Caller[00000000100f2a84]: env_init+0x90/0x234 [envctrl]
Caller[000000000046eb88]: sys_init_module+0xac/0x19c
Caller[0000000000406bd4]: linux_sparc_syscall32+0x3c/0x40
Caller[0000000000012758]: 0x12760
Instruction DUMP: c207a7eb  80a07fff  3248000b <c25a2010> 110403a9  130403a9  901223f8  7c0d74eb  92126088 
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
md: md0 stopped.
md: bind<sdd1>
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdc1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: md0: warning: sh-2006: read_super_block: bread failed (dev md0, block 1, size 8192)
ReiserFS: md0: warning: sh-2006: read_super_block: bread failed (dev md0, block 8, size 8192)
ReiserFS: md0: warning: sh-2021: reiserfs_fill_super: can not find reiserfs on md0
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 00000000000005d7
tsk->{mm,active_mm}->pgd = fffff8003fd2a000
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
discover(1950): Oops [#2]
TSTATE: 0000004411009606 TPC: 000000000042769c TNPC: 00000000004276a0 Y: 00000000    Not tainted
TPC: <of_find_property+0xc/0x4c>
g0: fffff8003f89f231 g1: 0000000020004f07 g2: 0000000020004c00 g3: 0000000000000f7c
g4: fffff8003ef2ba00 g5: fffff8000039fa00 g6: fffff8003f89c000 g7: 0000000000000000
o0: fffff80000000b00 o1: 00000000000000d0 o2: 0000000001010101 o3: 0000000080808080
o4: 0000000070636900 o5: 0000000073627573 sp: fffff8003f89f1f1 ret_pc: 00000000f7f24db0
RPC: <0xf7f24db8>
l0: 000000000000058c l1: 00000000f7f294a0 l2: 00000000f7f3af78 l3: 0000000000000000
l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000000000 l7: 00000000f7f3a7ac
i0: 0000000000000000 i1: fffff8003eb67004 i2: fffff8003f89fc2c i3: fffff8003eb67000
i4: 0000000000000000 i5: 000000000000005a i6: fffff8003f89f2b1 i7: 00000000004276f4
I7: <of_get_property+0x18/0x28>
Caller[00000000004276f4]: of_get_property+0x18/0x28
Caller[000000000057d860]: opromgetprop+0x18/0x88
Caller[000000000057dc8c]: openprom_sunos_ioctl+0x12c/0x244
Caller[000000000057e5bc]: openprom_compat_ioctl+0x54/0x5c
Caller[00000000004c4d44]: compat_sys_ioctl+0xfc/0x280
Caller[0000000000406bd4]: linux_sparc_syscall32+0x3c/0x40
Caller[00000000f7f24d54]: 0xf7f24d5c
Instruction DUMP: 81cfe008  01000000  9de3bf40 <f05e2028> 02c6000f  01000000  d05e0000  4003f649  92100019 
eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO

--Boundary-00=_ve46EwlMizQz5P4
Content-Type: text/plain;
  charset="iso-8859-1";
  name="prtconf"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="prtconf"

System Configuration:  Sun Microsystems  sun4u
Memory size: 1024 Megabytes
System Peripherals (PROM Nodes):

Node 0xf0029918
    .node:  f0029918
    reset-reason: 'S-POR'
    idprom:  01800800.2090ca21.ffffffff.90ca21a9.efffefff.ff00ff00.00000000=
=2E00000000
    compatible: 'sun4u'
    builtin-io-device-port:  0000001f
    device-probe-order: '1b,0,4,9,'
    breakpoint-trap:  0000007f
    #size-cells:  00000002
    model: 'SUNW,501-2996'
    name: 'SUNW,Ultra-4'
    clock-frequency:  05e188aa
    banner-name: 'Sun Enterprise 450 (4 X UltraSPARC-II 296MHz)'
    device_type: 'upa'

    Node 0xf002d10c
        .node:  f002d10c
        name: 'packages'

        Node 0xf003462c
            .node:  f003462c
            iso6429-1983-colors: =20
            name: 'terminal-emulator'

        Node 0xf0037304
            .node:  f0037304
            disk-write-fix: =20
            name: 'deblocker'

        Node 0xf00379c8
            .node:  f00379c8
            name: 'obp-tftp'

        Node 0xf00416ec
            .node:  f00416ec
            name: 'disk-label'

    Node 0xf002d17c
        .node:  f002d17c
        stdin:  fff138b8
        stdout:  fff13ea8
        mmu:  fffea438
        memory:  fffea638
        bootargs:  00
        bootpath: '/pci@1f,4000/scsi@3/disk@0,0:a'
        gateway-ip:  00000000
        server-ip:  00000000
        client-ip:  00000000
        stdout-#lines:  00000022
        name: 'chosen'

    Node 0xf002d1e8
        .node:  f002d1e8
        version: 'OBP 3.7.107 1998/02/19 17:54'
        model: 'SUNW,3.7'
        decode-complete: =20
        aligned-allocator: =20
        relative-addressing: =20
        name: 'openprom'

        Node 0xf002d278
            .node:  f002d278
            name: 'client-services'

    Node 0xf002d320
        .node:  f002d320
        diag-passes: '1'
        diag-verbosity: '0'
        diag-continue?: 'false'
        tpe-link-test?: 'true'
        scsi-initiator-id: '7'
        keyboard-click?: 'false'
        keymap: =20
        ttyb-mode: '9600,8,n,1,-'
        ttya-mode: '9600,8,n,1,-'
        ttyb-rts-dtr-off: 'false'
        ttyb-ignore-cd: 'true'
        ttya-rts-dtr-off: 'false'
        ttya-ignore-cd: 'true'
        reboot-flag: 'false'
        reboot-posc: '0'
        reboot-posl: '18'
        reboot-cmd: 'boot'
        pci-slot-skip-list: 'none'
        pci0-probe-list: '3,2,4'
        upa-port-skip-list: 'none'
        memory-interleave: 'auto'
        disk-led-assoc: '0 10'
        diag-level: 'min'
        diag-script: 'normal'
        diag-targets: 'none'
        diag-trigger: 'power-reset'
        env-monitor: 'enabled'
        asr-disable-list: =20
        asr-status: '18437736870358094097'
        post-status: '18437736870358094097'
        post-address: '18446744073441855584'
        post-flag: '0'
        obp-flags: '0'
        obp-state: '6'
        obp-status: '0'
        #power-cycles: '181'
        system-board-serial#: '803M9358'
        system-board-date: '34c1ea2f'
        fcode-debug?: 'false'
        output-device: 'screen'
        input-device: 'keyboard'
        load-base: '16384'
        boot-command: 'boot'
        auto-boot?: 'true'
        auto-boot-on-error?: 'false'
        watchdog-reboot?: 'false'
        diag-file: =20
        diag-device: 'net'
        boot-file: =20
        boot-device: 'disk net'
        local-mac-address?: 'false'
        ansi-terminal?: 'true'
        screen-#columns: '80'
        screen-#rows: '34'
        silent-mode?: 'false'
        use-nvramrc?: 'false'
        nvramrc: =20
        security-mode: 'none'
        security-password: =20
        security-#badlogins: '4096'
        oem-logo: =20
        oem-logo?: 'false'
        oem-banner: =20
        oem-banner?: 'false'
        hardware-revision: 'UUUUUUUUUUUUUUU'
        last-hardware-update: 'UUUUTUT'
        upa-noprobe-mask: '0'
        mfg-options: '49'
        diag-switch?: 'false'
        name: 'options'

    Node 0xf002d390
        .node:  f002d390
        screen: '/SUNW,ffb@1d,0'
        disk: '/pci@1f,4000/scsi@3/disk@0,0'
        disk0: '/pci@1f,4000/scsi@3/disk@0,0'
        disk1: '/pci@1f,4000/scsi@3/disk@1,0'
        disk2: '/pci@1f,4000/scsi@3/disk@2,0'
        disk3: '/pci@1f,4000/scsi@3/disk@3,0'
        scsi: '/pci@1f,4000/scsi@3'
        diskx0: '/pci@1f,4000/scsi@2/disk@0,0'
        diskx1: '/pci@1f,4000/scsi@2/disk@1,0'
        diskx2: '/pci@1f,4000/scsi@2/disk@2,0'
        diskx3: '/pci@1f,4000/scsi@2/disk@3,0'
        cdrom: '/pci@1f,4000/scsi@2/disk@6,0:f'
        tape: '/pci@1f,4000/scsi@2/tape@4,0'
        scsix: '/pci@1f,4000/scsi@2'
        pci: '/pci@1f,4000'
        pcia: '/pci@1f,2000'
        pcib: '/pci@1f,4000'
        pci0: '/pci@1f,4000'
        pci1: '/pci@1f,2000'
        pci2: '/pci@4,4000'
        pci3: '/pci@4,2000'
        pci4: '/pci@6,4000'
        pci5: '/pci@6,2000'
        flash: '/pci@1f,4000/ebus@1/flashprom@10,0'
        nvram: '/pci@1f,4000/ebus@1/eeprom@14,0'
        parallel: '/pci@1f,4000/ebus@1/ecpp@14,3043bc'
        net: '/pci@1f,4000/network@1,1'
        ebus: '/pci@1f,4000/ebus@1'
        i2c: '/pci@1f,4000/ebus@1/SUNW,envctrl'
        floppy: '/pci@1f,4000/ebus@1/fdthree'
        tty: '/pci@1f,4000/ebus@1/se'
        ttyb: '/pci@1f,4000/ebus@1/se:b'
        ttya: '/pci@1f,4000/ebus@1/se:a'
        keyboard!: '/pci@1f,4000/ebus@1/su@14,3083f8:forcemode'
        keyboard: '/pci@1f,4000/ebus@1/su@14,3083f8'
        mouse: '/pci@1f,4000/ebus@1/su@14,3062f8'
        name: 'aliases'

    Node 0xf0050068
        .node:  f0050068
        interleave:  00000000.00000000.00000000.40000000.00000004
        reg:  00000000.00000000.00000000.40000000
        #size-cells:  00000002
        available:  00000000.3fe76000.00000000.00010000.00000000.3fe00000.0=
0000000.00072000.00000000.00000000.00000000.3fdfe000
        name: 'memory'

    Node 0xf0050648
        .node:  f0050648
        translations:  00000000.fffe0000.00000000.00010000.80000000.3fef00b=
6.00000000.fffcc000.00000000.00014000.80000000.3fed40b6.00000000.fffc6000.0=
0000000.00002000.800001fe.0000208e.00000000.fffc4000.00000000.00002000.8800=
01fe.0180008e.00000000.fffb6000.00000000.0000e000.800001fe.0000008e.0000000=
0.fffb4000.00000000.00002000.800001fe.0000408e.00000000.fffb2000.00000000.0=
0002000.880001fe.0100008e.00000000.fffa4000.00000000.0000e000.800001fe.0000=
008e.00000000.fff9c000.00000000.00008000.80000000.3fec80b6.00000000.fff9a00=
0.00000000.00002000.800001ff.f140008e.00000000.fff98000.00000000.00002000.8=
00001fe.0000008e.00000000.fff96000.00000000.00002000.800001fe.0000008e.0000=
0000.fff94000.00000000.00002000.800001fe.0000008e.00000000.fff92000.0000000=
0.00002000.800001ff.f100008e.00000000.fff90000.00000000.00002000.800001ff.f=
100008e.00000000.fff8e000.00000000.00002000.800001ff.f150008e.00000000.fff8=
c000.00000000.00002000.800001ff.f172608e.00000000.fff8a000.00000000.0000200=
0.800001ff.f172808e.00000000.fff88000.00000000.00002000.800001ff.f172a08e.0=
0000000.fff86000.00000000.00002000.800001ff.f172c08e.00000000.fff84000.0000=
0000.00002000.800001ff.f172e08e.00000000.fff82000.00000000.00002000.8000000=
0.3fed00b6.00000000.fff7e000.00000000.00004000.80000000.3fec40b6.00000000.f=
ff7c000.00000000.00002000.80000000.3fdfe0b6.00000000.fff7a000.00000000.0000=
2000.80000000.3fec20b6.00000000.fff78000.00000000.00002000.800001ff.f130608=
e.00000000.fff76000.00000000.00002000.800001ff.f160008e.00000000.fff74000.0=
0000000.00002000.800001ff.f130808e.00000000.fff72000.00000000.00002000.8000=
01ff.f130208e.00000000.fff70000.00000000.00002000.800001ff.f170608e.0000000=
0.fff6e000.00000000.00002000.800001ff.f172008e.00000000.fff6c000.00000000.0=
0002000.800001ff.f130208e.00000000.fff6a000.00000000.00002000.800001ff.f130=
208e.00000000.fff66000.00000000.00004000.80000000.3febe0b6.00000000.fff6400=
0.00000000.00002000.800001c8.0000208e.00000000.fff62000.00000000.00002000.8=
80001c8.0180008e.00000000.fff54000.00000000.0000e000.800001c8.0000008e.0000=
0000.fff52000.00000000.00002000.800001c8.0000408e.00000000.fff50000.0000000=
0.00002000.880001c8.0100008e.00000000.fff42000.00000000.0000e000.800001c8.0=
000008e.00000000.fff3a000.00000000.00008000.80000000.3feb00b6.00000000.fff3=
8000.00000000.00002000.800001cc.0000208e.00000000.fff36000.00000000.0000200=
0.880001cc.0180008e.00000000.fff28000.00000000.0000e000.800001cc.0000008e.0=
0000000.fff26000.00000000.00002000.800001cc.0000408e.00000000.fff24000.0000=
0000.00002000.880001cc.0100008e.00000000.fff16000.00000000.0000e000.800001c=
c.0000008e.00000000.fff14000.00000000.00002000.800001ff.8001008e.00000000.f=
ff12000.00000000.00002000.80000000.3feba0b6.00000000.fff10000.00000000.0000=
2000.800001ff.8001208e.00000000.fff0e000.00000000.00002000.800001fa.0061008=
e.00000000.fff06000.00000000.00008000.80000000.3fea80b6.00000000.fff04000.0=
0000000.00002000.800001fa.0020008e.00000000.fff02000.00000000.00002000.8000=
01fa.0040008e.00000000.ffefe000.00000000.00002000.80000000.3feb80b6.0000000=
0.ffee0000.00000000.0001e000.80000000.3fe8a0b6.00000000.fefd0000.00000000.0=
0030000.800001fa.0000008e.00000000.fefbe000.00000000.00012000.800001fa.0060=
008e.00000000.febbe000.00000000.00400000.800001fa.0100008e.00000000.fe1be00=
0.00000000.00a00000.800001fa.0300008e.00000000.f0000000.00000000.00100000.8=
0000000.3ff000b6.00000000.40000000.00000000.00800000.80000000.00400036.0000=
0000.00002000.00000000.00bfe000.80000000.00002036
        existing:  00000000.00000000.00000800.00000000.fffff800.00000000.00=
000800.00000000
        available:  fffff800.00000000.000007fc.00000000.00000001.00000000.0=
00007ff.00000000.00000000.ffff0000.00000000.0000e000.00000000.00000000.0000=
0000.f0000000.00000000.fff00000.00000000.00002000.00000000.f0800000.0000000=
0.0d9be000
        page-size:  00002000
        name: 'virtual-memory'

    Node 0xf005473c
        .node:  f005473c
        name: 'associations'

        Node 0xf00aca2c
            .node:  f00aca2c
            slot#11: '/pci@1f,4000/scsi@4,1/disk@3'
            slot#10: '/pci@1f,4000/scsi@4,1/disk@2'
            slot#9: '/pci@1f,4000/scsi@4,1/disk@1'
            slot#8: '/pci@1f,4000/scsi@4,1/disk@0'
            slot#7: '/pci@1f,4000/scsi@4/disk@3'
            slot#6: '/pci@1f,4000/scsi@4/disk@2'
            slot#5: '/pci@1f,4000/scsi@4/disk@1'
            slot#4: '/pci@1f,4000/scsi@4/disk@0'
            slot#3: '/pci@1f,4000/scsi@3/disk@3'
            slot#2: '/pci@1f,4000/scsi@3/disk@2'
            slot#1: '/pci@1f,4000/scsi@3/disk@1'
            slot#0: '/pci@1f,4000/scsi@3/disk@0'
            name: 'slot2disk'

        Node 0xf00acad0
            .node:  f00acad0
            slot#11: '/pci@1f,4000/ebus@1/i2c@14,600000/bits@42/wo@7'
            slot#10: '/pci@1f,4000/ebus@1/i2c@14,600000/bits@42/wo@6'
            slot#9: '/pci@1f,4000/ebus@1/i2c@14,600000/bits@42/wo@5'
            slot#8: '/pci@1f,4000/ebus@1/i2c@14,600000/bits@42/wo@4'
            slot#7: '/pci@1f,4000/ebus@1/i2c@14,600000/bits@42/wo@3'
            slot#6: '/pci@1f,4000/ebus@1/i2c@14,600000/bits@42/wo@2'
            slot#5: '/pci@1f,4000/ebus@1/i2c@14,600000/bits@42/wo@1'
            slot#4: '/pci@1f,4000/ebus@1/i2c@14,600000/bits@42/wo@0'
            slot#3: '/pci@1f,4000/ebus@1/i2c@14,600000/bits@40/wo@3'
            slot#2: '/pci@1f,4000/ebus@1/i2c@14,600000/bits@40/wo@2'
            slot#1: '/pci@1f,4000/ebus@1/i2c@14,600000/bits@40/wo@1'
            slot#0: '/pci@1f,4000/ebus@1/i2c@14,600000/bits@40/wo@0'
            name: 'slot2led'

        Node 0xf00ad1ac
            .node:  f00ad1ac
            ebus|audio: '/pci@1f,4000/ebus@1/*@14,200000'
            pci-slot#10: '/pci@1f,4000/*@4,*'
            pci-slot#9: '/pci@4,4000/*@2,*'
            pci-slot#8: '/pci@4,4000/*@3,*'
            pci-slot#7: '/pci@4,4000/*@4,*'
            pci-slot#6: '/pci@4,2000/*@1,*'
            pci-slot#5: '/pci@1f,2000/*@1,*'
            pci-slot#4: '/pci@6,2000/*@1,*'
            pci-slot#3: '/pci@6,4000/*@2,*'
            pci-slot#2: '/pci@6,4000/*@3,*'
            pci-slot#1: '/pci@6,4000/*@4,*'
            graphics#2: '/*@1d,0'
            graphics#1: '/*@1e,0'
            cpu-b2: '/*@3,0'
            cpu-b1: '/*@2,0'
            cpu-a2: '/*@1,0'
            cpu-a1: '/*@0,0'
            name: 'slot2dev'

    Node 0xf0058900
        .node:  f0058900
        address:  fff99c00.fff97860.fff95060
        interrupts:  000007ec.000007ed
        reg:  000001fe.00001c00.00000000.00000020.000001fe.00001860.0000000=
0.00000010.000001fe.00001060.00000000.00000010
        name: 'counter-timer'

    Node 0xf006ab20
        .node:  f006ab20
        slot-names:  0000001e.4d6f7468.6572626f.61726400.4d6f7468.6572626f.=
61726400.4d6f7468.6572626f.61726400.50434920.736c6f74.20313000
        available:  82000000.00000000.00018000.00000000.7ffe8000.81000000.0=
0000000.00001100.00000000.0000ef00
        bus-range:  00000000.00000000
        no-probe-list: '0,1'
        scsi-initiator-id:  00000007
        version#:  00000004
        implementation#:  00000000
        address:  fffb4000.fffb2000.fffa4000
        #upa-interrupt-proxies:  00000002
        clock-frequency:  01f78a40
        upa-portid:  0000001f
        interrupts:  000007f1.000007ee.000007ef.000007e5.000007e8.000007f2
        ranges:  00000000.00000000.00000000.000001fe.01000000.00000000.0080=
0000.01000000.00000000.00000000.000001fe.02010000.00000000.00010000.0200000=
0.00000000.00000000.000001ff.80000000.00000000.80000000.03000000.00000000.0=
0000000.000001ff.80000000.00000000.80000000
        reg:  000001fe.00004000.00000000.00002000.000001fe.01000000.0000000=
0.00000100.000001fe.00000000.00000000.0000d000
        latency-timer:  00000040
        model: 'SUNW,psycho'
        compatible:  70636931.3038652c.38303030.00706369.636c6173.732c3036.=
30303030.00
        thermal-interrupt: =20
        bus-parity-generated: =20
        #size-cells:  00000002
        #address-cells:  00000003
        device_type: 'pci'
        name: 'pci'

        Node 0xf006cd68
            .node:  f006cd68
            latency-timer:  0000000a
            fast-back-to-back: =20
            devsel-speed:  00000001
            class-code:  00068000
            max-latency:  00000019
            min-grant:  0000000a
            revision-id:  00000001
            device-id:  00001000
            vendor-id:  0000108e
            fru: 'motherboard'
            ranges:  00000010.00000000.82000810.00000000.70000000.01000000.=
00000014.00000000.82000814.00000000.71000000.00800000
            reg:  00000800.00000000.00000000.00000000.00000000.82000810.000=
00000.70000000.00000000.01000000.82000814.00000000.71000000.00000000.008000=
00
            #size-cells:  00000001
            #address-cells:  00000002
            name: 'ebus'

            Node 0xf006d2d4
                .node:  f006d2d4
                address:  fff8c000.fff8a000.fff88000.fff86000.fff85000
                reg:  00000014.00726000.00000004.00000014.00728000.00000004=
=2E00000014.0072a000.00000004.00000014.0072c000.00000004.00000014.0072f000.=
00000004
                name: 'auxio'

            Node 0xf006d394
                .node:  f006d394
                interrupts:  000007e5.000007f2
                reg:  00000014.00724000.00000004
                name: 'power'

            Node 0xf006d44c
                .node:  f006d44c
                freq-syn: 'MC12430'
                reg:  00000014.00504000.00000003
                name: 'SUNW,pll'

            Node 0xf006d4e0
                .node:  f006d4e0
                address:  fff8e000
                version#:  00000001
                implementation#:  00000000
                model: 'SUNW,sc-marvin'
                reg:  00000014.00500000.00000008
                name: 'sc'

            Node 0xf006d598
                .node:  f006d598
                port-b-ignore-cd: =20
                port-a-ignore-cd: =20
                address:  fff9a000
                fru: 'motherboard'
                interrupts:  000007eb
                device_type: 'serial'
                reg:  00000014.00400000.00000080
                name: 'se'

            Node 0xf006d670
                .node:  f006d670
                address:  fff743f8
                fru: 'motherboard'
                port-b-ignore-cd: =20
                port-a-ignore-cd: =20
                keyboard: =20
                interrupts:  000007e9
                reg:  00000014.003083f8.00000008
                device_type: 'serial'
                name: 'su'

            Node 0xf006d7b8
                .node:  f006d7b8
                address:  fff782f8
                fru: 'motherboard'
                port-b-ignore-cd: =20
                port-a-ignore-cd: =20
                mouse: =20
                interrupts:  000007ea
                reg:  00000014.003062f8.00000008
                device_type: 'serial'
                name: 'su'

            Node 0xf006d8fc
                .node:  f006d8fc
                fru: 'motherboard'
                interrupts:  000007e2
                reg:  00000014.003043bc.00000010.00000014.00300398.00000002=
=2E00000014.00700000.00000010
                name: 'ecpp'

            Node 0xf006d9fc
                .node:  f006d9fc
                manual: =20
                unit:  00000000
                address:  fff723f0.fff70000.fff6e000
                fru: 'floppy'
                device_type: 'block'
                interrupts:  000007e7
                reg:  00000014.003023f0.00000008.00000014.00706000.00000010=
=2E00000014.00720000.00000004
                name: 'fdthree'

            Node 0xf006db48
                .node:  f006db48
                watchdog-enable: =20
                address:  fff90000
                fru: 'motherboard'
                reg:  00000014.00000000.00002000
                model: 'mk48t59'
                name: 'eeprom'

            Node 0xf006dc30
                .node:  f006dc30
                version:  4f425020.332e372e.31303720.31393938.2f30322f.3139=
2031.373a3534.00504f53.5420352e.302e3820.31393938.2f30312f.32362031.373a353=
2.00
                model: 'SUNW,525-1672'
                reg:  00000010.00000000.00100000.00000010.00000000.00100000
                name: 'flashprom'

            Node 0xf00746cc
                .node:  f00746cc
                fan-override:  00000000
                activity-led-blink?: =20
                address:  fff76000
                fru: 'motherboard, power_supply, fan, CPU'
                fan-readback-maxima:  1c202428.2d313539.3d414549.4d51555a.5=
e62666a.6e72767a.7e82878b.8f93979b.9fa3a7ab.afb4b8bc.c0c4c8cc.d0d4d8dc.e1e5=
e9f1.f5fafdff.ffffffff.ffffffff
                fan-readback-minima:  0005090c.1013161a.1d212427.2b2e3235.3=
83c3f43.46494d50.54575b5e.6165686c.6f727679.7d808387.8a8e9195.989b9fa2.a6a9=
acb0.b3b7baba.bababbbc.bebebebe
                ps-fan-speeds:  1f1f1f1f.1f1f1f1f.1f1f1f1f.1f1f1f1f.1f1f1f1=
f.1f1f1f1f.1f1f1f1f.1f212223.24252626.2728292a.2b2d2e2f.30303030.30303132.3=
3343536.3738393a.3b3c3d3e.3f3f3f3f.3f3f3f3f.3f3f3f3f.3f3f3f3f.3f3f3f3f.3f3f=
3f3f.3f3f3f3f.3f3f3f3f.3f3f3f3f.3f3f3f3f.3f3f3f3f.3f3f3f3f
                cpu-fan-speeds:  1f1f1f1f.1f1f1f1f.1f1f1f1f.1f1f1f1f.1f1f1f=
1f.1f1f1f1f.1f1f1f1f.20212223.24252627.282a2b2d.30313233.34353637.38393a3b.=
3c3d3e3f.3f3f3f3f.3f3f3f3f.3f3f3f3f.3f3f3f3f.3f3f3f3f.3f3f3f3f.3f3f3f3f.3f3=
f3f3f.3f3f3f3f.3f3f3f3f.3f3f3f3f.3f3f3f3f.3f3f3f3f.3f3f3f3f
                disk-leds-state:  00000000
                disk-leds-present:  0000000f.000000ff.00000000
                panel-leds-state:  00000000
                panel-leds-present:  0000003f
                interrupt-priorities:  00000009.00000009
                interrupts:  000007e8.000007e5
                reg:  00000014.00600000.00000004
                name: 'SUNW,envctrl'

        Node 0xf0078134
            .node:  f0078134
            latency-timer:  0000000a
            assigned-addresses:  82000910.00000000.00008000.00000000.000070=
20
            hm-rev:  000000c1
            interrupts:  000007e1
            fast-back-to-back: =20
            devsel-speed:  00000001
            class-code:  00020000
            max-latency:  00000005
            min-grant:  0000000a
            revision-id:  00000001
            device-id:  00001001
            vendor-id:  0000108e
            fru: 'motherboard'
            device_type: 'network'
            intr:  000007e1.00000000
            address-bits:  00000030
            max-frame-size:  00004000
            reg:  00000900.00000000.00000000.00000000.00000000.02000910.000=
00000.00000000.00000000.00007020
            compatible: 'SUNW,hme'
            name: 'network'

        Node 0xf008f328
            .node:  f008f328
            latency-timer:  00000011
            assigned-addresses:  81001810.00000000.00000400.00000000.000001=
00.82001814.00000000.00010000.00000000.00000100.82001818.00000000.00011000.=
00000000.00001000
            device_type: 'scsi-2'
            fru: 'motherboard'
            clock-frequency:  02625a00
            reg:  00001800.00000000.00000000.00000000.00000000.01001810.000=
00000.00000000.00000000.00000100.02001814.00000000.00000000.00000000.000001=
00.02001818.00000000.00000000.00000000.00001000
            model: 'Symbios,53C875'
            compatible:  70636931.3030302c.6600676c.6d007063.69636c61.73732=
c30.30313030.3000
            name: 'scsi'
            devsel-speed:  00000001
            class-code:  00010000
            interrupts:  000007e0
            max-latency:  00000040
            min-grant:  00000011
            revision-id:  00000003
            device-id:  0000000f
            vendor-id:  00001000

            Node 0xf00944f8
                .node:  f00944f8
                device_type: 'block'
                compatible: 'sd'
                name: 'disk'

            Node 0xf0095c3c
                .node:  f0095c3c
                device_type: 'byte'
                compatible: 'st'
                name: 'tape'

        Node 0xf00969e8
            .node:  f00969e8
            interrupt-priorities:  00000004
            latency-timer:  00000011
            assigned-addresses:  81001010.00000000.00000800.00000000.000001=
00.82001014.00000000.00012000.00000000.00000100.82001018.00000000.00013000.=
00000000.00001000
            device_type: 'scsi-2'
            fru: 'motherboard'
            clock-frequency:  02625a00
            reg:  00001000.00000000.00000000.00000000.00000000.01001010.000=
00000.00000000.00000000.00000100.02001014.00000000.00000000.00000000.000001=
00.02001018.00000000.00000000.00000000.00001000
            model: 'Symbios,53C875'
            compatible:  70636931.3030302c.6600676c.6d007063.69636c61.73732=
c30.30313030.3000
            name: 'scsi'
            devsel-speed:  00000001
            class-code:  00010000
            interrupts:  000007e6
            max-latency:  00000040
            min-grant:  00000011
            revision-id:  00000003
            device-id:  0000000f
            vendor-id:  00001000

            Node 0xf009b798
                .node:  f009b798
                device_type: 'block'
                compatible: 'sd'
                name: 'disk'

            Node 0xf009cedc
                .node:  f009cedc
                device_type: 'byte'
                compatible: 'st'
                name: 'tape'

        Node 0xf009dc88
            .node:  f009dc88
            latency-timer:  00000011
            assigned-addresses:  81002010.00000000.00000c00.00000000.000001=
00.82002014.00000000.00014000.00000000.00000100.82002018.00000000.00015000.=
00000000.00001000
            device_type: 'scsi-2'
            fru: 'motherboard'
            clock-frequency:  02625a00
            reg:  00002000.00000000.00000000.00000000.00000000.01002010.000=
00000.00000000.00000000.00000100.02002014.00000000.00000000.00000000.000001=
00.02002018.00000000.00000000.00000000.00001000
            model: 'Symbios,53C875'
            compatible:  70636931.3030302c.31303030.00706369.31303030.2c660=
067.6c6d0070.6369636c.6173732c.30303130.303000
            name: 'scsi'
            devsel-speed:  00000001
            class-code:  00010000
            interrupts:  00000001
            subsystem-vendor-id:  00001000
            subsystem-id:  00001000
            max-latency:  00000040
            min-grant:  00000011
            revision-id:  00000014
            device-id:  0000000f
            vendor-id:  00001000

            Node 0xf00a2a98
                .node:  f00a2a98
                device_type: 'block'
                compatible: 'sd'
                name: 'disk'

            Node 0xf00a41dc
                .node:  f00a41dc
                device_type: 'byte'
                compatible: 'st'
                name: 'tape'

        Node 0xf00a4f88
            .node:  f00a4f88
            latency-timer:  00000011
            assigned-addresses:  81002110.00000000.00001000.00000000.000001=
00.82002114.00000000.00016000.00000000.00000100.82002118.00000000.00017000.=
00000000.00001000
            device_type: 'scsi-2'
            fru: 'motherboard'
            clock-frequency:  02625a00
            reg:  00002100.00000000.00000000.00000000.00000000.01002110.000=
00000.00000000.00000000.00000100.02002114.00000000.00000000.00000000.000001=
00.02002118.00000000.00000000.00000000.00001000
            model: 'Symbios,53C875'
            compatible:  70636931.3030302c.31303030.00706369.31303030.2c660=
067.6c6d0070.6369636c.6173732c.30303130.303000
            name: 'scsi'
            devsel-speed:  00000001
            class-code:  00010000
            interrupts:  00000002
            subsystem-vendor-id:  00001000
            subsystem-id:  00001000
            max-latency:  00000040
            min-grant:  00000011
            revision-id:  00000014
            device-id:  0000000f
            vendor-id:  00001000

            Node 0xf00a9d98
                .node:  f00a9d98
                device_type: 'block'
                compatible: 'sd'
                name: 'disk'

            Node 0xf00ab4dc
                .node:  f00ab4dc
                device_type: 'byte'
                compatible: 'st'
                name: 'tape'

    Node 0xf006b824
        .node:  f006b824
        slot-names:  00000002.50434920.736c6f74.203500
        available:  82800000.00000000.00001000.00000000.7ffff000.81800000.0=
0000000.00000400.00000000.0000fc00
        bus-range:  00000080.00000080
        no-probe-list: '0'
        scsi-initiator-id:  00000007
        clock-frequency:  03ef1480
        version#:  00000004
        implementation#:  00000000
        address:  fffc6000.fffc4000.fffb6000
        upa-portid:  0000001f
        66mhz-capable: =20
        interrupts:  000007f0.000007ee.000007ef.000007e5.000007e8.000007f2
        ranges:  00800000.00000000.00000000.000001fe.01000000.00000000.0080=
0000.01000000.00000000.00000000.000001fe.02000000.00000000.00010000.0200000=
0.00000000.00000000.000001ff.00000000.00000000.80000000.03000000.00000000.0=
0000000.000001ff.00000000.00000000.80000000
        reg:  000001fe.00002000.00000000.00002000.000001fe.01800000.0000000=
0.00000100.000001fe.00000000.00000000.0000d000
        latency-timer:  00000040
        model: 'SUNW,psycho'
        compatible:  70636931.3038652c.38303030.00706369.636c6173.732c3036.=
30303030.00
        thermal-interrupt: =20
        bus-parity-generated: =20
        #size-cells:  00000002
        #address-cells:  00000003
        device_type: 'pci'
        name: 'pci'

    Node 0xf0083198
        .node:  f0083198
        ranges:  00000000.00000000.00000000.00000000.00000001.00000000
        reg:  000001c0.00000000.00000000.00000fff
        #size-cells:  00000002
        fru: 'motherboard'
        device_type: 'memory-controller'
        name: 'mc'

        Node 0xf008334c
            .node:  f008334c
            bank-interleave:  00000000.10000000.00000000.000000c0.00000000
            reg:  00000000.00000000.00000000.10000000
            #size-cells:  00000002
            fru: 'motherboard'
            device_type: 'memory-bank'
            name: 'bank'

            Node 0xf00834a0
                .node:  f00834a0
                socket-name: '1901'
                reg:  00000000.00000000.00000000.04000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf00835e8
                .node:  f00835e8
                socket-name: '1902'
                reg:  00000000.00000001.00000000.04000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0083730
                .node:  f0083730
                socket-name: '1903'
                reg:  00000000.00000002.00000000.04000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0083878
                .node:  f0083878
                socket-name: '1904'
                reg:  00000000.00000003.00000000.04000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

        Node 0xf0083a50
            .node:  f0083a50
            bank-interleave:  00000000.10000000.00000000.000000c0.00000040
            reg:  00000000.40000000.00000000.10000000
            #size-cells:  00000002
            fru: 'motherboard'
            device_type: 'memory-bank'
            name: 'bank'

            Node 0xf0083ba4
                .node:  f0083ba4
                socket-name: '1801'
                reg:  00000000.00000000.00000000.04000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0083cec
                .node:  f0083cec
                socket-name: '1802'
                reg:  00000000.00000001.00000000.04000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0083e34
                .node:  f0083e34
                socket-name: '1803'
                reg:  00000000.00000002.00000000.04000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0083f7c
                .node:  f0083f7c
                socket-name: '1804'
                reg:  00000000.00000003.00000000.04000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

        Node 0xf0084154
            .node:  f0084154
            bank-interleave:  00000000.10000000.00000000.000000c0.00000080
            reg:  00000000.80000000.00000000.10000000
            #size-cells:  00000002
            fru: 'motherboard'
            device_type: 'memory-bank'
            name: 'bank'

            Node 0xf00842a8
                .node:  f00842a8
                socket-name: '1701'
                reg:  00000000.00000000.00000000.04000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf00843f0
                .node:  f00843f0
                socket-name: '1702'
                reg:  00000000.00000001.00000000.04000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0084538
                .node:  f0084538
                socket-name: '1703'
                reg:  00000000.00000002.00000000.04000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0084680
                .node:  f0084680
                socket-name: '1704'
                reg:  00000000.00000003.00000000.04000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

        Node 0xf0084858
            .node:  f0084858
            bank-interleave:  00000000.10000000.00000000.000000c0.000000c0
            reg:  00000000.c0000000.00000000.10000000
            #size-cells:  00000002
            fru: 'motherboard'
            device_type: 'memory-bank'
            name: 'bank'

            Node 0xf00849ac
                .node:  f00849ac
                socket-name: '1601'
                reg:  00000000.00000000.00000000.04000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0084af4
                .node:  f0084af4
                socket-name: '1602'
                reg:  00000000.00000001.00000000.04000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0084c3c
                .node:  f0084c3c
                socket-name: '1603'
                reg:  00000000.00000002.00000000.04000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0084d84
                .node:  f0084d84
                socket-name: '1604'
                reg:  00000000.00000003.00000000.04000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

    Node 0xf008561c
        .node:  f008561c
        manufacturer#:  00000017
        implementation#:  00000011
        mask#:  00000011
        sparc-version:  00000009
        ecache-associativity:  00000001
        ecache-line-size:  00000040
        ecache-size:  00200000
        #dtlb-entries:  00000040
        dcache-associativity:  00000001
        dcache-line-size:  00000020
        dcache-size:  00004000
        #itlb-entries:  00000040
        icache-associativity:  00000002
        icache-line-size:  00000020
        icache-size:  00004000
        upa-portid:  00000000
        clock-frequency:  11a49a00
        reg:  000001c0.00000000.00000000.00000008
        device_type: 'cpu'
        name: 'SUNW,UltraSPARC-II'

    Node 0xf0085988
        .node:  f0085988
        manufacturer#:  00000017
        implementation#:  00000011
        mask#:  00000020
        sparc-version:  00000009
        ecache-associativity:  00000001
        ecache-line-size:  00000040
        ecache-size:  00200000
        #dtlb-entries:  00000040
        dcache-associativity:  00000001
        dcache-line-size:  00000020
        dcache-size:  00004000
        #itlb-entries:  00000040
        icache-associativity:  00000002
        icache-line-size:  00000020
        icache-size:  00004000
        upa-portid:  00000001
        clock-frequency:  11a49a00
        reg:  000001c2.00000000.00000000.00000008
        device_type: 'cpu'
        name: 'SUNW,UltraSPARC-II'

    Node 0xf0085cf4
        .node:  f0085cf4
        manufacturer#:  00000017
        implementation#:  00000011
        mask#:  00000020
        sparc-version:  00000009
        ecache-associativity:  00000001
        ecache-line-size:  00000040
        ecache-size:  00200000
        #dtlb-entries:  00000040
        dcache-associativity:  00000001
        dcache-line-size:  00000020
        dcache-size:  00004000
        #itlb-entries:  00000040
        icache-associativity:  00000002
        icache-line-size:  00000020
        icache-size:  00004000
        upa-portid:  00000002
        clock-frequency:  11a49a00
        reg:  000001c4.00000000.00000000.00000008
        device_type: 'cpu'
        name: 'SUNW,UltraSPARC-II'

    Node 0xf0086060
        .node:  f0086060
        manufacturer#:  00000017
        implementation#:  00000011
        mask#:  00000020
        sparc-version:  00000009
        ecache-associativity:  00000001
        ecache-line-size:  00000040
        ecache-size:  00200000
        #dtlb-entries:  00000040
        dcache-associativity:  00000001
        dcache-line-size:  00000020
        dcache-size:  00004000
        #itlb-entries:  00000040
        icache-associativity:  00000002
        icache-line-size:  00000020
        icache-size:  00004000
        upa-portid:  00000003
        clock-frequency:  11a49a00
        reg:  000001c6.00000000.00000000.00000008
        device_type: 'cpu'
        name: 'SUNW,UltraSPARC-II'

    Node 0xf00863cc
        .node:  f00863cc
        character-set: 'ISO8859-1'
        address:  febbe000
        reg:  000001fa.00000000.00000000.00000400.000001fa.00400000.0000000=
0.00200000.000001fa.00600000.00000000.00200000.000001fa.01000000.00000000.0=
0400000.000001fa.01400000.00000000.00400000.000001fa.01800000.00000000.0040=
0000.000001fa.01c00000.00000000.00400000.000001fa.02000000.00000000.0100000=
0.000001fa.03000000.00000000.01000000.000001fa.04000000.00000000.00400000.0=
00001fa.04400000.00000000.00400000.000001fa.04800000.00000000.00400000.0000=
01fa.04c00000.00000000.00400000.000001fa.05000000.00000000.01000000.000001f=
a.06000000.00000000.02000000
        v_freq:  00000043
        height:  00000400
        awidth:  00000500
        linebytes:  00000500
        width:  00000500
        fbc_reg_id:  00000001
        ramdac_rev:  00000004
        model: 'SUNW,501-2634'
        board_type:  00000008
        interrupts:  00000005
        upa-portid:  0000001d
        upa-interrupt-slave: =20
        device_type: 'display'
        name: 'SUNW,ffb'

    Node 0xf008c2a0
        .node:  f008c2a0
        slot-names:  0000001c.50434920.736c6f74.20390050.43492073.6c6f7420.=
38005043.4920736c.6f742037.00
        available:  82000000.00000000.00001000.00000000.7ffff000.81000000.0=
0000000.00000400.00000000.0000fc00
        bus-range:  00000000.00000000
        version#:  00000004
        implementation#:  00000000
        address:  fff52000.fff50000.fff42000
        clock-frequency:  01f78a40
        upa-portid:  00000004
        interrupts:  00000131.0000012e.0000012f.00000125.00000128.00000132
        ranges:  00000000.00000000.00000000.000001c8.01000000.00000000.0080=
0000.01000000.00000000.00000000.000001c8.02010000.00000000.00010000.0200000=
0.00000000.00000000.000001c9.80000000.00000000.80000000.03000000.00000000.0=
0000000.000001c9.80000000.00000000.80000000
        reg:  000001c8.00004000.00000000.00002000.000001c8.01000000.0000000=
0.00000100.000001c8.00000000.00000000.0000d000
        latency-timer:  00000040
        model: 'SUNW,psycho'
        compatible:  70636931.3038652c.38303030.00706369.636c6173.732c3036.=
30303030.00
        thermal-interrupt: =20
        bus-parity-generated: =20
        #size-cells:  00000002
        #address-cells:  00000003
        device_type: 'pci'
        name: 'pci'

    Node 0xf008ce50
        .node:  f008ce50
        slot-names:  00000002.50434920.736c6f74.203600
        available:  82800000.00000000.00001000.00000000.7ffff000.81800000.0=
0000000.00000400.00000000.0000fc00
        bus-range:  00000080.00000080
        clock-frequency:  03ef1480
        version#:  00000004
        implementation#:  00000000
        address:  fff64000.fff62000.fff54000
        upa-portid:  00000004
        66mhz-capable: =20
        interrupts:  00000130.0000012e.0000012f.00000125.00000128.00000132
        ranges:  00800000.00000000.00000000.000001c8.01000000.00000000.0080=
0000.01000000.00000000.00000000.000001c8.02000000.00000000.00010000.0200000=
0.00000000.00000000.000001c9.00000000.00000000.80000000.03000000.00000000.0=
0000000.000001c9.00000000.00000000.80000000
        reg:  000001c8.00002000.00000000.00002000.000001c8.01800000.0000000=
0.00000100.000001c8.00000000.00000000.0000d000
        latency-timer:  00000040
        model: 'SUNW,psycho'
        compatible:  70636931.3038652c.38303030.00706369.636c6173.732c3036.=
30303030.00
        thermal-interrupt: =20
        bus-parity-generated: =20
        #size-cells:  00000002
        #address-cells:  00000003
        device_type: 'pci'
        name: 'pci'

    Node 0xf008dae4
        .node:  f008dae4
        slot-names:  0000001c.50434920.736c6f74.20330050.43492073.6c6f7420.=
32005043.4920736c.6f742031.00
        available:  82000000.00000000.00001000.00000000.7ffff000.81000000.0=
0000000.00000400.00000000.0000fc00
        bus-range:  00000000.00000000
        version#:  00000004
        implementation#:  00000000
        address:  fff26000.fff24000.fff16000
        clock-frequency:  01f78a40
        upa-portid:  00000006
        interrupts:  000001b1.000001ae.000001af.000001a5.000001a8.000001b2
        ranges:  00000000.00000000.00000000.000001cc.01000000.00000000.0080=
0000.01000000.00000000.00000000.000001cc.02010000.00000000.00010000.0200000=
0.00000000.00000000.000001cd.80000000.00000000.80000000.03000000.00000000.0=
0000000.000001cd.80000000.00000000.80000000
        reg:  000001cc.00004000.00000000.00002000.000001cc.01000000.0000000=
0.00000100.000001cc.00000000.00000000.0000d000
        latency-timer:  00000040
        model: 'SUNW,psycho'
        compatible:  70636931.3038652c.38303030.00706369.636c6173.732c3036.=
30303030.00
        thermal-interrupt: =20
        bus-parity-generated: =20
        #size-cells:  00000002
        #address-cells:  00000003
        device_type: 'pci'
        name: 'pci'

    Node 0xf008e694
        .node:  f008e694
        slot-names:  00000002.50434920.736c6f74.203400
        available:  82800000.00000000.00001000.00000000.7ffff000.81800000.0=
0000000.00000400.00000000.0000fc00
        bus-range:  00000080.00000080
        clock-frequency:  03ef1480
        version#:  00000004
        implementation#:  00000000
        address:  fff38000.fff36000.fff28000
        upa-portid:  00000006
        66mhz-capable: =20
        interrupts:  000001b0.000001ae.000001af.000001a5.000001a8.000001b2
        ranges:  00800000.00000000.00000000.000001cc.01000000.00000000.0080=
0000.01000000.00000000.00000000.000001cc.02000000.00000000.00010000.0200000=
0.00000000.00000000.000001cd.00000000.00000000.80000000.03000000.00000000.0=
0000000.000001cd.00000000.00000000.80000000
        reg:  000001cc.00002000.00000000.00002000.000001cc.01800000.0000000=
0.00000100.000001cc.00000000.00000000.0000d000
        latency-timer:  00000040
        model: 'SUNW,psycho'
        compatible:  70636931.3038652c.38303030.00706369.636c6173.732c3036.=
30303030.00
        thermal-interrupt: =20
        bus-parity-generated: =20
        #size-cells:  00000002
        #address-cells:  00000003
        device_type: 'pci'
        name: 'pci'


--Boundary-00=_ve46EwlMizQz5P4--
