Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269937AbRHNAUw>; Mon, 13 Aug 2001 20:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269942AbRHNAUp>; Mon, 13 Aug 2001 20:20:45 -0400
Received: from 200-221-84-35.dsl-sp.uol.com.br ([200.221.84.35]:21258 "HELO
	dumont.rtb.ath.cx") by vger.kernel.org with SMTP id <S269937AbRHNAUc>;
	Mon, 13 Aug 2001 20:20:32 -0400
Date: Mon, 13 Aug 2001 21:20:31 -0300
From: =?us-ascii?Q?Rog=E9rio?= Brito <linuxsup@ig.com.br>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] Oopsen with 2.2.19
Message-ID: <20010813212031.A3106@iname.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


	The following is a (modified version of a) message that I sent
	yesterday, but that haven't reached the list for some
	reason. If it appears duplicated, then, please, I apologize.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Dear People,

	I have a friend with a computer running a vanilla Linux 2.2.19
	that is a bit unstable nowadays.

	It is a mailserver running qmail, bind and some other (light)
	services (almost always with a 0.0 load) and it was rock solid
	until some weeks ago, when it started hanging and being
	unstable with kernel panics. According to my friend, it is now
	hanging everyday.

	I went there and saw an old log with an Oops on it and got to
	grab everything I could think of that could be helpful,
	including a decoded Oops.

	I suspect that the problem may have something to do with the
	SCSI interface, since I've tried to configure a kernel 2.2.19
	with the same interface/driver on a customer and it spilled
	some scary messages, even though kernel 2.2.18 runs rock solid
	without any problems. These two problems may be related
	somehow.

	Getting back to the first (and more critical computer), here
	is every piece of information that I have now (but I may get
	further information after Thursday, if necessary).

	Attached to this message are the results that I have.
	Unfortunately, I don't have the config options used to compile
	the kernel. Are they strictly necessary? If so, I think that I
	can get them, but I'm not sure.

	Also I guess that the chain of 3 Oopsen that are shown above
	may be just one real oops and the others be a consequence of
	the first one.

	Do the pre-2.2.20 kernels correct this or should I give Alan
	more details about this?

	Please, help me. Any help is very much appreciated.


	Thank you very much in advance, Roger...

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito -- Treinamento e Consultoria Especializados em Unix
  e-mail: linuxsup@ig.com.br -- Homepage: www.geocities.com/rtbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.txt"
Content-Transfer-Encoding: 8bit

Linux version 2.2.19-1scsi (wilhelm@ns1.nlk.com.br) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #3 sáb abr 21 16:01:57 BRT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000a0000 @ 00000000 (usable)
 BIOS-e820: 07eec000 @ 00100000 (usable)
Detected 701597 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1399.19 BogoMIPS
Memory: 128272k/130992k available (792k kernel code, 412k reserved, 1480k data, 36k init)
Dentry hash table entries: 16384 (order 5, 128k)
Buffer cache hash table entries: 131072 (order 7, 512k)
Page cache hash table entries: 32768 (order 5, 128k)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
256K L2 cache (8 way)
CPU: L2 Cache: 256K
CPU: Intel Pentium III (Coppermine) stepping 03
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
PCI: PCI BIOS revision 2.10 entry at 0xf08f0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 131072 bhash 65536)
Starting kswapd v 1.5 
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.09
(scsi0) <Adaptec AHA-294X Ultra SCSI host adapter> found at PCI 0/17/0
(scsi0) Wide Channel, SCSI ID=7, 16/255 SCBs
(scsi0) Cables present (Int-50 NO, Int-68 YES, Ext-68 NO)
(scsi0) Downloading sequencer code... 436 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.33/3.2.4
       <Adaptec AHA-294X Ultra SCSI host adapter>
scsi : 1 host.
  Vendor: QUANTUM   Model: ATLAS_V__9_WLS    Rev: 0230
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sda at scsi0, channel 0, id 6, lun 0
(scsi0:0:6:2) Synchronous at 40.0 Mbyte/sec, offset 8.
scsi : detected 1 SCSI disk total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 17930694 [8755 MB] [8.8 GB]
Partition check:
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 36k freed
Adding Swap: 265064k swap-space (priority -1)
rtl8139.c:v1.07 5/6/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/rtl8139.html
eth0: RealTek RTL8139 Fast Ethernet at 0xb800, IRQ 10, 00:48:54:8a:c7:c2.
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="proc-cpuinfo.txt"

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 3
cpu MHz		: 701.597
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
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr xmm
bogomips	: 1399.19


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="proc-modules.txt"

serial                 18580   1 (autoclean)
rtl8139                12420   1 (autoclean)

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="proc-version.txt"
Content-Transfer-Encoding: 8bit

Linux version 2.2.19-1scsi (wilhelm@ns1.nlk.com.br) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #3 sáb abr 21 16:01:57 BRT 2001

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="proc-scsi-scsi.txt"

Attached devices: 
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: QUANTUM  Model: ATLAS_V__9_WLS   Rev: 0230
  Type:   Direct-Access                    ANSI SCSI revision: 03

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="proc-scsi-aic7xxx-0.txt"

Adaptec AIC7xxx driver version: 5.1.33/3.2.4
Compile Options:
  TCQ Enabled By Default : Enabled
  AIC7XXX_PROC_STATS     : Disabled
  AIC7XXX_RESET_DELAY    : 5

Adapter Configuration:
           SCSI Adapter: Adaptec AHA-294X Ultra SCSI host adapter
                           Ultra Wide Controller at PCI 0/17/0
    PCI MMAPed I/O Base: 0xf3000000
 Adapter SEEPROM Config: SEEPROM found and used.
      Adaptec SCSI BIOS: Enabled
                    IRQ: 11
                   SCBs: Active 0, Max Active 24,
                         Allocated 30, HW 16, Page 255
             Interrupts: 261647
      BIOS Control Word: 0x19a6
   Adapter Control Word: 0x005f
   Extended Translation: Enabled
Disconnect Enable Flags: 0xffff
     Ultra Enable Flags: 0x0040
 Tag Queue Enable Flags: 0x0040
Ordered Queue Tag Flags: 0x0040
Default Tag Queue Depth: 24
    Tagged Queue By Device array for aic7xxx host instance 0:
      {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
    Actual queue depth per device for aic7xxx host instance 0:
      {1,1,1,1,1,1,24,1,1,1,1,1,1,1,1,1}

Statistics:

(scsi0:0:6:0)
  Device using Wide/Sync transfers at 40.0 MByte/sec, offset 8
  Transinfo settings: current(12/8/1/0), goal(12/8/1/0), user(12/15/1/0)
  Total transfers 261579 (58100 reads and 203479 writes)



--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops2.txt"

Unable to handle kernel NULL pointer dereference at virtual address 00000066 
current->tss.cr3 = 00e05000, %cr3 = 00e05000 
*pde = 00000000 
Oops: 0000 
CPU:    0 
EIP:    0010:[kmalloc+81/348] 
EFLAGS: 00010012 
eax: c1798fc0   ebx: c1798fc0   ecx: 00000066   edx: 00000013 
esi: c7feb080   edi: c01aa7a3   ebp: 00000282   esp: c0387c8c 
ds: 0018   es: 0018   ss: 0018 
Process qmail-smtpd (pid: 22803, process nr: 27, stackpage=c0387000) 
Stack: c01aa7a3 c7f98ee0 c0132ce9 00000013 00000015 c01cc578 fffffff8 c0386000  
       c0387e60 c7f98da0 c3193e60 c5a8e660 c0150111 c3193e60 bfffff52 00000004  
       00000001 c01503de 00000000 c01e4d00 c01e4120 c1777ea0 0001ff52 c7f98da0  
Call Trace: [cprt+1347/15717] [load_elf_binary+721/3492] [ip_output+133/168] [ip_queue_xmit+682/868] [do_generic_file_read+1492/1504] [cprt+1344/15717] [read_exec+194/316]  
       [read_exec+303/316] [search_binary_handler+71/288] [do_execve+406/548] [do_execve+440/548] [sys_execve+47/88] [system_call+52/56]  
Code: 8b 01 89 03 85 c0 74 2b 8b 7b 04 85 ff 75 10 89 19 89 c8 2b  
Unable to handle kernel NULL pointer dereference at virtual address 00000066 
current->tss.cr3 = 00e05000, %cr3 = 00e05000 
*pde = 00000000 
Oops: 0000 
CPU:    0 
EIP:    0010:[kmalloc+81/348] 
EFLAGS: 00010006 
eax: c1798fc0   ebx: c1798fc0   ecx: 00000066   edx: c0341ce0 
esi: c7feb080   edi: 00000008   ebp: 00000282   esp: c4507f80 
ds: 0018   es: 0018   ss: 0018 
Process tcpserver (pid: 22804, process nr: 79, stackpage=c4507000) 
Stack: 00000008 bffffcfc c012e7c8 00000008 00000015 c4506000 00000bcb bffffd5c  
       bffffcfc 00000008 c010e5e4 bffffd38 c4506000 c39eb000 c39eb000 fffffff4  
       c010904c bffffd5c 00000001 00000bcb 00000bcb bffffd5c bffffcfc 000000a8  
Call Trace: [sys_poll+180/340] [do_page_fault+0/944] [system_call+52/56]  
Code: 8b 01 89 03 85 c0 74 2b 8b 7b 04 85 ff 75 10 89 19 89 c8 2b  
Unable to handle kernel NULL pointer dereference at virtual address 00000066 
current->tss.cr3 = 00e05000, %cr3 = 00e05000 
*pde = 00000000 
Oops: 0000 
CPU:    0 
EIP:    0010:[kmalloc+81/348] 
EFLAGS: 00010006 
eax: c1798fc0   ebx: c1798fc0   ecx: 00000066   edx: 00000013 
esi: c7feb080   edi: c01aa7a3   ebp: 00000282   esp: c4507c8c 
ds: 0018   es: 0018   ss: 0018 
Process qmail-local (pid: 22809, process nr: 79, stackpage=c4507000) 
Stack: c01aa7a3 c01e4a40 c0132ce9 00000013 00000015 c01cc578 fffffff8 c4506000  
       c4507e60 c7cd469c 00000000 c7cd46dc c2c8f488 c01464ba bffffebd 00000001  
       0000000d c014655f 00000000 000003f5 0043895c c80295e5 0001febd c78945c0  
Call Trace: [cprt+1347/15717] [load_elf_binary+721/3492] [kfree_skbmem+50/64] [__kfree_skb+151/160] [rtl8139:rtl8139_probe+5521/8844] [do_generic_file_read+1492/1504] [cprt+1344/15717]  

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops2decoded.txt"

ksymoops 2.3.3 on i686 2.2.19-1scsi.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.19-1scsi/ (default)
     -m /boot/System.map-2.2.19-1scsi (specified)

Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 00000066 
current->tss.cr3 = 00e05000, %cr3 = 00e05000 
*pde = 00000000 
Oops: 0000 
CPU:    0 
EIP:    0010:[kmalloc+81/348] 
EFLAGS: 00010012 
eax: c1798fc0   ebx: c1798fc0   ecx: 00000066   edx: 00000013 
esi: c7feb080   edi: c01aa7a3   ebp: 00000282   esp: c0387c8c 
ds: 0018   es: 0018   ss: 0018 
Process qmail-smtpd (pid: 22803, process nr: 27, stackpage=c0387000) 
Stack: c01aa7a3 c7f98ee0 c0132ce9 00000013 00000015 c01cc578 fffffff8 c0386000  
       c0387e60 c7f98da0 c3193e60 c5a8e660 c0150111 c3193e60 bfffff52 00000004  
       00000001 c01503de 00000000 c01e4d00 c01e4120 c1777ea0 0001ff52 c7f98da0  
Call Trace: [cprt+1347/15717] [load_elf_binary+721/3492] [ip_output+133/168] [ip_queue_xmit+682/868] [do_generic_file_read+1492/1504] [cprt+1344/15717] [read_exec+194/316]  
Code: 8b 01 89 03 85 c0 74 2b 8b 7b 04 85 ff 75 10 89 19 89 c8 2b  
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 01                     mov    (%ecx),%eax
Code;  00000002 Before first symbol
   2:   89 03                     mov    %eax,(%ebx)
Code;  00000004 Before first symbol
   4:   85 c0                     test   %eax,%eax
Code;  00000006 Before first symbol
   6:   74 2b                     je     33 <_EIP+0x33> 00000033 Before first symbol
Code;  00000008 Before first symbol
   8:   8b 7b 04                  mov    0x4(%ebx),%edi
Code;  0000000b Before first symbol
   b:   85 ff                     test   %edi,%edi
Code;  0000000d Before first symbol
   d:   75 10                     jne    1f <_EIP+0x1f> 0000001f Before first symbol
Code;  0000000f Before first symbol
   f:   89 19                     mov    %ebx,(%ecx)
Code;  00000011 Before first symbol
  11:   89 c8                     mov    %ecx,%eax
Code;  00000013 Before first symbol
  13:   2b 00                     sub    (%eax),%eax

Unable to handle kernel NULL pointer dereference at virtual address 00000066 
current->tss.cr3 = 00e05000, %cr3 = 00e05000 
*pde = 00000000 
Oops: 0000 
CPU:    0 
EIP:    0010:[kmalloc+81/348] 
EFLAGS: 00010006 
eax: c1798fc0   ebx: c1798fc0   ecx: 00000066   edx: c0341ce0 
esi: c7feb080   edi: 00000008   ebp: 00000282   esp: c4507f80 
ds: 0018   es: 0018   ss: 0018 
Process tcpserver (pid: 22804, process nr: 79, stackpage=c4507000) 
Stack: 00000008 bffffcfc c012e7c8 00000008 00000015 c4506000 00000bcb bffffd5c  
       bffffcfc 00000008 c010e5e4 bffffd38 c4506000 c39eb000 c39eb000 fffffff4  
       c010904c bffffd5c 00000001 00000bcb 00000bcb bffffd5c bffffcfc 000000a8  
Call Trace: [sys_poll+180/340] [do_page_fault+0/944] [system_call+52/56]  
Code: 8b 01 89 03 85 c0 74 2b 8b 7b 04 85 ff 75 10 89 19 89 c8 2b  

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 01                     mov    (%ecx),%eax
Code;  00000002 Before first symbol
   2:   89 03                     mov    %eax,(%ebx)
Code;  00000004 Before first symbol
   4:   85 c0                     test   %eax,%eax
Code;  00000006 Before first symbol
   6:   74 2b                     je     33 <_EIP+0x33> 00000033 Before first symbol
Code;  00000008 Before first symbol
   8:   8b 7b 04                  mov    0x4(%ebx),%edi
Code;  0000000b Before first symbol
   b:   85 ff                     test   %edi,%edi
Code;  0000000d Before first symbol
   d:   75 10                     jne    1f <_EIP+0x1f> 0000001f Before first symbol
Code;  0000000f Before first symbol
   f:   89 19                     mov    %ebx,(%ecx)
Code;  00000011 Before first symbol
  11:   89 c8                     mov    %ecx,%eax
Code;  00000013 Before first symbol
  13:   2b 00                     sub    (%eax),%eax

Unable to handle kernel NULL pointer dereference at virtual address 00000066 
current->tss.cr3 = 00e05000, %cr3 = 00e05000 
*pde = 00000000 
Oops: 0000 
CPU:    0 
EIP:    0010:[kmalloc+81/348] 
EFLAGS: 00010006 
eax: c1798fc0   ebx: c1798fc0   ecx: 00000066   edx: 00000013 
esi: c7feb080   edi: c01aa7a3   ebp: 00000282   esp: c4507c8c 
ds: 0018   es: 0018   ss: 0018 
Process qmail-local (pid: 22809, process nr: 79, stackpage=c4507000) 
Stack: c01aa7a3 c01e4a40 c0132ce9 00000013 00000015 c01cc578 fffffff8 c4506000  
       c4507e60 c7cd469c 00000000 c7cd46dc c2c8f488 c01464ba bffffebd 00000001  
       0000000d c014655f 00000000 000003f5 0043895c c80295e5 0001febd c78945c0  
Call Trace: [cprt+1347/15717] [load_elf_binary+721/3492] [kfree_skbmem+50/64] [__kfree_skb+151/160] [rtl8139:rtl8139_probe+5521/8844] [do_generic_file_read+1492/1504] [cprt+1344/15717]  

1 warning issued.  Results may not be reliable.

--CE+1k2dSO48ffgeK--
