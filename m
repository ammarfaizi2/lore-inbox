Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbRBISqd>; Fri, 9 Feb 2001 13:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129566AbRBISqY>; Fri, 9 Feb 2001 13:46:24 -0500
Received: from hick.org ([209.242.124.241]:5637 "EHLO crazy.hick.org")
	by vger.kernel.org with ESMTP id <S129485AbRBISqK>;
	Fri, 9 Feb 2001 13:46:10 -0500
Date: Fri, 9 Feb 2001 12:45:56 -0600 (CST)
From: CHARLIE ROOT <root@crazy.hick.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1 oops.
Message-ID: <Pine.LNX.4.10.10102091231001.1012-200000@crazy.hick.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-221122180-2070317943-981744356=:1012"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---221122180-2070317943-981744356=:1012
Content-Type: TEXT/PLAIN; charset=US-ASCII

One-line Summary: Denied services on the machine.  Lack of responsiveness

Detailed Summary: Server remained responsive but did not provide service.
I was able to ping the machine and telnet to open ports but no data was
sent back on these open ports.  As far as current connections were
concerned, i was not able to break out of my current process but i was
able to send data (enter, etc).

Keywords: Kernel, memory

Kernel version: Linux version 2.4.1 (root@crazy.hick.org) (gcc version
2.95.2 20000220 (Debian GNU/Linux)) #1 Sat Feb 3 12:57:48 CST 2001
 
Trigger: unsure.

Environment:

	ver_linux output:

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux crazy.hick.org 2.4.1 #1 Sat Feb 3 12:57:48 CST 2001 i586 unknown
Kernel modules         2.1.85
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.9.5.0.16
Linux C Library        2.2.1
Dynamic linker         ldd (GNU libc) 2.2.1
Linux C++ Library      2.7.2
Procps                 2.0.2
Mount                  2.7l
Net-tools              2.01
Console-tools          0.2.1
Sh-utils               1.16
Modules Loaded


	CPU Information:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 350.807
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow
k6_mtrr
bogomips        : 699.59

	Module information:

	No modules.

	IO Ports and IO mem:

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
5000-50ff : VIA Technologies, Inc. VT82C586B ACPI
d000-dfff : PCI Bus #01
e000-e00f : VIA Technologies, Inc. Bus Master IDE
e400-e41f : VIA Technologies, Inc. UHCI USB
  e400-e41f : usb-uhci
e800-e87f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  e800-e87f : eth0

00000000-0009fbff : System RAM
0009fc00-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-05ffffff : System RAM
  00100000-002396b1 : Kernel code
  002396b2-002aa417 : Kernel data
e0000000-e3ffffff : VIA Technologies, Inc. VT82C597 [Apollo VP3]
e5000000-e500007f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
ffff0000-ffffffff : reserved


	PCI information:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev
04)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo
VP] (rev 47)
        Subsystem: VIA Technologies, Inc. MVP3 ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
06) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at e000 [size=16]

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 02)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at e400 [size=32]

00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:0a.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e800 [size=128]
        Region 1: Memory at e5000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at e4000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


	SCSI information:

	No SCSI drives.


	Other information:

	At this time I have no other specific information.  If more detail
is needed please contact me.  I've attached the ksymoops output as
well, although I'm not sure if I ran it correctly.  I've included the
syslog output as well as something strange that I noticed:

Feb  9 10:11:26 crazy kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000020
Feb  9 10:11:26 crazy kernel:  printing eip:
Feb  9 10:11:26 crazy kernel: c013ecec
Feb  9 10:11:26 crazy kernel: *pde = 00000000
Feb  9 10:11:26 crazy kernel: Oops: 0000
Feb  9 10:11:26 crazy kernel: CPU:    0
Feb  9 10:11:26 crazy kernel: EIP:    0010:[find_inode+28/72]
Feb  9 10:11:26 crazy kernel: EFLAGS: 00010217
Feb  9 10:11:26 crazy kernel: eax: 00000000   ebx: 00000000   ecx:
0000001a   edx: 0000003b
Feb  9 10:11:26 crazy kernel: esi: 00000000   edi: 00000000   ebp:
000e283b   esp: c548de88
Feb  9 10:11:26 crazy kernel: ds: 0018   es: 0018   ss: 0018
Feb  9 10:11:26 crazy kernel: Process cpp (pid: 16906, stackpage=c548d000)
Feb  9 10:11:26 crazy kernel: Stack: 000e283b c11e01d8 000e283b c5fcd600
c013f0b1 c5fcd600 000e283b c11e01d8
Feb  9 10:11:26 crazy kernel:        00000000 00000000 000e283b c146c960
c079fb80 c552e440 c014c213 c5fcd600
Feb  9 10:11:26 crazy kernel:        000e283b 00000000 00000000 fffffff4
c079fb80 c146c960 c270e4d4 c01361db
Feb  9 10:11:26 crazy kernel: Call Trace: [iget4+69/204]
[ext2_lookup+91/128] [real_lookup+83/196] [path_walk+1381/1964]
[open_namei+116/1408] [filp_open+51/84] [sys_open+56/180]
Feb  9 10:11:26 crazy kernel:        [system_call+51/64]
Feb  9 10:11:26 crazy kernel:
Feb  9 10:11:26 crazy kernel: Code: 39 6e 20 75 ef 8b 44 24 14 39 86 8c 00
00 00 75 e3 85 ff 74
Feb  9 10:13:11 crazy kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000020
Feb  9 10:13:11 crazy kernel:  printing eip:
Feb  9 10:13:11 crazy kernel: c013ecec
Feb  9 10:13:11 crazy kernel: *pde = 00000000
Feb  9 10:13:11 crazy kernel: Oops: 0000
Feb  9 10:13:11 crazy kernel: CPU:    0
Feb  9 10:13:11 crazy kernel: EIP:    0010:[find_inode+28/72]
Feb  9 10:13:11 crazy kernel: EFLAGS: 00010213
Feb  9 10:13:11 crazy kernel: eax: 00000000   ebx: 00000000   ecx:
0000001a   edx: 00000873
Feb  9 10:13:11 crazy kernel: esi: 00000000   edi: 00000000   ebp:
00001053   esp: c420dc24
Feb  9 10:13:11 crazy kernel: ds: 0018   es: 0018   ss: 0018
Feb  9 10:13:11 crazy kernel: Process bash (pid: 16961,
stackpage=c420d000)
Feb  9 10:13:11 crazy kernel: Stack: 00001053 c11e4398 00001053 c5fcd600
c013f0b1 c5fcd600 00001053 c11e4398
Feb  9 10:13:11 crazy kernel:        00000000 00000000 00001053 c3dc9bc0
c5fb09c0 c5ffd620 c014c213 c5fcd600
Feb  9 10:13:11 crazy kernel:        00001053 00000000 00000000 fffffff4
c5fb09c0 c3dc9bc0 c209ba48 c01361db
Feb  9 10:13:11 crazy kernel: Call Trace: [iget4+69/204]
[ext2_lookup+91/128] [real_lookup+83/196] [path_walk+1381/1964]
[file_read_actor+0/104] [open_exec+42/192] [load_elf_binary+611/2564]
Feb  9 10:13:11 crazy kernel:        [load_elf_binary+695/2564]
[load_elf_binary+0/2564] [find_proto+102/168] [fw_in+241/620]
[update_atime+68/84] [do_generic_file_read+1300/1312]
[__alloc_pages+219/720] [search_binary_handler+91/256]
Feb  9 10:13:11 crazy kernel:        [do_execve+405/488]
[sys_execve+47/96] [system_call+51/64]
Feb  9 10:13:11 crazy kernel:
Feb  9 10:13:11 crazy kernel: Code: 39 6e 20 75 ef 8b 44 24 14 39 86 8c 00
00 00 75 e3 85 ff 74
Feb  9 10:14:01 crazy kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000020
Feb  9 10:14:01 crazy kernel:  printing eip:
Feb  9 10:14:01 crazy kernel: c013ecec
Feb  9 10:14:01 crazy kernel: *pde = 00000000
Feb  9 10:14:01 crazy kernel: Oops: 0000
Feb  9 10:14:01 crazy kernel: CPU:    0
Feb  9 10:14:01 crazy kernel: EIP:    0010:[find_inode+28/72]
Feb  9 10:14:01 crazy kernel: EFLAGS: 00010217
Feb  9 10:14:01 crazy kernel: eax: 00000000   ebx: 00000000   ecx:
0000001a   edx: 0000003b
Feb  9 10:14:01 crazy kernel: esi: 00000000   edi: 00000000   ebp:
000f489b   esp: c456bebc
Feb  9 10:14:01 crazy kernel: ds: 0018   es: 0018   ss: 0018
Feb  9 10:14:01 crazy kernel: Process cron (pid: 193, stackpage=c456b000)
Feb  9 10:14:01 crazy kernel: Stack: 000f489b c11e01d8 000f489b c5fcd600
c013f0b1 c5fcd600 000f489b c11e01d8
Feb  9 10:14:01 crazy kernel:        00000000 00000000 000f489b c39a1520
c5f58080 c5ffd7a0 c014c213 c5fcd600
Feb  9 10:14:01 crazy kernel:        000f489b 00000000 00000000 fffffff4
c5f58080 c39a1520 c21f3800 c01361db
Feb  9 10:14:01 crazy kernel: Call Trace: [iget4+69/204]
[ext2_lookup+91/128] [real_lookup+83/196] [path_walk+1381/1964]
[getname+91/152] [__user_walk+60/88] [sys_stat64+22/120]
Feb  9 10:14:01 crazy kernel:        [system_call+51/64]
Feb  9 10:14:01 crazy kernel:
Feb  9 10:14:01 crazy kernel: Code: 39 6e 20 75 ef 8b 44 24 14 39 86 8c 00
00 00 75 e3 85 ff 74
Feb  9 10:15:29 crazy sendmail[16972]: f19GFOv16972:
from=<owner-pen-test@SECURITYFOCUS.COM>, size=5194, class=0, nrcpts=1,
msgid=<471ADE9820DCD411A46
E00B0D079F2830AB1E1@Xnetexch>, proto=ESMTP, daemon=MTA,
relay=lists.securityfocus.com [66.38.151.7]
Feb  9 10:16:30 crazy sendmail[127]: rejecting connections on daemon MTA:
load average: 12
Feb  9 10:16:30 crazy sendmail[127]: rejecting connections on daemon MSA:
load average: 12
Feb  9 10:16:45 crazy sendmail[127]: rejecting connections on daemon MTA:
load average: 12
Feb  9 10:16:45 crazy sendmail[127]: rejecting connections on daemon MSA:
load average: 12
Feb  9 10:17:00 crazy sendmail[127]: rejecting connections on daemon MTA:
load average: 13
Feb  9 10:17:00 crazy sendmail[127]: rejecting connections on daemon MSA:
load average: 13
Feb  9 10:17:15 crazy sendmail[127]: rejecting connections on daemon MTA:
load average: 13
Feb  9 10:17:15 crazy sendmail[127]: rejecting connections on daemon MSA:
load average: 13
Feb  9 10:17:30 crazy sendmail[127]: rejecting connections on daemon MTA:
load average: 14
Feb  9 10:17:30 crazy sendmail[127]: rejecting connections on daemon MSA:
load average: 14
Feb  9 10:17:45 crazy sendmail[127]: rejecting connections on daemon MTA:
load average: 14
Feb  9 10:17:45 crazy sendmail[127]: rejecting connections on daemon MSA:
load average: 14
Feb  9 10:18:00 crazy sendmail[127]: rejecting connections on daemon MTA:
load average: 14
..... and so on.....


Sorry if this has been directed at the wrong E-mail address.  Please let
me know if you have any idea on what might be causing this.

Thanks,

Matt Miller
mmiller@hick.org

---221122180-2070317943-981744356=:1012
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="oops_stuff.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10102091245560.1012@crazy.hick.org>
Content-Description: oops info
Content-Disposition: attachment; filename="oops_stuff.txt"

a3N5bW9vcHMgMi4zLjcgb24gaTU4NiAyLjQuMS4gIE9wdGlvbnMgdXNlZA0K
ICAgICAtViAoZGVmYXVsdCkNCiAgICAgLWsgL3Byb2Mva3N5bXMgKGRlZmF1
bHQpDQogICAgIC1sIC9wcm9jL21vZHVsZXMgKGRlZmF1bHQpDQogICAgIC1v
IC9saWIvbW9kdWxlcy8yLjQuMS8gKGRlZmF1bHQpDQogICAgIC1tIC9TeXN0
ZW0ubWFwIChzcGVjaWZpZWQpDQoNCk5vIG1vZHVsZXMgaW4ga3N5bXMsIHNr
aXBwaW5nIG9iamVjdHMNCldhcm5pbmcgKHJlYWRfbHNtb2QpOiBubyBzeW1i
b2xzIGluIGxzbW9kLCBpcyAvcHJvYy9tb2R1bGVzIGEgdmFsaWQgbHNtb2Qg
ZmlsZT8NCkZlYiAgOSAxMDoxMToyNiBjcmF6eSBrZXJuZWw6IFVuYWJsZSB0
byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCB2
aXJ0dWFsIGFkZHJlc3MgMDAwMDAwMjANCkZlYiAgOSAxMDoxMToyNiBjcmF6
eSBrZXJuZWw6IGMwMTNlY2VjDQpGZWIgIDkgMTA6MTE6MjYgY3Jhenkga2Vy
bmVsOiAqcGRlID0gMDAwMDAwMDANCkZlYiAgOSAxMDoxMToyNiBjcmF6eSBr
ZXJuZWw6IE9vcHM6IDAwMDANCkZlYiAgOSAxMDoxMToyNiBjcmF6eSBrZXJu
ZWw6IENQVTogICAgMA0KRmViICA5IDEwOjExOjI2IGNyYXp5IGtlcm5lbDog
RUlQOiAgICAwMDEwOltmaW5kX2lub2RlKzI4LzcyXQ0KRmViICA5IDEwOjEx
OjI2IGNyYXp5IGtlcm5lbDogRUZMQUdTOiAwMDAxMDIxNw0KRmViICA5IDEw
OjExOjI2IGNyYXp5IGtlcm5lbDogZWF4OiAwMDAwMDAwMCAgIGVieDogMDAw
MDAwMDAgICBlY3g6IDAwMDAwMDFhICAgZWR4OiAwMDAwMDAzYg0KRmViICA5
IDEwOjExOjI2IGNyYXp5IGtlcm5lbDogZXNpOiAwMDAwMDAwMCAgIGVkaTog
MDAwMDAwMDAgICBlYnA6IDAwMGUyODNiICAgZXNwOiBjNTQ4ZGU4OA0KRmVi
ICA5IDEwOjExOjI2IGNyYXp5IGtlcm5lbDogZHM6IDAwMTggICBlczogMDAx
OCAgIHNzOiAwMDE4DQpGZWIgIDkgMTA6MTE6MjYgY3Jhenkga2VybmVsOiBQ
cm9jZXNzIGNwcCAocGlkOiAxNjkwNiwgc3RhY2twYWdlPWM1NDhkMDAwKQ0K
RmViICA5IDEwOjExOjI2IGNyYXp5IGtlcm5lbDogU3RhY2s6IDAwMGUyODNi
IGMxMWUwMWQ4IDAwMGUyODNiIGM1ZmNkNjAwIGMwMTNmMGIxIGM1ZmNkNjAw
IDAwMGUyODNiIGMxMWUwMWQ4IA0KRmViICA5IDEwOjExOjI2IGNyYXp5IGtl
cm5lbDogICAgICAgIDAwMDAwMDAwIDAwMDAwMDAwIDAwMGUyODNiIGMxNDZj
OTYwIGMwNzlmYjgwIGM1NTJlNDQwIGMwMTRjMjEzIGM1ZmNkNjAwIA0KRmVi
ICA5IDEwOjExOjI2IGNyYXp5IGtlcm5lbDogICAgICAgIDAwMGUyODNiIDAw
MDAwMDAwIDAwMDAwMDAwIGZmZmZmZmY0IGMwNzlmYjgwIGMxNDZjOTYwIGMy
NzBlNGQ0IGMwMTM2MWRiIA0KRmViICA5IDEwOjExOjI2IGNyYXp5IGtlcm5l
bDogQ2FsbCBUcmFjZTogW2lnZXQ0KzY5LzIwNF0gW2V4dDJfbG9va3VwKzkx
LzEyOF0gW3JlYWxfbG9va3VwKzgzLzE5Nl0gW3BhdGhfd2FsaysxMzgxLzE5
NjRdIFtvcGVuX25hbWVpKzExNi8xNDA4XSBbZmlscF9vcGVuKzUxLzg0XSBb
c3lzX29wZW4rNTYvMTgwXSANCkZlYiAgOSAxMDoxMToyNiBjcmF6eSBrZXJu
ZWw6IENvZGU6IDM5IDZlIDIwIDc1IGVmIDhiIDQ0IDI0IDE0IDM5IDg2IDhj
IDAwIDAwIDAwIDc1IGUzIDg1IGZmIDc0IA0KVXNpbmcgZGVmYXVsdHMgZnJv
bSBrc3ltb29wcyAtdCBlbGYzMi1pMzg2IC1hIGkzODYNCkVycm9yIChwY2xv
c2VfbG9jYWwpOiBPb3BzX2RlY29kZSBwY2xvc2UgZmFpbGVkIDB4ZmZmZmZm
ZmYNCg0KQ29kZTsgIDAwMDAwMDAwIEJlZm9yZSBmaXJzdCBzeW1ib2wNCjAw
MDAwMDAwIDxfRUlQPjoNCkNvZGU7ICAwMDAwMDAwMCBCZWZvcmUgZmlyc3Qg
c3ltYm9sDQogICAwOiAgIDM5IDZlIDIwICAgICAgICAgICAgICAgICAgY21w
ICAgICVlYnAsMHgyMCglZXNpKQ0KQ29kZTsgIDAwMDAwMDAzIEJlZm9yZSBm
aXJzdCBzeW1ib2wNCiAgIDM6ICAgNzUgZWYgICAgICAgICAgICAgICAgICAg
ICBqbmUgICAgZmZmZmZmZjQgPF9FSVArMHhmZmZmZmZmND4gZmZmZmZmZjQg
PEVORF9PRl9DT0RFKzNmY2U0MTdjLz8/Pz8+DQpDb2RlOyAgMDAwMDAwMDUg
QmVmb3JlIGZpcnN0IHN5bWJvbA0KICAgNTogICA4YiA0NCAyNCAxNCAgICAg
ICAgICAgICAgIG1vdiAgICAweDE0KCVlc3AsMSksJWVheA0KQ29kZTsgIDAw
MDAwMDA5IEJlZm9yZSBmaXJzdCBzeW1ib2wNCiAgIDk6ICAgMzkgODYgOGMg
MDAgMDAgMDAgICAgICAgICBjbXAgICAgJWVheCwweDhjKCVlc2kpDQpDb2Rl
OyAgMDAwMDAwMGYgQmVmb3JlIGZpcnN0IHN5bWJvbA0KICAgZjogICA3NSBl
MyAgICAgICAgICAgICAgICAgICAgIGpuZSAgICBmZmZmZmZmNCA8X0VJUCsw
eGZmZmZmZmY0PiBmZmZmZmZmNCA8RU5EX09GX0NPREUrM2ZjZTQxN2MvPz8/
Pz4NCkNvZGU7ICAwMDAwMDAxMSBCZWZvcmUgZmlyc3Qgc3ltYm9sDQogIDEx
OiAgIDg1IGZmICAgICAgICAgICAgICAgICAgICAgdGVzdCAgICVlZGksJWVk
aQ0KQ29kZTsgIDAwMDAwMDEzIEJlZm9yZSBmaXJzdCBzeW1ib2wNCiAgMTM6
ICAgNzQgMDAgICAgICAgICAgICAgICAgICAgICBqZSAgICAgMTUgPF9FSVAr
MHgxNT4gMDAwMDAwMTUgQmVmb3JlIGZpcnN0IHN5bWJvbA0KDQoNCjEgd2Fy
bmluZyBhbmQgMSBlcnJvciBpc3N1ZWQuICBSZXN1bHRzIG1heSBub3QgYmUg
cmVsaWFibGUuDQo=
---221122180-2070317943-981744356=:1012--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
