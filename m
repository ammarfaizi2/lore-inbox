Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317463AbSIAUoT>; Sun, 1 Sep 2002 16:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317517AbSIAUoT>; Sun, 1 Sep 2002 16:44:19 -0400
Received: from transport.cksoft.de ([62.111.66.27]:5388 "EHLO
	transport.cksoft.de") by vger.kernel.org with ESMTP
	id <S317463AbSIAUoL> convert rfc822-to-8bit; Sun, 1 Sep 2002 16:44:11 -0400
Date: Sun, 1 Sep 2002 22:48:31 +0200 (CEST)
From: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
X-X-Sender: bz@e0-0.zab2.int.zabbadoz.net
To: linux-kernel@vger.kernel.org
Subject: 2.5.3x SMP boot prob
Message-ID: <Pine.BSF.4.44.0209012207000.988-100000@e0-0.zab2.int.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just tried some out of 2.5.3x and cannot even boot :(
As this is a MP machine the problem may be related to this.
attached a bootlog with one possible end.
The problem seems to happen at different points :((

Placed some more output with kernel config, lspci and
ksymoops output, ... on:
http://www.zabbadoz.net/zabbadoz-network/megablast/linux-testing/2002-09-01-2.5.33/

Perhaps this only is a problem with my configuration and the current
delvelopment changes ? Simply took about that what 2.4 runs with at
the moment...

If you need any other informations please let me know.

Thanks in advance.

--- snipp ---
root   (hd1,1)
 Filesystem type is ext2fs, partition type 0x83
kernel /vmlinuz.experimental root=/dev/hdd2 console=tty0 console=ttyS0,9600n8
   [Linux-bzImage, setup=0x1400, size=0xdb22e]

Linux version 2.5.33 (bz@megablast) (gcc version 3.2) #1 SMP Sun Sep 1 18:32:52 UTC 2002
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017ff0000 (usable)
 BIOS-e820: 0000000017ff0000 - 0000000017ff8000 (ACPI data)
 BIOS-e820: 0000000017ff8000 - 0000000018000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 000000000009fc00 - 00000000000a0000 (reserved)
 user: 00000000000f0000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 0000000017ff0000 (usable)
 user: 0000000017ff0000 - 0000000017ff8000 (ACPI data)
 user: 0000000017ff8000 - 0000000018000000 (ACPI NVS)
 user: 00000000fec00000 - 00000000fec01000 (reserved)
 user: 00000000fee00000 - 00000000fee01000 (reserved)
 user: 00000000ffff0000 - 0000000100000000 (reserved)
383MB LOWMEM available.
found SMP MP-table at 000fb4b0
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
On node 0 totalpages: 98288
zone(0): 4096 pages.
zone(1): 94192 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 AMI                        ) @ 0x000faf40
ACPI: RSDT (v001 AMIINT          00000.00016) @ 0x17ff0000
ACPI: FADT (v001 AMIINT          00000.00016) @ 0x17ff0030
ACPI: MADT (v001 AMIINT DRAC-100 00000.00009) @ 0x17ff00b0
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:7 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:7 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x14] polarity[0x1] trigger[0x3])
Using ACPI (MADT) for SMP configuration information
Kernel command line: root=/dev/hdd2 console=tty0 console=ttyS0,9600n8 mem=393152K
Initializing CPU#0
Detected 501.247 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 989.18 BogoMIPS
Memory: 386476k/393152k available (1326k kernel code, 6288k reserved, 299k data, 288k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#0.
CPU0: Intel Pentium III (Katmai) stepping 02
per-CPU timeslice cutoff: 1462.08 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
bad: schedule() with irqs disabled!
d7fcdf70 c0315af6 c02e2900 c011d42e 0000000a 00000400 c0253f1f d7fcdfa8
       00000000 00000000 00000001 c029e2f9 c0253f08 00000001 00000000 d7fce9e0
       00000000 00000000 00000000 00000000 c02a0c15 00000282 c02869bc d7fd1f7c
Call Trace: [<c011d42e>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcdf54 00001227 ffffedd9 c011d539 d7fcc000 00000046 c0315af6 00000046
       00000016 c02e2900 c011d420 0000000a 00000400 c0253f1f d7fcdfa8 00000000
       00000000 00000001 c029e2f9 c0253f08 00000001 00000000 d7fce9e0 00000000
Call Trace: [<c011d539>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded4 00000000 00000013 c01ce015 0000000e 00003fff c0106a8b c0315ae1
       c028f8e0 c01d18ef 00000000 00000000 00000005 0000000d 00000013 00000000
       00000013 c028f8e0 00000013 c0316fd1 ffffedd9 c011d0bf c028f8e0 c0316fd1
Call Trace: [<c01ce015>] [<c0106a8b>] [<c01d18ef>] [<c011d0bf>] [<c011d1cf>]
d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded4 00000000 00000008 c01ce015 0000000e 00003fff c01d2573 c0337c74
       c028f8e0 c01d18ef 00000000 00000000 00000005 0000000d 00000008 00000000
       00000008 c028f8e0 00000008 c03173e1 fffffdfb c011d0bf c028f8e0 c03173e1
Call Trace: [<c01ce015>] [<c01d2573>] [<c01d18ef>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcde7c c13c5000 000000a0 c01f3eb5 0000000c 00002e40 c0269bd3 c00bdbe0
       00000000 00000000 00000007 00000001 c01cd3e1 c13c5000 00000000 00000019
       00000001 00000001 c03173e1 d7fcc000 00000019 00000000 00000007 00000000
Call Trace: [<c01f3eb5>] [<c01cd3e1>] [<c01cec84>] [<c01d172d>] [<c011d0bf>]
   [<c011d1cf>] [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcdec4 00000000 ffffffff c01f2f02 0000000e 000035c0 00000000 00000000
       00000000 c01ce0cb c13c5000 00000001 0000000a c01d1806 00000000 c00beae0
       00000000 c01ce0cb c13c5000 00000001 0000000a c01d1806 00000000 c00bf4e0
       0000004f 00000018 00000000 00000000 c00bf580 c028f8e0 00000050 c03177ca
Call Trace: [<c01f2f02>] [<c01ce0cb>] [<c01d1806>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded4 00000086 ffffffff c01263f4 0000000a 00000000 c01d252f c0337c74
       0000000a c01d1826 00000000 c00bf4e0 0000004f 00000018 00000000 00000000
       c00bf580 c028f8e0 00000050 c03177ca fffffdfb c011d0bf c028f8e0 c031781a
Call Trace: [<c01263f4>] [<c01d252f>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded0 00000082 ffffffff c0126368 c0337c74 0000000a 00000000 c01d2573
       c0337c74 00093671 c01d1826 00000000 c00bf4e0 0000004f 00000018 00000000
       00000000 c00bf580 c028f8e0 00000050 c03177ca fffffdfb c011d0bf c028f8e0
Call Trace: [<c0126368>] [<c01d2573>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded4 00000000 00000022 c01ce015 0000000e 00003fff c01d2573 c0337c74
       c028f8e0 c01d18ef 00000000 00000000 00000005 0000000d 00000022 00000000
       00000022 c028f8e0 00000022 c0317c6c fffffdfb c011d0bf c028f8e0 c0317c6c
Call Trace: [<c01ce015>] [<c01d2573>] [<c01d18ef>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcde7c c13c5000 000000a0 c01f3eb5 0000000c 00000050 c0269bd3 c00b8000
       00000000 00000000 00000021 00000001 c01cd3e1 c13c5000 00000000 00000019
       00000001 00000001 c0317c6c d7fcc000 00000019 00000000 00000021 00000000
Call Trace: [<c01f3eb5>] [<c01cd3e1>] [<c01cec84>] [<c01d172d>] [<c011d0bf>]
   [<c011d1cf>] [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcdec4 00000000 ffffffff c01f2f02 0000000e 000007d0 00000000 00000000
       00000000 c01ce0cb c13c5000 00000001 0000000a c01d1806 00000000 c00b8f00
       00000000 c01ce0cb c13c5000 00000001 0000000a c01d1806 00000000 c00b9900
       0000004f 00000018 00000000 00000000 c00b99a0 c028f8e0 00000050 c031806f
Call Trace: [<c01f2f02>] [<c01ce0cb>] [<c01d1806>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d42<1>Unable to handle kernel NULL pointer dereference8attvvituull dddees 000000009
 4prpntnnineip:p:
c<427012718pd< =*00e00 00000op
:<400o
s:CP0:2  <4
CPU:P   1
<64:[Ic0 2  186]:[  0o27t18n] d NEF tai: e0
00F2
GS:a00 1000209 axe x:000000  1e x:cx0 003e10   cxe c:3e10af a0exe c:3d70ae
7c sie i:f00c00 1be  :b00 0001b00  bpe 0:00700c   esp: d700c8a4 esd 0 686   ses0 0868 Proc: s0ü×
 Ppice s10×0 49id: t10e20i49o1,7thcea0inaok=77fce600)ask=Stfck6 0c1c4>5t ck00c03c0 50000000020d70c0060 00d00c006  0000000b 0c012004  0100041 b 0
001b
  4>0 00  00 000f0ecdcfc0c70 01000001b000000d70ce760e6601c8121 80 000010 b 0000001
< >       dffee60  00000086  00000000 177cee600<c00000000] 00000 d4 0c0d26 deba001b0hebul
) TllcT: ce  i[80412] 41>f d8<c]128100>2 fe<c 1ff8d0>263><cc123977> 00] c011 020>]00
 c01 2[7c0
08 12 ]  [0301c34 a00 3cdc0ca1dbf>] 00<00100bc0>b 220c00a0045f]000<c019 100>] 0

   [ c  900e0>]0 [0c09090fc0]8f8ec 0900d05] c[3c0d0a caf] d[< 0018790f  028c0e9
74>a l
Tr  e: <cc1a2fb6>]  [<c01d757c>] [<<0111926c>  <c<c010bfe1>[<c0<1d1c9d] >  [ [<c921d53]>] [<c  1d<c01] 0cc>11d420>10
790ad  s<ce1ul06)>with cr19 17s>]led!c01d7fcd>d  0<001a0b 0>]00
4e  01c<c11 0f09>0 e <c013f2f >0 d25c3190f37>74
<c    df >028[8c0 901d1>]f [0c000a0ca0] 0
0 00000001 8000>0 d[00009347 0]000<001
0fbf ]   0c01a0b5 >028[8c0 000590]e c0c119d80f>]ffdb   1[dc0f920e1>] 0[<00179d85> Ca<c T9afd:>]<c01ce1050c >]c01dc070>]90<]01d1ce1a]0[<>]11
b >  [<c019d17f>]
[< 01[0f0f>d 32<c01<cb1b>420[< [1c7f1d>2 >[<
01ba2: >cheduce(9 feth]ir
 d  a[lc0!09df7f]de[< 0132f000  00<0010 001>] b5 c000009c>]000<c30ac026>]d3 cc0b93c7
]        0[0000a0 0f0] 0[< 0000b0bd  00<00117f01>d e1<c119520c>0000<000 0f00>019 <010 d  >]00
00  0[000092 c03]7dd<cd10c0c0> 0000c010 090>]00[ 00003044 ] 000c01a
bCa]  [ra01:8[<00] 3eb5>  [<<c1c93f8>]][<[010e9840c ]<c0<d112df] >< 011c010>]f
>]  [[cc092ddcf]] [<c011d032>] [
c0 1d420c0 0<c911]42[>c
a0068:  c[<du1e31 w>t  [<q01d0faf>e !
c01a0deb4] 000c019 f5f>]ff
c01 2[<2000920c0e 0[0001b2 01>0 0[0c00090f00] [<  19 f00>]0000cc00ceccb]c1[c500080000] 0
00  0[0c0c03d740] 00<c01a0fb0>b92c0c
9 f  >] 000c009d 0c>]001< 0102001>  0[00000 cf5b]36
 c0  f[ec00900d04] c[3c7d0a c>C ll<Tr1ce7 [>c 1f<f01>]0[8>]1ce<cb>9 16c01d18<6>1a[fc0>]d0
f>] [<[010da0f>] ][ c0[9708cd] 2[< [1c921d>2 >[ c<c92fe42] ][
c01addfs>hedulc(19wfdh>]rq
d s blec!
0a07a>ded4<c0000796 ]ff[ffffa00626]f4[<001031a >0 00<001c0fdf>2  [<301c0b b>]        0[0c0097c81d]82[ 0000900c c 0b<cc090fe00]4d 0c00001f 0]00[0c0 90fd00]0 [c0  a0 ac] b
36  c0[<f01087000] 4e<c01171d4>f ff<df1 cf11>0bf <021a8b0 >]317<c61
fCcl] Tr<ce1 [2c0>263
4>]  <[010292f>1 ] c0<c1106df ><c011c019>]d[>]01[d101>a
a>]  [<c0118730>] [[<011d0008>  <c11d 2[>c0
93b74:] c[<d0le0f fit  i<cs1aibab>] !
cd1fcfed> 000<c089 20ff]ff[ c01923e8 ] 3
7c   000c000a f50]00[0c00922d03] [<c    0c0>37c[4c00083908] 0[<18160000>0 00<c01b91c4 000
0 d 000c00a8 b00]00[< 01a0  b   000c0090 500]9360c0098f0c0]0000c01e fe3>7dd8<cf10fdfb c01
0bf c[2c08e2 d0>]all c0a0e:ca>]012<301>] [0>0 d[570>a [680]d18<6>1 [1c0>1 0[fc0 a<cbf1]1cf]
  [ c<ca11553]>][[cc097d52>]] [<c011d200>]
<ba1: fc1>dule(c w0tdfir]s dica19ed!
>] 7fcd    [00000a0 a0] 00<b 1087e0>] 00<c01ae060>03ff<cc09d1773]c0[3cc7a0
bf>    < c1a8b8e>]c0
d18   [0c0097f800]00[00009900c0] 000c019df00>]002bc01000f0>]
[<  19 f00>]002bc0008fca>]000002  c<c170279fffff[<b0c00168bf c0<8f1e31c0>1 e2<c
1a0abl ] a[e:0[a001be] 5[]c0<c71825] >] [< 01d1c0f9] 0<>]11d<cf>9 f<c>]1d1cc0]0
f  ] <c<c1193f>]>] c[1c0400>c []c01<d01087 0>] a
: s heduce1a w6t>]irq< d1sa1le>!
[dcf1aefc >]3c5<c0 a0b50>]0 c0cf19bf50>]0000c 090002>] c026  d3 <00194f0 >   <c 1 0d05>000[000102000>0 000ca 000c00]1 [<101381 0>3 500c 0000d00] 0000  9[
0  2f 0 0 00<c01000c0>]01[cc010e29 >]fcc<001a0000>]9 00c0090070>]000<a 100f0f>0
C l  [rc0ea0b5b0] 3[<5>1 7fc0>c 3e<>01[<20c>ec84<] 1<cf1d>72d>< 01c0d15>bf>]<
192 d0c] 1dcf>  [<c010d5c2>] [[c00108200]] <c<111a00>]>
 b[<:0sc31d4l] ) wcthairbs ]is[<l0d!0b5d7] d
4  00[000097ff9f] f <0119f22 >]0000c0 900e1a]0 0<00100d 0>0 000c 12f 0    0<c01000cc>]ce
b  13[5c00080900] 1[0001000a8>] d[8c0 0307400  [0001300 f>]  [ c0 a00500]a 00c009188c0]00000  000<c019c20b>]00[cc2892ee 0] 0[0201c9315>2  [cCa9l dra]e:[<<c11a0f0>>  [<c01ce79b>] [<c0  18[6>0 a0c081] bf>c 19c171>]cf>]c
1a0 bf[] 0[<d0120] b>c 11dc009] 59>]11d<201]
c>a :
sch dul<c)1wifh >rqs <cs1b9df!> d7<c01d4f0000 08<cffff0cf> c01<6310 700>000a<c00f0eb0 ]01
25 f c0<3717d3
>]   <c 102f09>a c0<d012e00b>0 0[0c00b99160] 00<0011d00f>0 18<c01101cf>000
000
[<c    53c>0b9[0c c1d828e] 0[<001267c0>1 e29cf10fadf> c01<c01f 6b2>f8e0 c01078a4>]C
ll   a[<:0[<0b1363 4[< [1c79d2>2 >[<c0102f10>6 ][<<c11660b>>  [<c011d8cf>]
<c0 9<cd01]53
]   c0<cd1000c >]c0[1c0208]9
] ad< 01he1uf>(  w<ch10re0 >]sa[lc0!9187>]de[0 00a000f2] f
ff f [0106a08 60] 7c74
00o00:a 800008008901de 73
74  7   8333fb74010093 6bdc08b1826 0080080  c0 b046080 00202
00000018 00000000
       00000000 c00b9400 c028f8e0 0000002b c0317e29 fffffdfb c011d0bf c028f8e0
Call Trace: [<c0126368>] [<c01d2573>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded4 00000000 00000024 c01ce015 0000000e 00003fff c01d2573 c0337c74
       c028f8e0 c01d18ef 00000000 00000000 00000005 0000000d 00000024 00000000
       00000024 c028f8e0 00000024 c0317e57 fffffdfb c011d0bf c028f8e0 c0317e57
Call Trace: [<c01ce015>] [<c01d2573>] [<c01d18ef>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcde7c c13c5000 000000a0 c01f3eb5 0000000c 000002d0 c0269bd3 c00b8500
       00000000 00000000 00000023 00000001 c01cd3e1 c13c5000 00000000 00000019
       00000001 00000001 c0317e57 d7fcc000 00000019 00000000 00000023 00000000
Call Trace: [<c01f3eb5>] [<c01cd3e1>] [<c01cec84>] [<c01d172d>] [<c011d0bf>]
   [<c011d1cf>] [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcdec4 00000000 ffffffff c01f2f02 0000000e 00000a50 00000000 00000000
       00000000 c01ce0cb c13c5000 00000001 0000000a c01d1806 00000000 c00b9400
       00000023 00000018 00000000 00000000 c00b94a0 c028f8e0 00000024 c0317e57
Call Trace: [<c01f2f02>] [<c01ce0cb>] [<c01d1806>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded4 00000086 ffffffff c01263f4 0000000a 00000000 c01d252f c0337c74
       0000000a c01d1826 00000000 c00b9400 00000023 00000018 00000000 00000000
       c00b94a0 c028f8e0 00000024 c0317e57 fffffdfb c011d0bf c028f8e0 c0317e7b
Call Trace: [<c01263f4>] [<c01d252f>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded0 00000082 ffffffff c0126368 c0337c74 0000000a 00000000 c01d2573
       c0337c74 00093d96 c01d1826 00000000 c00b9400 00000023 00000018 00000000
       00000000 c00b94a0 c028f8e0 00000024 c0317e57 fffffdfb c011d0bf c028f8e0
Call Trace: [<c0126368>] [<c01d2573>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded4 00000000 00000049 c01ce015 0000000e 00003fff c01d2573 c0337c74
       c028f8e0 c01d18ef 00000000 00000000 00000005 0000000d 00000049 00000000
       00000049 c028f8e0 00000049 c0317e7e fffffdfb c011d0bf c028f8e0 c0317e7e
Call Trace: [<c01ce015>] [<c01d2573>] [<c01d18ef>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcde7c c13c5000 000000a0 c01f3eb5 0000000c 00000320 c0269bd3 c00b85a0
       00000000 00000000 00000048 00000001 c01cd3e1 c13c5000 00000000 00000019
       00000001 00000001 c0317e7e d7fcc000 00000019 00000000 00000048 00000000
Call Trace: [<c01f3eb5>] [<c01cd3e1>] [<c01cec84>] [<c01d172d>] [<c011d0bf>]
   [<c011d1cf>] [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcdec4 00000000 ffffffff c01f2f02 0000000e 00000aa0 00000000 00000000
       00000000 c01ce0cb c13c5000 00000001 0000000a c01d1806 00000000 c00b94a0
       00000048 00000018 00000000 00000000 c00b9540 c028f8e0 00000049 c0317e7e
Call Trace: [<c01f2f02>] [<c01ce0cb>] [<c01d1806>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded4 00000086 ffffffff c01263f4 0000000a 00000000 c01d252f c0337c74
       0000000a c01d1826 00000000 c00b94a0 00000048 00000018 00000000 00000000
       c00b9540 c028f8e0 00000049 c0317e7e fffffdfb c011d0bf c028f8e0 c0317ec7
Call Trace: [<c01263f4>] [<c01d252f>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded0 00000082 ffffffff c0126368 c0337c74 0000000a 00000000 c01d2573
       c0337c74 00093deb c01d1826 00000000 c00b94a0 00000048 00000018 00000000
       00000000 c00b9540 c028f8e0 00000049 c0317e7e fffffdfb c011d0bf c028f8e0
Call Trace: [<c0126368>] [<c01d2573>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded4 00000000 00000050 c01ce015 0000000e 00003fff c01d2573 c0337c74
       c028f8e0 c01d18ef 00000000 00000000 00000005 0000000d 00000050 00000000
       00000050 c028f8e0 00000050 c0317eca fffffdfb c011d0bf c028f8e0 c0317eca
Call Trace: [<c01ce015>] [<c01d2573>] [<c01d18ef>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcde7c c13c5000 000000a0 c01f3eb5 0000000c 00000370 c0269bd3 c00b8640
       00000000 00000000 0000004f 00000001 c01cd3e1 c13c5000 00000000 00000019
       00000001 00000001 c0317eca d7fcc000 00000019 00000000 0000004f 00000000
Call Trace: [<c01f3eb5>] [<c01cd3e1>] [<c01cec84>] [<c01d172d>] [<c011d0bf>]
   [<c011d1cf>] [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcdec4 00000000 ffffffff c01f2f02 0000000e 00000af0 00000000 00000000
       00000000 c01ce0cb c13c5000 00000001 0000000a c01d1806 00000000 c00b9540
       0000004f 00000018 00000000 00000000 c00b95e0 c028f8e0 00000050 c0317eca
Call Trace: [<c01f2f02>] [<c01ce0cb>] [<c01d1806>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded4 00000086 ffffffff c01263f4 0000000a 00000000 c01d252f c0337c74
       0000000a c01d1826 00000000 c00b9540 0000004f 00000018 00000000 00000000
       c00b95e0 c028f8e0 00000050 c0317eca fffffdfb c011d0bf c028f8e0 c0317f1a
Call Trace: [<c01263f4>] [<c01d252f>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded0 00000082 ffffffff c0126368 c0337c74 0000000a 00000000 c01d2573
       c0337c74 00093e48 c01d1826 00000000 c00b9540 0000004f 00000018 00000000
       00000000 c00b95e0 c028f8e0 00000050 c0317eca fffffdfb c011d0bf c028f8e0
Call Trace: [<c0126368>] [<c01d2573>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded4 00000000 00000050 c01ce015 0000000e 00003fff c01d2573 c0337c74
       c028f8e0 c01d18ef 00000000 00000000 00000005 0000000d 00000050 00000000
       00000050 c028f8e0 00000050 c0317f1d fffffdfb c011d0bf c028f8e0 c0317f1d
Call Trace: [<c01ce015>] [<c01d2573>] [<c01d18ef>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcde7c c13c5000 000000a0 c01f3eb5 0000000c 000003c0 c0269bd3 c00b86e0
       00000000 00000000 0000004f 00000001 c01cd3e1 c13c5000 00000000 00000019
       00000001 00000001 c0317f1d d7fcc000 00000019 00000000 0000004f 00000000
Call Trace: [<c01f3eb5>] [<c01cd3e1>] [<c01cec84>] [<c01d172d>] [<c011d0bf>]
   [<c011d1cf>] [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcdec4 00000000 ffffffff c01f2f02 0000000e 00000b40 00000000 00000000
       00000000 c01ce0cb c13c5000 00000001 0000000a c01d1806 00000000 c00b95e0
       0000004f 00000018 00000000 00000000 c00b9680 c028f8e0 00000050 c0317f1d
Call Trace: [<c01f2f02>] [<c01ce0cb>] [<c01d1806>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded4 00000086 ffffffff c01263f4 0000000a 00000000 c01d252f c0337c74
       0000000a c01d1826 00000000 c00b95e0 0000004f 00000018 00000000 00000000
       c00b9680 c028f8e0 00000050 c0317f1d fffffdfb c011d0bf c028f8e0 c0317f6d
Call Trace: [<c01263f4>] [<c01d252f>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded0 00000082 ffffffff c0126368 c0337c74 0000000a 00000000 c01d2573
       c0337c74 00093ea5 c01d1826 00000000 c00b95e0 0000004f 00000018 00000000
       00000000 c00b9680 c028f8e0 00000050 c0317f1d fffffdfb c011d0bf c028f8e0
Call Trace: [<c0126368>] [<c01d2573>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded4 00000000 0000004e c01ce015 0000000e 00003fff c01d2573 c0337c74
       c028f8e0 c01d18ef 00000000 00000000 00000005 0000000d 0000004e 00000000
       0000004e c028f8e0 0000004e c0317f70 fffffdfb c011d0bf c028f8e0 c0317f70
Call Trace: [<c01ce015>] [<c01d2573>] [<c01d18ef>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcde7c c13c5000 000000a0 c01f3eb5 0000000c 00000410 c0269bd3 c00b8780
       00000000 00000000 0000004d 00000001 c01cd3e1 c13c5000 00000000 00000019
       00000001 00000001 c0317f70 d7fcc000 00000019 00000000 0000004d 00000000
Call Trace: [<c01f3eb5>] [<c01cd3e1>] [<c01cec84>] [<c01d172d>] [<c011d0bf>]
   [<c011d1cf>] [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcdec4 00000000 ffffffff c01f2f02 0000000e 00000b90 00000000 00000000
       00000000 c01ce0cb c13c5000 00000001 0000000a c01d1806 00000000 c00b9680
       0000004d 00000018 00000000 00000000 c00b9720 c028f8e0 0000004e c0317f70
Call Trace: [<c01f2f02>] [<c01ce0cb>] [<c01d1806>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded4 00000086 ffffffff c01263f4 0000000a 00000000 c01d252f c0337c74
       0000000a c01d1826 00000000 c00b9680 0000004d 00000018 00000000 00000000
       c00b9720 c028f8e0 0000004e c0317f70 fffffdfb c011d0bf c028f8e0 c0317fbe
Call Trace: [<c01263f4>] [<c01d252f>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded0 00000082 ffffffff c0126368 c0337c74 0000000a 00000000 c01d2573
       c0337c74 00093f00 c01d1826 00000000 c00b9680 0000004d 00000018 00000000
       00000000 c00b9720 c028f8e0 0000004e c0317f70 fffffdfb c011d0bf c028f8e0
Call Trace: [<c0126368>] [<c01d2573>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded4 00000000 00000038 c01ce015 0000000e 00003fff c01d2573 c0337c74
       c028f8e0 c01d18ef 00000000 00000000 00000005 0000000d 00000038 00000000
       00000038 c028f8e0 00000038 c0317fc1 fffffdfb c011d0bf c028f8e0 c0317fc1
Call Trace: [<c01ce015>] [<c01d2573>] [<c01d18ef>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcde7c c13c5000 000000a0 c01f3eb5 0000000c 00000460 c0269bd3 c00b8820
       00000000 00000000 00000037 00000001 c01cd3e1 c13c5000 00000000 00000019
       00000001 00000001 c0317fc1 d7fcc000 00000019 00000000 00000037 00000000
Call Trace: [<c01f3eb5>] [<c01cd3e1>] [<c01cec84>] [<c01d172d>] [<c011d0bf>]
   [<c011d1cf>] [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcdec4 00000000 ffffffff c01f2f02 0000000e 00000be0 00000000 00000000
       00000000 c01ce0cb c13c5000 00000001 0000000a c01d1806 00000000 c00b9720
       00000037 00000018 00000000 00000000 c00b97c0 c028f8e0 00000038 c0317fc1
Call Trace: [<c01f2f02>] [<c01ce0cb>] [<c01d1806>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded4 00000086 ffffffff c01263f4 0000000a 00000000 c01d252f c0337c74
       0000000a c01d1826 00000000 c00b9720 00000037 00000018 00000000 00000000
       c00b97c0 c028f8e0 00000038 c0317fc1 fffffdfb c011d0bf c028f8e0 c0317ff9
Call Trace: [<c01263f4>] [<c01d252f>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded0 00000082 ffffffff c0126368 c0337c74 0000000a 00000000 c01d2573
       c0337c74 00093f41 c01d1826 00000000 c00b9720 00000037 00000018 00000000
       00000000 c00b97c0 c028f8e0 00000038 c0317fc1 fffffdfb c011d0bf c028f8e0
Call Trace: [<c0126368>] [<c01d2573>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded4 00000000 00000024 c01ce015 0000000e 00003fff c01d2573 c0337c74
       c028f8e0 c01d18ef 00000000 00000000 00000005 0000000d 00000024 00000000
       00000024 c028f8e0 00000024 c0317ffc fffffdfb c011d0bf c028f8e0 c0317ffc
Call Trace: [<c01ce015>] [<c01d2573>] [<c01d18ef>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcde7c c13c5000 000000a0 c01f3eb5 0000000c 000004b0 c0269bd3 c00b88c0
       00000000 00000000 00000023 00000001 c01cd3e1 c13c5000 00000000 00000019
       00000001 00000001 c0317ffc d7fcc000 00000019 00000000 00000023 00000000
Call Trace: [<c01f3eb5>] [<c01cd3e1>] [<c01cec84>] [<c01d172d>] [<c011d0bf>]
   [<c011d1cf>] [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcdec4 00000000 ffffffff c01f2f02 0000000e 00000c30 00000000 00000000
       00000000 c01ce0cb c13c5000 00000001 0000000a c01d1806 00000000 c00b97c0
       00000023 00000018 00000000 00000000 c00b9860 c028f8e0 00000024 c0317ffc
Call Trace: [<c01f2f02>] [<c01ce0cb>] [<c01d1806>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded4 00000086 ffffffff c01263f4 0000000a 00000000 c01d252f c0337c74
       0000000a c01d1826 00000000 c00b97c0 00000023 00000018 00000000 00000000
       c00b9860 c028f8e0 00000024 c0317ffc fffffdfb c011d0bf c028f8e0 c0318020
Call Trace: [<c01263f4>] [<c01d252f>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded0 00000082 ffffffff c0126368 c0337c74 0000000a 00000000 c01d2573
       c0337c74 00093f6c c01d1826 00000000 c00b97c0 00000023 00000018 00000000
       00000000 c00b9860 c028f8e0 00000024 c0317ffc fffffdfb c011d0bf c028f8e0
Call Trace: [<c0126368>] [<c01d2573>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded4 00000000 00000049 c01ce015 0000000e 00003fff c01d2573 c0337c74
       c028f8e0 c01d18ef 00000000 00000000 00000005 0000000d 00000049 00000000
       00000049 c028f8e0 00000049 c0318023 fffffdfb c011d0bf c028f8e0 c0318023
Call Trace: [<c01ce015>] [<c01d2573>] [<c01d18ef>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcde7c c13c5000 000000a0 c01f3eb5 0000000c 00000500 c0269bd3 c00b8960
       00000000 00000000 00000048 00000001 c01cd3e1 c13c5000 00000000 00000019
       00000001 00000001 c0318023 d7fcc000 00000019 00000000 00000048 00000000
Call Trace: [<c01f3eb5>] [<c01cd3e1>] [<c01cec84>] [<c01d172d>] [<c011d0bf>]
   [<c011d1cf>] [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcdec4 00000000 ffffffff c01f2f02 0000000e 00000c80 00000000 00000000
       00000000 c01ce0cb c13c5000 00000001 0000000a c01d1806 00000000 c00b9860
       00000048 00000018 00000000 00000000 c00b9900 c028f8e0 00000049 c0318023
Call Trace: [<c01f2f02>] [<c01ce0cb>] [<c01d1806>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded4 00000086 ffffffff c01263f4 0000000a 00000000 c01d252f c0337c74
       0000000a c01d1826 00000000 c00b9860 00000048 00000018 00000000 00000000
       c00b9900 c028f8e0 00000049 c0318023 fffffdfb c011d0bf c028f8e0 c031806c
Call Trace: [<c01263f4>] [<c01d252f>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded0 00000082 ffffffff c0126368 c0337c74 0000000a 00000000 c01d2573
       c0337c74 00093fc1 c01d1826 00000000 c00b9860 00000048 00000018 00000000
       00000000 c00b9900 c028f8e0 00000049 c0318023 fffffdfb c011d0bf c028f8e0
Call Trace: [<c0126368>] [<c01d2573>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded4 00000000 00000050 c01ce015 0000000e 00003fff c01d2573 c0337c74
       c028f8e0 c01d18ef 00000000 00000000 00000005 0000000d 00000050 00000000
       00000050 c028f8e0 00000050 c031806f fffffdfb c011d0bf c028f8e0 c031806f
Call Trace: [<c01ce015>] [<c01d2573>] [<c01d18ef>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcde7c c13c5000 000000a0 c01f3eb5 0000000c 00000550 c0269bd3 c00b8a00
       00000000 00000000 0000004f 00000001 c01cd3e1 c13c5000 00000000 00000019
       00000001 00000001 c031806f d7fcc000 00000019 00000000 0000004f 00000000
Call Trace: [<c01f3eb5>] [<c01cd3e1>] [<c01cec84>] [<c01d172d>] [<c011d0bf>]
   [<c011d1cf>] [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcdec4 00000000 ffffffff c01f2f02 0000000e 00000cd0 00000000 00000000
       00000000 c01ce0cb c13c5000 00000001 0000000a c01d1806 00000000 c00b9900
       0000004f 00000018 00000000 00000000 c00b99a0 c028f8e0 00000050 c031806f
Call Trace: [<c01f2f02>] [<c01ce0cb>] [<c01d1806>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded4 00000086 ffffffff c01263f4 0000000a 00000000 c01d252f c0337c74
       0000000a c01d1826 00000000 c00b9900 0000004f 00000018 00000000 00000000
       c00b99a0 c028f8e0 00000050 c031806f fffffdfb c011d0bf c028f8e0 c03180bf
Call Trace: [<c01263f4>] [<c01d252f>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded0 00000082 ffffffff c0126368 c0337c74 0000000a 00000000 c01d2573
       c0337c74 0009401e c01d1826 00000000 c00b9900 0000004f 00000018 00000000
       00000000 c00b99a0 c028f8e0 00000050 c031806f fffffdfb c011d0bf c028f8e0
Call Trace: [<c0126368>] [<c01d2573>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded4 00000000 00000050 c01ce015 0000000e 00003fff c01d2573 c0337c74
       c028f8e0 c01d18ef 00000000 00000000 00000005 0000000d 00000050 00000000
       00000050 c028f8e0 00000050 c03180bf fffffdfb c011d0bf c028f8e0 c03180bf
Call Trace: [<c01ce015>] [<c01d2573>] [<c01d18ef>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcde7c c13c5000 000000a0 c01f3eb5 0000000c 000005a0 c0269bd3 c00b8aa0
       00000000 00000000 0000004f 00000001 c01cd3e1 c13c5000 00000000 00000019
       00000001 00000001 c03180bf d7fcc000 00000019 00000000 0000004f 00000000
Call Trace: [<c01f3eb5>] [<c01cd3e1>] [<c01cec84>] [<c01d172d>] [<c011d0bf>]
   [<c011d1cf>] [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcdec4 00000000 ffffffff c01f2f02 0000000e 00000d20 00000000 00000000
       00000000 c01ce0cb c13c5000 00000001 0000000a c01d1806 00000000 c00b99a0
       0000004f 00000018 00000000 00000000 c00b9a40 c028f8e0 00000050 c03180bf
Call Trace: [<c01f2f02>] [<c01ce0cb>] [<c01d1806>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded4 00000086 ffffffff c01263f4 0000000a 00000000 c01d252f c0337c74
       0000000a c01d1826 00000000 c00b99a0 0000004f 00000018 00000000 00000000
       c00b9a40 c028f8e0 00000050 c03180bf fffffdfb c011d0bf c028f8e0 c031810f
Call Trace: [<c01263f4>] [<c01d252f>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded0 00000082 ffffffff c0126368 c0337c74 0000000a 00000000 c01d2573
       c0337c74 0009407b c01d1826 00000000 c00b99a0 0000004f 00000018 00000000
       00000000 c00b9a40 c028f8e0 00000050 c03180bf fffffdfb c011d0bf c028f8e0
Call Trace: [<c0126368>] [<c01d2573>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
Stuck ??
CPU #1 not responding - cannot use it.
Error: only one processor found.
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 17.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 001 01  1    1    0   0   0    1    1    71
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9-> 0:20
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
bad: schedule() with irqs disabled!
d7fcded4 00000000 00000050 c01ce015 0000000e 00003fff c01d2573 c0337c74
       c028f8e0 c01d18ef 00000000 00000000 00000005 0000000d 00000050 00000000
       00000050 c028f8e0 00000050 c0318112 fffffdfb c011d0bf c028f8e0 c0318112
Call Trace: [<c01ce015>] [<c01d2573>] [<c01d18ef>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcde7c c13c5000 000000a0 c01f3eb5 0000000c 000005f0 c0269bd3 c00b8b40
       00000000 00000000 0000004f 00000001 c01cd3e1 c13c5000 00000000 00000019
       00000001 00000001 c0318112 d7fcc000 00000019 00000000 0000004f 00000000
Call Trace: [<c01f3eb5>] [<c01cd3e1>] [<c01cec84>] [<c01d172d>] [<c011d0bf>]
   [<c011d1cf>] [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcdec4 00000000 ffffffff c01f2f02 0000000e 00000d70 00000000 00000000
       00000000 c01ce0cb c13c5000 00000001 0000000a c01d1806 00000000 c00b9a40
       0000004f 00000018 00000000 00000000 c00b9ae0 c028f8e0 00000050 c0318112
Call Trace: [<c01f2f02>] [<c01ce0cb>] [<c01d1806>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded4 00000086 ffffffff c01263f4 0000000a 00000000 c01d252f c0337c74
       0000000a c01d1826 00000000 c00b9a40 0000004f 00000018 00000000 00000000
       c00b9ae0 c028f8e0 00000050 c0318112 fffffdfb c011d0bf c028f8e0 c0318162
Call Trace: [<c01263f4>] [<c01d252f>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded0 00000082 ffffffff c0126368 c0337c74 0000000a 00000000 c01d2573
       c0337c74 000940be c01d1826 00000000 c00b9a40 0000004f 00000018 00000000
       00000000 c00b9ae0 c028f8e0 00000050 c0318112 fffffdfb c011d0bf c028f8e0
Call Trace: [<c0126368>] [<c01d2573>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
..... CPU clock speed is 501.0039 MHz.
..... host bus clock speed is 100.0207 MHz.
cpu: 0, clocks: 100207, slice: 3036
CPU0<T0:100192,T1:97152,D:4,S:3036,C:100207>
Starting migration thread for cpu 0
CPUS done 4294967295
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
bad: schedule() with irqs disabled!
d7fcded4 00000000 0000004e c01ce015 0000000e 00003fff c01d2573 c0337c74
       c028f8e0 c01d18ef 00000000 00000000 00000005 0000000d 0000004e 00000000
       0000004e c028f8e0 0000004e c0318165 fffffdfb c011d0bf c028f8e0 c0318165
Call Trace: [<c01ce015>] [<c01d2573>] [<c01d18ef>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcde7c c13c5000 000000a0 c01f3eb5 0000000c 00000640 c0269bd3 c00b8be0
       00000000 00000000 0000004d 00000001 c01cd3e1 c13c5000 00000000 00000019
       00000001 00000001 c0318165 d7fcc000 00000019 00000000 0000004d 00000000
Call Trace: [<c01f3eb5>] [<c01cd3e1>] [<c01cec84>] [<c01d172d>] [<c011d0bf>]
   [<c011d1cf>] [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcdec4 00000000 ffffffff c01f2f02 0000000e 00000dc0 00000000 00000000
       00000000 c01ce0cb c13c5000 00000001 0000000a c01d1806 00000000 c00b9ae0
       0000004d 00000018 00000000 00000000 c00b9b80 c028f8e0 0000004e c0318165
Call Trace: [<c01f2f02>] [<c01ce0cb>] [<c01d1806>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded4 00000086 ffffffff c01263f4 0000000a 00000000 c01d252f c0337c74
       0000000a c01d1826 00000000 c00b9ae0 0000004d 00000018 00000000 00000000
       c00b9b80 c028f8e0 0000004e c0318165 fffffdfb c011d0bf c028f8e0 c03181b3
Call Trace: [<c01263f4>] [<c01d252f>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
bad: schedule() with irqs disabled!
d7fcded0 00000082 ffffffff c0126368 c0337c74 0000000a 00000000 c01d2573
       c0337c74 000940cf c01d1826 00000000 c00b9ae0 0000004d 00000018 00000000
       00000000 c00b9b80 c028f8e0 0000004e c0318165 fffffdfb c011d0bf c028f8e0
Call Trace: [<c0126368>] [<c01d2573>] [<c01d1826>] [<c011d0bf>] [<c011d1cf>]
   [<c011d532>] [<c011d420>] [<c011d420>]
PCI: PCI BIOS revision 2.10 entry at 0xfdb91, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20020829
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
c02e4920
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0060:[<c02e4920>]    Not tainted
EFLAGS: 00010086
eax: 00000020   ebx: c0192fd0   ecx: 00000000   edx: 000003fd
esi: d7fcdf34   edi: c032f400   ebp: c03181dc   esp: d7fcdf00
ds: 0068   es: 0068   ss: 0068
Process ü× (pid: -1072034981, threadinfo=d7fcc000 task=d7fce660)
Stack: d7fcc000 d7fcc000 00000009 c010a0ca 00000009 d7fcdf34 c13f4360 c13f4360
       d7fce660 d7fce660 c02e9e40 d7fcdf84 c0108790 d7fce660 00000020 d7fcc000
       d7fce660 c02e9e40 d7fcdf84 00000001 00000068 d7fc0068 ffffff09 c011811f
Call Trace: [<c010a0ca>] [<c0108790>] [<c011811f>] [<c0107e0d>] [<c019318a>]
   [<c01a0fbf>] [<c01a0b96>]

Code: 01 00 00 00 80 66 28 c0 60 43 3f c1 00 00 00 00 01 00 00 00
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
--- snipp ---

-- 
Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/

