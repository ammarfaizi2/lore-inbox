Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269343AbUICRaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269343AbUICRaH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 13:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269486AbUICRaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 13:30:06 -0400
Received: from holomorphy.com ([207.189.100.168]:6534 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269343AbUICRYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 13:24:06 -0400
Date: Fri, 3 Sep 2004 10:23:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Paulo Marques <pmarques@grupopie.com>
Subject: Re: 2.6.9-rc1-mm3
Message-ID: <20040903172354.GR3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Paulo Marques <pmarques@grupopie.com>
References: <20040903014811.6247d47d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040903014811.6247d47d.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 01:48:11AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm3/
> - Added the m32r architecture.  Haven't looked at it yet.
> - Status update on various large patches in -mm:
[...]

kallsyms still looks funny even with the latest fixes. dmesg follows.
Cheers.


-- wli

PROMLIB: Sun IEEE Boot Prom 3.2.30 2002/10/25 14:03
Linux version 2.6.9-rc1-mm3 (wli@analyticity) (gcc version 3.3.4 (Debian 1:3.3.4-9)) #1 SMP Fri Sep 3 03:16:52 PDT 2004
ARCH: SUN4U
Ethernet address: 08:00:20:89:ed:b7
On node 0 totalpages: 490172
  DMA zone: 490172 pages, LIFO batch:8
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
CENTRAL: Detected 4 slot Enterprise system. cfreg[a8] cver[fc]
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] (CENTRAL)
FHC(board 3): Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
FHC(board 5): Version[1] PartID[fa0] Manuf[3e] 
FHC(board 7): Version[1] PartID[fa0] Manuf[3e] 
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] 
Built 1 zonelists
Kernel command line: -p root=/dev/nfs nfsroot=/mnt/f/e3k/debian ip=dhcp debug initcall_debug profile=1
kernel profiling enabled (shift: 1)
PID hash table entries: 4096 (order: 12, 131072 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 524288 (order: 9, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 8, 2097152 bytes)
Memory: 3881600k available (2536k kernel code, 944k data, 144k init) [fffff80000000000,00000000efd18000]
Calibrating delay loop... 667.64 BogoMIPS (lpj=333824)
Mount-cache hash table entries: 512 (order: 0, 8192 bytes)
Calibrating delay loop... 667.64 BogoMIPS (lpj=333824)
CPU 7: synchronized TICK with master CPU (last diff -10 cycles,maxerr 670 cycles)
Calibrating delay loop... 667.64 BogoMIPS (lpj=333824)
CPU 10: synchronized TICK with master CPU (last diff -2 cycles,maxerr 660 cycles)
Calibrating delay loop... 667.64 BogoMIPS (lpj=333824)
CPU 11: synchronized TICK with master CPU (last diff -6 cycles,maxerr 714 cycles)
Calibrating delay loop... 667.64 BogoMIPS (lpj=333824)
CPU 14: synchronized TICK with master CPU (last diff -16 cycles,maxerr 692 cycles)
Calibrating delay loop... 667.64 BogoMIPS (lpj=333824)
CPU 15: synchronized TICK with master CPU (last diff -11 cycles,maxerr 696 cycles)
Brought up 6 CPUs
Total of 6 processors activated (4005.88 BogoMIPS).
SMP: Calibrating ecache flush... Using heuristic of 1200018 cycles, 3 ticks.
CPU6:  online
 domain 0: span 0000ccc0
  groups: 00000040 00000080 00000400 00000800 00004000 00008000
CPU7:  online
 domain 0: span 0000ccc0
  groups: 00000080 00000400 00000800 00004000 00008000 00000040
CPU10:  online
 domain 0: span 0000ccc0
  groups: 00000400 00000800 00004000 00008000 00000040 00000080
CPU11:  online
 domain 0: span 0000ccc0
  groups: 00000800 00004000 00008000 00000040 00000080 00000400
CPU14:  online
 domain 0: span 0000ccc0
  groups: 00004000 00008000 00000040 00000080 00000400 00000800
CPU15:  online
 domain 0: span 0000ccc0
  groups: 00008000 00000040 00000080 00000400 00000800 00004000
Calling initcall 0x00000000007756c0: p_siW2up_up_destroyup_up_siup_6up_+0x0/0x20()
Calling initcall 0x0000000000779a00: p_up_zup_up_+0x0/0x40()
Calling initcall 0x000000000077a240: p_siW649up_up_siup_6up_+0x0/0x60()
Calling initcall 0x000000000077a2a0: p_siW91up_4up_up_up_siup_6up_+0x0/0x20()
Calling initcall 0x000000000077a2c0: p_siW2up_up_up_siup_6up_+0x0/0x20()
Calling initcall 0x0000000000784d20: p_mup_fswTup_up_+0x0/0x80()
NET: Registered protocol family 16
Calling initcall 0x000000000077cc60: p_up_up_up_1up_up_sup_+0x0/0x40()
Calling initcall 0x0000000000773500: p_up_gs7up_3up_up_+0x0/0xa0()
Calling initcall 0x0000000000779780: p_siWup_p+0x0/0xc0()
Calling initcall 0x000000000077d100: p_649up_up_+0x0/0xc0()
Calling initcall 0x000000000077ed00: p_up_ynup_+0x0/0x40()
Calling initcall 0x000000000077ed40: p_up_9up_0up_Gup_+0x0/0x60()
Calling initcall 0x000000000077eda0: p_up_8up_up_0up_Gup_+0x0/0xc0()
Calling initcall 0x00000000007816c0: p_siW91up_+0x0/0x140()
SCSI subsystem initialized
Calling initcall 0x00000000007834e0: p_up_sup_+0x0/0x340()
SYSIO: UPA portID 2, at 000001c400000000
sbus0: Clock 25.0 MHz
SYSIO: UPA portID 3, at 000001c600000000
sbus1: Clock 25.0 MHz
dma0: HME DVMA gate array 
Calling initcall 0x0000000000783de0: p_sicpuup_+0x0/0xc0()
Calling initcall 0x0000000000784a40: p_up_up_iup_+0x0/0x1a0()
Calling initcall 0x000000000077c960: p_qup_fsiup_+0x0/0xc0()
Calling initcall 0x0000000000774f40: p_q6up_up_+0x0/0x60()
Calling initcall 0x0000000000777400: p_Kynicwup_+0x0/0x60()
Calling initcall 0x00000000007774e0: p_pup_sup_+0x0/0x60()
Calling initcall 0x00000000007776a0: p_res4up_up_ynup_+0x0/0xa0()
Calling initcall 0x0000000000777a20: p_siWup_7up_drivl6_p9+0x0/0xe0()
Calling initcall 0x0000000000777b00: p_up_+0x0/0x60()
Calling initcall 0x0000000000777b60: p_icup_up_up_up_+0x0/0x40()
Calling initcall 0x000000000045dd60: p_up__pup_fsup_up_up_+0x0/0xa0()
Calling initcall 0x0000000000777ba0: p_up_up_resup_sup_+0x0/0x20()
Calling initcall 0x0000000000777bc0: p_5tup_9xfrm_polic6sup_+0x0/0x40()
Calling initcall 0x0000000000777c00: 5Lup_3up_up_+0x0/0x60()
Calling initcall 0x0000000000462dc0: p_5Tsys32up_up_+0x0/0x40()
Calling initcall 0x0000000000778da0: p_siWup_up_up_up_ynJs6si+0x0/0x60()
Calling initcall 0x0000000000779040: p_up_up_roup_up_+0x0/0x20()
Calling initcall 0x0000000000779320: p__up_ynup_+0x0/0x80()
Calling initcall 0x00000000007793e0: p_59Oup_up_up_+0x0/0x80()
Calling initcall 0x00000000007794a0: p_w19Oup_sup_+0x0/0x40()
Calling initcall 0x00000000007794e0: p_siWup_6up_handler+0x0/0xe0()
Calling initcall 0x0000000000779960: p_siWup_4up_ynhandler+0x0/0x60()
Calling initcall 0x00000000007799c0: p_up_svc_up_up_+0x0/0x40()
Calling initcall 0x0000000000779d80: p_up_up_lup_up_up_+0x0/0x40()
Calling initcall 0x000000000077a040: p_0pGup_+0x0/0x80()
Calling initcall 0x000000000077a0c0: p_up_rup_up_7up_dup_+0x0/0x100()
Calling initcall 0x000000000077a1c0: p_siWvdestroyup_fspup_up_+0x0/0x80()
Calling initcall 0x000000000077a2e0: p_siW6up_up_2+0x0/0x40()
Calling initcall 0x000000000077a800: p_siWup_up_up_shandler+0x0/0x80()
Calling initcall 0x000000000077a8a0: p_siWup_destroyup_9+0x0/0x60()
Calling initcall 0x000000000077ab20: p_nup_+0x0/0x40()
Calling initcall 0x000000000077ab60: p_siWup_up_up_9+0x0/0x60()
Calling initcall 0x000000000077ac80: p_siWup_unregisterup_handler+0x0/0x20()
Calling initcall 0x000000000077acc0: p_siW6si4up_up_9+0x0/0x60()
Calling initcall 0x000000000077ad20: p_siW4move_llup_up_up_up_9+0x0/0x60()
Calling initcall 0x000000000077ad80: p_siWup_up_handler+0x0/0x140()
Calling initcall 0x000000000077b780: p_siWup_up_6+0x0/0x40()
Calling initcall 0x000000000077b7c0: p_siWup_up_up_9+0x0/0x60()
Calling initcall 0x000000000077bcc0: p_siWgsrup_handler+0x0/0xa0()
Calling initcall 0x000000000077bd60: up_up_up_+0x0/0x40()
Calling initcall 0x000000000077bf80: p_siW6hynhandler+0x0/0x100()
Calling initcall 0x000000000077c080: p_siW1up_xfrm_policup_T+0x0/0x40()
Initializing Cryptographic API
Calling initcall 0x000000000077c100: p_up_+0x0/0x20()
Calling initcall 0x000000000077c120: p_up_+0x0/0x20()
Calling initcall 0x000000000077c140: p_up_+0x0/0x60()
Calling initcall 0x000000000077c1a0: p_up_+0x0/0x20()
Calling initcall 0x000000000077cac0: p_aup_up_4t4up_2+0x0/0x140()
Calling initcall 0x000000000077cca0: p_up_up_up_up_+0x0/0x1e0()
Console: switching to mono PROM 80x34
Calling initcall 0x000000000077d0e0: p_up_up_up_up_+0x0/0x20()
Calling initcall 0x000000000077d7a0: p__ppup_up_+0x0/0x80()
Calling initcall 0x000000000077d820: p__pup_eup_up_+0x0/0x40()
Calling initcall 0x000000000077db20: p_ouup_ynup_+0x0/0x60()
Calling initcall 0x000000000077e8e0: p_oup_4up_3up_up_+0x0/0x40()
SunZilog: 2 chips.
zs2 at 0x000001fff8904004 (irq = 12,b9) is a SunZilog
zs3 at 0x000001fff8904000 (irq = 12,b9) is a SunZilog
ttyS0 at MMIO 0x0 (irq = 7956000) is a SunZilog
ttyS1 at MMIO 0x0 (irq = 7956000) is a SunZilog
Console: ttyS0 (SunZilog zs0)
Calling initcall 0x000000000077eb20: p_up_up_6do_cyn1up_up_sup_+0x0/0x80()
Calling initcall 0x0000000000595040: p_2up_up_up_efs3up_up_tup_up_+0x0/0x20()
Calling initcall 0x000000000077ee60: p_up_7xup_+0x0/0x320()
loop: loaded (max 8 devices)
Calling initcall 0x000000000077f1c0: p_up_up_up_+0x0/0x240()
Using deadline io scheduler
nbd: registered device at major 43
Calling initcall 0x000000000077fde0: ut_0up_up_up_ktfswup_2+0x0/0x40()
sunhme.c:v2.02 24/Aug/2003 David S. Miller (davem@redhat.com)
eth0: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:89:ed:b7 
Calling initcall 0x0000000000780320: p_up_up_up_a1ynwup_2+0x0/0x160()
Calling initcall 0x0000000000780d40: p_82up_wup_2+0x0/0xc0()
Calling initcall 0x00000000007813c0: p_up_up_up_up_wup_2+0x0/0xc0()
Calling initcall 0x0000000000781600: p_up_up_7up_up_up_sup_+0x0/0x60()
Calling initcall 0x0000000000782820: p_siWput_49up_1up_fsup__p+0x0/0xe0()
esp0: IRQ 7,db SCSI ID 7 Clk 40MHz CCYC=25000 CCF=8 TOut 167 NCR53C9XF(espfast)
ESP: Total of 1 ESP hosts found, 1 actually in use.
scsi0 : Sparc ESP366-HME
  Vendor: SEAGATE   Model: SX118202LS        Rev: B808
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: SX118202LS        Rev: B808
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: SX118202LS        Rev: B808
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: SX118202LS        Rev: B808
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: XM5701TASUN12XCD  Rev: 2395
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: SX118202LS        Rev: B807
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: SX118202LS        Rev: B807
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: SX118202LS        Rev: B807
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: SX118202LS        Rev: B807
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: SX118202LS        Rev: B807
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: SX118202LS        Rev: B808
  Type:   Direct-Access                      ANSI SCSI revision: 02
Calling initcall 0x0000000000782aa0: p_siWup_+0x0/0x100()
st: Version 20040403, fixed bufsize 32768, s/g segs 256
Calling initcall 0x0000000000782ba0: p_siW9up_+0x0/0x60()
esp0: target 0 [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
SCSI device sda: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sda: drive cache: write through
 sda: unknown partition table
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
esp0: target 1 [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
SCSI device sdb: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdb: drive cache: write through
 sdb: unknown partition table
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
esp0: target 2 [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
SCSI device sdc: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdc: drive cache: write through
 sdc: unknown partition table
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
esp0: target 3 [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
SCSI device sdd: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdd: drive cache: write through
 sdd: unknown partition table
Attached scsi disk sdd at scsi0, channel 0, id 3, lun 0
esp0: target 10 [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
SCSI device sde: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sde: drive cache: write through
 sde: unknown partition table
Attached scsi disk sde at scsi0, channel 0, id 10, lun 0
esp0: target 11 [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
SCSI device sdf: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdf: drive cache: write through
 sdf: unknown partition table
Attached scsi disk sdf at scsi0, channel 0, id 11, lun 0
esp0: target 12 [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
SCSI device sdg: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdg: drive cache: write through
 sdg: unknown partition table
Attached scsi disk sdg at scsi0, channel 0, id 12, lun 0
esp0: target 13 [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
SCSI device sdh: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdh: drive cache: write through
 sdh: unknown partition table
Attached scsi disk sdh at scsi0, channel 0, id 13, lun 0
esp0: target 14 [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
SCSI device sdi: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdi: drive cache: write through
 sdi: unknown partition table
Attached scsi disk sdi at scsi0, channel 0, id 14, lun 0
esp0: target 15 [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
SCSI device sdj: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdj: drive cache: write through
 sdj: unknown partition table
Attached scsi disk sdj at scsi0, channel 0, id 15, lun 0
Calling initcall 0x0000000000782c00: p_siW9up_+0x0/0x40()
esp0: target 6 asynchronous
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0
Calling initcall 0x0000000000782c40: p_siW93+0x0/0xe0()
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 1, lun 0,  type 0
Attached scsi generic sg2 at scsi0, channel 0, id 2, lun 0,  type 0
Attached scsi generic sg3 at scsi0, channel 0, id 3, lun 0,  type 0
Attached scsi generic sg4 at scsi0, channel 0, id 6, lun 0,  type 5
Attached scsi generic sg5 at scsi0, channel 0, id 10, lun 0,  type 0
Attached scsi generic sg6 at scsi0, channel 0, id 11, lun 0,  type 0
Attached scsi generic sg7 at scsi0, channel 0, id 12, lun 0,  type 0
Attached scsi generic sg8 at scsi0, channel 0, id 13, lun 0,  type 0
Attached scsi generic sg9 at scsi0, channel 0, id 14, lun 0,  type 0
Attached scsi generic sg10 at scsi0, channel 0, id 15, lun 0,  type 0
Calling initcall 0x0000000000782d20: p_Y7up_up_+0x0/0x20()
Calling initcall 0x0000000000783ac0: p_up_up_up_up_up_+0x0/0x140()
Calling initcall 0x0000000000783c00: p_gsrup_up_+0x0/0xa0()
Calling initcall 0x0000000000783ca0: p_up_up_oup_up_+0x0/0x60()
Calling initcall 0x0000000000783ea0: p_up_5up_up_up_+0x0/0x20()
Calling initcall 0x0000000000783ec0: p_up_9up_res9ynup_+0x0/0xc0()
Calling initcall 0x0000000000783f80: p_si2cup_up_+0x0/0x20()
md: linear personality registered as nr 1
Calling initcall 0x0000000000783fa0: p_0up_up_up_up_+0x0/0x20()
md: raid0 personality registered as nr 2
Calling initcall 0x0000000000783fc0: p_04up_up_+0x0/0x20()
md: raid1 personality registered as nr 3
Calling initcall 0x0000000000783fe0: p_0up_resourceup_up_+0x0/0x20()
md: raid5 personality registered as nr 4
Calling initcall 0x00000000005e27c0: p_t4up_up_up_ynup_eup_z+0x0/0x100()
raid5: measuring checksumming speed
   VIS       :   136.000 MB/sec
raid5: using function: VIS (136.000 MB/sec)
Calling initcall 0x0000000000784000: p_0up_up_up_up_+0x0/0x40()
raid6: int64x1    164 MB/s
raid6: int64x2    273 MB/s
raid6: int64x4    277 MB/s
raid6: int64x8    167 MB/s
raid6: using algorithm int64x4 (277 MB/s)
md: raid6 personality registered as nr 8
Calling initcall 0x0000000000784280: p_6resup_lup_up_up_up_up_+0x0/0x20()
md: multipath personality registered as nr 7
Calling initcall 0x00000000007842a0: p_6up_up_+0x0/0x120()
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Calling initcall 0x0000000000784480: p_up_up_up_+0x0/0xa0()
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
Calling initcall 0x00000000007847e0: p_up_do_fsup_ynup_+0x0/0x140()
Calling initcall 0x0000000000784da0: p_siWup_mup_+0x0/0x120()
Calling initcall 0x0000000000785d20: p_si2up_up_+0x0/0x240()
NET: Registered protocol family 2
IP: routing cache hash table of 32768 buckets, 512Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
Calling initcall 0x00000000007862c0: p_0up_up_up_up_+0x0/0x80()
Calling initcall 0x0000000000786340: p_9up_up_up_up_+0x0/0x80()
Calling initcall 0x00000000007863c0: up_Rup_up_up_up_+0x0/0x80()
Calling initcall 0x0000000000786440: up_4xup_+0x0/0x160()
Calling initcall 0x0000000000788960: p_0up_fso4up_up_up_+0x0/0xa0()
NET: Registered protocol family 1
Calling initcall 0x0000000000788a00: p_up_j2up_up_+0x0/0x60()
NET: Registered protocol family 17
Calling initcall 0x0000000000788a60: up__bup_up_up_up_up_up_+0x0/0x60()
NET: Registered protocol family 15
Calling initcall 0x0000000000788ac0: p_siW9oup_up_1+0x0/0x80()
Calling initcall 0x0000000000788b40: p_siWup_up_1_bup_up_9+0x0/0x60()
Calling initcall 0x0000000000788ba0: p_siW5_pup__p7sup_up_resup_+0x0/0x40()
Calling initcall 0x000000000060a300: p_up_up_up_aup_up_up__b2up_+0x0/0x60()
Calling initcall 0x00000000007880c0: x0resprom_Lup_3+0x0/0x320()
Sending DHCP requests .., OK
IP-Config: Got DHCP answer from 192.168.1.1, my address is 192.168.1.16
IP-Config: Complete:
      device=eth0, addr=192.168.1.16, mask=255.255.255.0, gw=192.168.1.1<6>eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.
,
     host=analyticity, domain=holomorphy.com, nis-domain=(none),
     bootserver=192.168.1.1, rootserver=192.168.1.1, rootpath=/mnt/f/e3k/debian
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Looking up port of RPC 100003/2 on 192.168.1.1
Looking up port of RPC 100005/1 on 192.168.1.1
VFS: Mounted root (nfs filesystem) readonly.
nfs warning: mount version older than kernel
