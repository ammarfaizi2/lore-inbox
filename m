Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265904AbTFSTHZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 15:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265908AbTFSTHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 15:07:24 -0400
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:10745 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S265904AbTFSTHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 15:07:10 -0400
Date: Thu, 19 Jun 2003 20:21:43 +0100
From: Dave Bentham <dave.bentham@ntlworld.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.21 panic on CDRW Mount
Message-Id: <20030619202143.132f2182.dave@telekon>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Thu__19_Jun_2003_20:21:43_+0100_08238e60"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Thu__19_Jun_2003_20:21:43_+0100_08238e60
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,

I've now managed to capture the 'panic' output of 2.4.21.

I was running 2.4.20 for quite some time on a Mandrake 9.0 base on a
Pentium IV 1.5MHz PC. When 2.4.21 came out I patched the source and
upgraded to it as I usually do for kernel upgrades.

However, mounting the CDRW makes it all go crappy and it dies. See
attached panic output.

The command was issued on the PC's own attached console, but the
output's captured on an attached serial console (command was 'mount
/mnt/cdrom2' entered in BASH without starting X, etc).

Thanks

Dave

-- 
A computer without Microsoft is like chocolate cake without mustard.


--Multipart_Thu__19_Jun_2003_20:21:43_+0100_08238e60
Content-Type: text/plain;
 name="TelekonRunToPanic.txt"
Content-Disposition: attachment;
 filename="TelekonRunToPanic.txt"
Content-Transfer-Encoding: 7bit

LILO 22.3.2 boot:                 
Loading Linux_2.4.21................                                    
BIOS data check successful                          
Linux version 2.4.21 (root@telekon.davesnet) (gcc version 3.2 (Mandrake Linux 9.                                                                                
0 3.2-1mdk)) #50 Thu Jun 19 07:51:48 BST 2003                                             
BIOS-provided physical RAM map:                               
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)                                                        
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)                                                          
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)                                                          
 BIOS-e820: 0000000000100000 - 000000000fff00                                           
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)                                                          
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)                                                           
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)                                                          
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)                                                          
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)                                                          
255MB LOWMEM available.                       
On node 0 totalpages: 65520                           
zone(0): 4096 pages.                    
zone(1): 61424 pages.                     
zone(2): 0 pages.                 
Kernel command line: BOOT_IMAGE=Linux_2.4.21 ro root=303 devfs=mount hdd=ide-scs                                                                                
i console=tty0 console=ttyS0                          
ide_setup: hdd=ide-scsi                       
Initializing CPU#0                  
Detected 1498.113 MHz processor.                                
Console: colour VGA+ 80x25                          
Calibrating delay loop... 2988.44 BogoMIPS                                          
Memory: 256844k/262080k available (1266k kernel code, 4848k reserved, 462k data,                                                                                
 80k init, 0k highmem)                      
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)                                                               
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)                                                              
Mount cache hash table entries: 512 (order: 0, 4096 bytes)                                                          
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)                                                              
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)                                                             
CPU: Trace cache: 12K uops, L1 D cache: 8K                                          
CPU: L2 cache: 256K                   
CPU: Intel(R) Pentium(R) 4 CPU 1.50GHz stepping 02                                                  
Enabling fast FPU save and restore... done.                                           
Enabling unmasked SIMD FPU exception support... done.                                                     
Checking 'hlt' instruction... OK.                                 
POSIX conformance testing by UNIFIX                                   
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)                                                           
mtrr: detected mtrr type: Intel                               
PCI: PCI BIOS revision 2.10 entry at 0xfb190, last bus=2                                                        
PCI: Using configuration                        
PCI: Probing PCI hardware                         
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Bridge                                                         
PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0                                                 
Linux NET4.0 for Linux 2.4                          
Based upon Swansea University Computer Society NET3.039                                                       
Initializing RT netlink socket                              
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)                                                      
Starting kswapd               
Journalled Block Device driver loaded                                     
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)                                                             
devfs: boot_options: 0x1                        
pty: 256 Unix98 ptys configured                               
Serial driver version 5.05c (2001-07-08) w                                         
abled     
ttyS00 at 0x03f8 (irq = 4) is a 16550A                                      
ttyS01 at 0x02f8 (irq = 3) is a 16550A                                      
Floppy drive(s): fd0 is 1.44M                             
FDC 0 is a post-1991 82077                          
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize                                                                     
PPP generic driver version 2.4.2                                
PPP Deflate Compression module registered                                         
Linux agpgart interface v0.99 (c) Jeff Hartmann                                               
agpgart: Maximum main memory to use for agp memory: 203M                                                        
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4                                                           
ide: Assuming 33MHz system bus speed for PIO modes; override with i                                                                 
hda: ST340810A, ATA DISK drive                              
hdc: LITEON DVD-ROM LTD163, ATAPI CD/DVD-ROM drive                                                  
hdd: CW038D ATAPI CD-R/RW, ATAPI CD/DVD-ROM drive                                                 
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14                                   
ide1 at 0x170-0x177,0x376 on irq 15                                   
hda: attached ide-disk driver.                              
hda: host protected area => 1                             
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63                                                                 
hdc: attached ide-cdrom driver.                               
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache                                         
Uniform CD-ROM driver Revision: 3.12                                    
hdd: attached ide-scsi driver.                              
Partition check:                
 /dev/ide/host0/bus0/target0/                           
SCSI subsystem driver Revision: 1.00                                    
scsi0 : SCSI host adapter emulation for IDE ATAPI devices                                                         
  Vendor: CyberDrv  Model: CW038D CD-R/RW    Rev: 110C                                                      
  Type:   CD-ROM                             ANSI SCSI revision: 02                                                                   
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0                                                         
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray                                                             
NET4: Linux TCP/IP 1.0 for NET4.0                                 
IP Protocols: ICMP, UDP, TCP                            
IP: routing cache hash table of 2048 buckets, 16Kbytes                                                      
TCP: Hash tables configured (established 16384 bind 32768)                                                          
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.                                                   
kjournald starting.  Commit interval 5 seconds                                              
EXT3-fs: mounted filesystem with ordered data mode.                                                   
VFS: Mounted root (ext3 filesystem) readonly.                                             
Mounted devfs on /dev                     
Freeing unused kernel memory: 80k freed                                       
INIT: version 2.83 booting                          
Setting default font (lat0-16):  [  OK  ]                                         

                        Booting, please wait...                                               

                        Welcome to Mandrake Linux 9.0                                                     
                Press 'I' to enter interactive startup.                                                       
Running DevFs daemon [  OK  ]                             
Configuring kernel parameters:  [  OK  ]                                        
Setting clock  (utc): Thu Jun 19 16:59:51 BST 2003 [  OK  ]                                                           
Setting hostname telekon.davesnet:  [  OK  ]                                            
Initializing USB controller (usb-uhci):  [  OK  ]                                                 
Mount USB filesystem [  OK  ]                             
Loading USB printer [  OK  ]                            
Checking root filesystem                        
/dev/hda3: clean, 224767/2101152 files, 1419679/4194973 blocks                                                              
[  OK  ]        
Remounting root filesystem in read-write mode:  [  OK  ]                                                        
Activating swap partitions:  [  OK  ]                                     
Finding module dependencies:  [  OK  ]                                      
Checking filesystems                    
/dev/hda4: clean, 42024/3478784 files, 1412964/3476064 blocks                                                             
[  OK  ]        
Mounting local filesystems:  [  OK  ]                                     
Checking loopback filesystems[  OK  ]                                     
Mounting loopback filesystems:  [  OK  ]                                        
Loading keymap: uk [  OK  ]                           
Loading compose keys: compose.latin9.inc [  OK  ]                                                 
The BackSpace key sends: ^?[  OK  ]                                   
Turning on user and group quotas for local filesystems:  [  OK  ]                                                                 
Enabling swap space:  [  OK  ]                              
Building Window Manager Sessions [  OK  ]                                         
modprobe: modprobe: Can't locate module eth5                                            
modprobe: modprobe: Can't locate                               
modprobe: modprobe: Can't locate module eth7                                            
INIT: Entering runlevel: 3                          
Entering non-interactive startup                                
Starting iptables:  [  OK  ]                            
Setting network parameters:  [  OK  ]                                     
Bringing up loopback interface:  [  OK  ]                                         
Bringing up interface eth0:  [  OK  ]                                     
Bringing up interface eth1:  [  OK  ]                                     
Starting portmapper: [  OK  ]                             
Starting system logger: [  OK  ]                                
Starting kernel logger: [  OK  ]                                
Starting partmon:  [  OK  ]                           
Starting console mouse services: [  OK  ]                                         
Loading sound module (snd-card-0) modprobe: Can't locate module                                                             
[FAILED]        
Initializing random number generator:  [  OK  ]                                               
Starting X Font Server: [  OK  ]                                
Mounting other filesystems:  [  OK  ]                                     
Starting atd: [  OK  ]                      
Starting saslauthd[  OK  ]                          
Starting sshd:  [  OK  ]                        
Starting xinetd: [  OK  ]                         
Starting cups:  [  OK  ]                        
Starting automount:[  OK  ]                           
Loading keymap: uk [  OK  ]                           
Loading compose keys: compose.latin9.inc [  OK  ]                                                 
The BackSpace key sends: ^?[  OK  ]                                   
Starting sendmail: [  OK  ]                           
Starting sm-client: [  OK  ]                            
Starting numlock:  [  OK  ]                           
Checking internet connections to start                                       
Starting crond: [  OK  ]                        
Starting squid:  [  OK  ]                         
Starting Webmin [  OK  ]                        
Starting Fetchmail services: [  OK  ]                                     
Starting SMB services: [  OK  ]                               
Starting NMB services: [  OK  ]                               
Starting lisa:  [  OK  ]                        
Starting kheader:  [  OK  ]                           
Starting cups:  [  OK  ]                        
Running devfsd actions:  [  OK  ]                                 
Running Linuxconf hooks:  [  OK  ]                                  
alsactl: load_state:1121: No soundcards found...                                                

Mandrake Linux release 9.0 (dolphin) for i586                                             
Kernel 2.4.21 on an i686 / ttyS0                                
telekon.davesnet login: root                            
Password:         
Login incorrect               

login: Unable to handle kernel NULL pointer dereference at virtual address 00000                                                                                
000   
*pde = 00000000               
Oops: 0000          
CPU:    0         
EIP:    0010:[<00000000>]    Not tainted                                        
EFLAGS: 00010202                
eax: c02ecab4   ebx: c02ecca0   ecx: 00000000   edx: 00000170                                                             
esi: cf6f0d60   edi: c12cee80   ebp: cf223a8c   esp: cf223a64                                                             
ds: 0018   es: 0018   ss: 0018                              
Process mount (pid: 2255, stackpage=cf223000)                                             
Stack: c01d8054 c02ecca0 cf6f0d60 0000000c 00000000 000001f4 c12cee80 c02ecca0                                                                              
       00000040 00000000 cf223ac0 c01c21e2 c02ecca0 cf6f0d                                                         
       000001f4 c02ecca0 00000000 00000002 c02ecca0 cff3f260 cf237ea0 cf223ae4                                                                              
Call Trace:    [<c01d8054>] [<c01c21e2>] [<c01c235e>] [<c01c2a2f>] [<c01d8cd4>]                                                                               
  [<c01cd575>] [<c01d2dc0>] [<c01d2b30>] [<c01d4845>] [<c01d2b30>] [<c01d3d35>]                                                                               
  [<c01d3dc9>] [<c01cd6a5>] [<c01ccff0>] [<c01dac15>] [<c01dbe8b>] [<c01d9455>]                                                                               
  [<c01e2c2e>] [<c01e2ca2>] [<c013f45a>] [<c01d9bd8>] [<c01e236a>] [<c01e21c1>]                                                                               
  [<c013abdf>] [<c013f671>] [<c013f6ff>] [<c017d276>] [<c013e17c>] [<c013e583>]                                                                               
  [<c015064d>] [<c0150945>] [<c01507                                   

Code:  Bad EIP value.                     
 <7>IPT INPUT packet died: IN=eth1 OUT= MAC= SRC=80.5.242.41 DST=255.255.255.255                                                                                
 LEN=137 TOS=0x00 PREC=0x00 TTL=64 ID=0 DF PROTO=UDP SPT=631 DPT=631 LEN=117                                                                            
IPT INPUT packet died: IN=eth1 OUT= MAC= SRC=80.5.242.41 DST=255.255.255.255 LEN                                                                                
=149 TOS=0x00 PREC=0x00 TTL=64 ID=0 DF PROTO=UDP SPT=631 DPT=631 LEN=129                                                                        
Login timed out               
Mandrake Linux release 9.0 (dolphin) for i586                                             
Kernel 2.4.21 on an i686 / ttyS0                                
telekon.davesnet login: scsi : aborting command due to timeout : pid 6, scsi0, c                                                                                
hannel 0, id 0, lun 0 0x43 00 00 00 00 00 00 00 0c 40                                      
Kernel 2.4.21 
hdd: irq timeout: status=0xd0 { Busy }           
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00000000>]    Not tainted
EFLAGS: 00010203
eax: c02ecab4   ebx: c02ecca0   ecx: 00000000   edx: 00000170
esi: cf6f0d60   edi: c12cee80   ebp: c02b3e94   esp: c02b3e6c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02b3000)
Stack: c01d8054 c02ecca0 cf6f0d60 0000000c 00000000 000001f4 c12cee80 c02ecca0
       00000040 00000000 c02b3ec8 c01c21e2 c02ecca0 cf6f0d60 00000000 00000088
       000001f4 c02b3eec 00000000 00000018 c02ecca0 cff3f260 cf237ea0 c02b3eec
Call Trace:    [<c01d8054>] [<c01c21e2>] [<c01c235e>] [<c01c260c>] [<c01172a0>]
  [<c01c2520>] [<c0122a9b>] [<c01221f6>] [<c011eff2>] [<c011eee6>] [<c011ed16>]
  [<c010a9b0>] [<c0107250>] [<c010d038>] [<c0107250>] [<c0107273>] [<c0107302>]
  [<c0105000>]

Code:  Bad EIP value.
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

--Multipart_Thu__19_Jun_2003_20:21:43_+0100_08238e60--
