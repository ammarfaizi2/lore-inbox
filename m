Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132389AbRCZKRc>; Mon, 26 Mar 2001 05:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132406AbRCZKRX>; Mon, 26 Mar 2001 05:17:23 -0500
Received: from pool002.seabone.net ([195.22.194.162]:32012 "EHLO
	paperino.int-seabone.net") by vger.kernel.org with ESMTP
	id <S132389AbRCZKRM>; Mon, 26 Mar 2001 05:17:12 -0500
To: linux-kernel@vger.kernel.org
Subject: a 2.4.2 kernel oops...
Reply-To: Pierfrancesco Caci <p.caci@seabone.net>
From: Pierfrancesco Caci <p.caci@seabone.net>
Date: 26 Mar 2001 12:16:07 +0200
Message-ID: <87n1a83kew.fsf@paperino.int-seabone.net>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


*** please Cc to p.caci@seabone.net when replying ***

Hi, I sent a similar report a couple of weeks ago but got no
response. Can Someone Who Knows (TM) please have a look at it and tell
me what's wrong with this Olivetti Netstrada? It works with 2.2.18 but
all the 2.4.x kernels didn't work so far. I tried also changing
compile options, eliminating all that is not strictly necessary to
boot, but got the same error.

here is it:

Linux version 2.4.2 (root@paperino) (gcc version 2.95.3 20010219 (prerelease)) #1 Fri Mar 16 15:23:30 CET 2001
BIOS-provided physical RAM map:
 BIOS-e801: 000000000009f000 @ 0000000000000000 (usable)
 BIOS-e801: 0000000041505000 @ 0000000000100000 (usable)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
On node 0 totalpages: 229376
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=test ro root=802 BOOT_FILE=/vmlinuz.test console=ttyS0,9600
Initializing CPU#0
Detected 200.012 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 398.95 BogoMIPS
Memory: 899624k/917504k available (1320k kernel code, 17492k reserved, 450k data, 84k init, 0k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: Before vendor init, caps: 0000fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 8K, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0000fbff 00000000 00000000 00000000
CPU: After generic, caps: 0000fbff 00000000 00000000 00000000
CPU: Common caps: 0000fbff 00000000 00000000 00000000
CPU: Intel Pentium Pro stepping 09
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
general protection fault: 0000
CPU:    0
EIP:    0010:[<c013d013>]
EFLAGS: 00010246
eax: 00000000   ebx: ffffffff   ecx: 00000072   edx: c013cff4
esi: f7fbf000   edi: ffffffff   ebp: f7fbf000   esp: c1efff2c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c1eff000)
Stack: 00000000 c1ef70c0 c0123d59 ffffffff c1ef70c0 00000001 c1ef70c0 00000246 
       00000007 c02b5538 00000001 c0123e3f c1ef70c0 00000007 c1ef6200 c1ef6200 
       00000000 c013da82 c1ef70c0 00000007 c1ef6200 c01e5543 c1ef6200 00000001 
Call Trace: [<c0123d59>] [<c0123e3f>] [<c013da82>] [<c01e5543>] [<c012feac>] [<c0130432>] [<c0107007>] 
       [<c0107424>] 

Code: f3 ab 8d 93 90 00 00 00 c7 83 90 00 00 00 00 00 00 00 8d 83 
Kernel panic: Attempted to kill init!




CPU:    0
EIP:    0010:[<c013d013>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: ffffffff   ecx: 00000072   edx: c013cff4
esi: f7fbf000   edi: ffffffff   ebp: f7fbf000   esp: c1efff2c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c1eff000)
Stack: 00000000 c1ef70c0 c0123d59 ffffffff c1ef70c0 00000001 c1ef70c0 00000246 
       00000007 c02b5538 00000001 c0123e3f c1ef70c0 00000007 c1ef6200 c1ef6200 
       00000000 c013da82 c1ef70c0 00000007 c1ef6200 c01e5543 c1ef6200 00000001 
Call Trace: [<c0123d59>] [<c0123e3f>] [<c013da82>] [<c01e5543>] [<c012feac>] [<c0130432>] [<c0107007>] 
       [<c0107424>] 
Code: f3 ab 8d 93 90 00 00 00 c7 83 90 00 00 00 00 00 00 00 8d 83 

>>EIP; c013d013 <init_once+1f/d0>   <=====
Trace; c0123d59 <kmem_cache_grow+169/208>
Trace; c0123e3f <kmem_cache_alloc+47/54>
Trace; c013da82 <get_empty_inode+e/84>
Trace; c01e5543 <sockfs_read_super+b/a4>
Trace; c012feac <read_super+100/170>
Trace; c0130432 <kern_mount+2e/80>
Trace; c0107007 <init+7/110>
Trace; c0107424 <kernel_thread+28/38>
Code;  c013d013 <init_once+1f/d0>
00000000 <_EIP>:
Code;  c013d013 <init_once+1f/d0>   <=====
   0:   f3 ab                     repz stos %eax,%es:(%edi)   <=====
Code;  c013d015 <init_once+21/d0>
   2:   8d 93 90 00 00 00         lea    0x90(%ebx),%edx
Code;  c013d01b <init_once+27/d0>
   8:   c7 83 90 00 00 00 00      movl   $0x0,0x90(%ebx)
Code;  c013d022 <init_once+2e/d0>
   f:   00 00 00 
Code;  c013d025 <init_once+31/d0>
  12:   8d 83 00 00 00 00         lea    0x0(%ebx),%eax

Kernel panic: Attempted to kill init!

970 warnings issued.  Results may not be reliable.
(this is because I ran it on a different machine, the system.map was
the one from the crashing kernel, though)

Also, I just realized that this stupid bios tells the kernel to have a
lot of memory, while it only has 128 M (see the line just at the
beginning of the boot output).

here's what's inside this machine:


root@mirror:~ # lspci -v
00:03.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 [Tulip Pass 3] (rev 11)
        Flags: bus master, medium devsel, latency 96, IRQ 11
        I/O ports at ec00
        Memory at df000000 (32-bit, non-prefetchable)
        Expansion ROM at de000000 [disabled]

00:05.0 Non-VGA unclassified device: Intel Corporation 82375EB (rev 15)
        Flags: bus master, medium devsel, latency 248

00:14.0 RAM memory: Intel Corporation 450KX/GX [Orion] - 82453KX/GX Memory controller (rev 05)
        Flags: fast devsel

00:19.0 Host bridge: Intel Corporation 450KX/GX [Orion] - 82454KX/GX PCI bridge (rev 06)
        Flags: bus master, medium devsel, latency 96

00:1a.0 Host bridge: Intel Corporation 450KX/GX [Orion] - 82454KX/GX PCI bridge (rev 06)
        Flags: bus master, medium devsel, latency 96

01:00.0 SCSI storage controller: Adaptec AIC-7880U (rev 01)
        Subsystem: Adaptec: Unknown device 7880
        Flags: bus master, medium devsel, latency 96, IRQ 15
        I/O ports at d400
        Memory at dd000000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 1


I'm willing to do some tests, time permitting. 

Pf



-- 

-------------------------------------------------------------------------------
 Pierfrancesco Caci |            System Administrator @ seabone.net
 p.caci@seabone.net |     Telecom Italia S.p.A. - International Operations
     Linux paperino 2.4.2 #2 Thu Mar 8 15:21:54 CET 2001 i686 unknown
