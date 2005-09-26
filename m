Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbVIZLwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbVIZLwD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 07:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbVIZLwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 07:52:03 -0400
Received: from [62.154.156.180] ([62.154.156.180]:41955 "EHLO
	mail-server.abas-projektierung.local") by vger.kernel.org with ESMTP
	id S1751352AbVIZLwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 07:52:01 -0400
Date: Mon, 26 Sep 2005 13:48:54 +0200
To: linux-kernel@vger.kernel.org
Subject: Kernel Panic RedHat Enterprise Ws 4
Content-Type: text/plain; charset=iso-8859-15; format=flowed
From: Johann Fock <jfock@abas-projektierung.de>
Organization: Abas Projektierung GmbH
MIME-Version: 1.0
Message-ID: <opsxpkfsbflmlk18@192.168.252.10>
User-Agent: Opera7.11/Win32 M2 build 2887
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hallo,
I Have a Problem wiht RedHat Enterprise 4 WS
Hardware Configuration: Controller
0   GDT8523RZ        [PCI 3/1]   C 0 1 4 5 10  2.28.07-R050
Disks:
SCSI-A 8   SEAGATE ST336607LC       160MB      0/0          0  N/A         
x
 x SCSI-A 9   SEAGATE ST373207LC       160MB      0/0          0  N/A       
  x
 x SCSI-A 10  SEAGATE ST373307LC       160MB      0/0          0  N/A       
  x
 x SCSI-A 11  SEAGATE ST373307LC       160MB      0/0          1  N/A       
  x
 x SCSI-B 0   SEAGATE ST336607LC       160MB      0/0          0  N/A       
  x
 x SCSI-B 1   SEAGATE ST373307LC       160MB      0/0          0  N/A       
  x
 x SCSI-B 2   SEAGATE ST373307LC       160MB      0/0          0  N/A       
  x
 x SCSI-B 3   SEAGATE ST373307LC       160MB      0/0          0  N/A       
  x
 CPU:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2393.312
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov 
pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 4718.59

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2393.312
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov 
pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 4767.74

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2393.312
cache size      : 512 KB
physical id     : 3
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov 
pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 4767.74

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2393.312
cache size      : 512 KB
physical id     : 3
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov 
pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 4767.74
Kernel Version :
Linux roco.abas.de 2.6.9-11.ELsmp #1 SMP Fri May 20 18:26:27 EDT 2005 i686 
i686
i386 GNU/Linux


Thats the panic-messages

Sep 23 18:59:42 roco kernel: kernel BUG at mm/prio_tree.c:528!
Sep 23 18:59:42 roco kernel: invalid operand: 0000 [#1]
Sep 23 18:59:42 roco kernel: SMP
Sep 23 18:59:42 roco kernel: Modules linked in: smbfs md5 ipv6 parport_pc 
lp par
port autofs4 i2c_dev i2c_core sunrpc ext3 jbd dm_mod button battery ac 
uhci_hcd
hw_random e1000 floppy st sg gdth aic7xxx sd_mod scsi_mod
Sep 23 18:59:42 roco kernel: CPU:    2
Sep 23 18:59:42 roco kernel: EIP:    0060:[<c01418b5>]    Not tainted VLI
Sep 23 18:59:42 roco kernel: EFLAGS: 00010216   (2.6.9-11.ELsmp)
Sep 23 18:59:42 roco kernel: EIP is at vma_prio_tree_add+0x36/0x95
Sep 23 18:59:42 roco kernel: eax: 000000bf   ebx: f4995964   ecx: 00000000  
 edx
: 00000658
Sep 23 18:59:42 roco kernel: esi: f6315334   edi: f76b82fc   ebp: eeeca5c0  
 esp
: d89aef3c
Sep 23 18:59:42 roco kernel: ds: 007b   es: 007b   ss: 0068
Sep 23 18:59:42 roco kernel: Process datmod (pid: 24460, 
threadinfo=d89ae000 tas
k=f6ee50b0)
Sep 23 18:59:42 roco kernel: Stack: f4995964 f64d7c80 c014a77a f4995964 
00100077
 00000000 f70a9280 c014b2ba
Sep 23 18:59:42 roco kernel:        eeeca5c0 eeeca5b8 00000659 00000001 
00000000
 f76b824c f64d7c80 00659000
Sep 23 18:59:42 roco kernel:        b5f57000 eeeca59c eeeca5c0 eeeca5b8 
f64d7c80
 f64d7cb0 d89ae000 f70a9280
Sep 23 18:59:42 roco kernel: Call Trace:
Sep 23 18:59:42 roco kernel:  [<c014a77a>] vma_link+0x9c/0xbc
Sep 23 18:59:42 roco kernel:  [<c014b2ba>] do_mmap_pgoff+0x50e/0x666
Sep 23 18:59:42 roco kernel:  [<c010b557>] sys_mmap2+0x7e/0xaf
Sep 23 18:59:42 roco kernel:  [<c02c7377>] syscall_call+0x7/0xb
Sep 23 18:59:42 roco kernel:  [<c02c007b>] unix_release_sock+0x15a/0x201
Sep 23 18:59:42 roco kernel: Code: c3 39 ca 74 08 0f 0b 0f 02 66 aa 2d c0 
8b 43
08 2b 43 04 c1 e8 0c 8d 54 02 ff 8b 46 08 2b 46 04 c1 e8 0c 8d 44 01 ff 39 
c2 74
 08 <0f> 0b 10 02 66 aa 2d c0 c7 43 34 00 00 00 00 83 7e 34 00 c7 43
Sep 23 18:59:42 roco kernel:  <0>Fatal exception: panic in 5 seconds

The System works for more then 3 month.

Please Help !!!!
Abas Projektierung GmbH


-

- 
