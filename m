Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268222AbTGLRzq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 13:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268233AbTGLRzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 13:55:46 -0400
Received: from dsl-gte-19434.linkline.com ([64.30.195.78]:48512 "EHLO server")
	by vger.kernel.org with ESMTP id S268222AbTGLRyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 13:54:04 -0400
Message-ID: <001801c348a0$9dab91e0$3400a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: "lkml" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva> <003501c34572$4113f0c0$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307081551480.21543@freak.distro.conectiva> <020301c3459b$942a1860$3400a8c0@W2RZ8L4S02> <1057703020.5568.10.camel@dhcp22.swansea.linux.org.uk> <024801c345a2$ceeef090$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307091428450.26373@freak.distro.conectiva> <064101c34644$3d917850$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307100025160.6316@freak.distro.conectiva> <042801c3472c$f4539f80$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307110953370.28177@freak.distro.conectiva> <06e301c347c7$2a779590$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111405320.29894@freak.distro.conectiva> <002b01c347e9$36a04110$f300a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111749160.5537@freak.distro.conectiva>
Subject: Re: Linux 2.4.22-pre5 Was Re: Linux 2.4.22-pre3
Date: Sat, 12 Jul 2003 11:08:33 -0700
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0015_01C34865.EF067360"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0015_01C34865.EF067360
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I started linux-2.4.22-pre5 at 1:00am it stopped at 8:00am, with no error
messages. I did enable sysrq keys here is the information.

Show Memory
Jul 12 10:42:41 server SysRq : Show Memory
Jul 12 10:42:41 server Mem-info:
Jul 12 10:42:41 server Free pages:      507876kB (  2044kB HighMem)
Jul 12 10:42:41 server Zone:DMA freepages: 13600kB min:   128kB low:   256kB
high:   384kB
Jul 12 10:42:41 server Zone:Normal freepages:492232kB min:  1020kB low:
2040kB high:  3060kB
Jul 12 10:42:41 server Zone:HighMem freepages:  2044kB min:  1020kB low:
2040kB high:  3060kB
Jul 12 10:42:41 server ( Active: 41175, inactive: 52516, free: 126969 )
Jul 12 10:42:41 server 2*4kB 3*8kB 2*16kB 3*32kB 0*64kB 1*128kB 2*256kB
1*512kB 0*1024kB 6*2048kB = 13600kB)
Jul 12 10:42:41 server 35*4kB 62*8kB 25*16kB 58*32kB 102*64kB 50*128kB
13*256kB 4*512kB 2*1024kB 229*2048kB = 492236kB)
Jul 12 10:42:41 server 1*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB
1*512kB 1*1024kB 0*2048kB = 2044kB)
Jul 12 10:42:41 server Swap cache: add 0, delete 0, find 0/0, race 0+0
Jul 12 10:42:41 server Free swap:       265060kB
Jul 12 10:42:41 server 262144 pages of RAM
Jul 12 10:42:41 server 32768 pages of HIGHMEM
Jul 12 10:42:41 server 3726 reserved pages
Jul 12 10:42:41 server 123007 pages shared
Jul 12 10:42:41 server 0 pages swap cached
Jul 12 10:42:41 server 34 pages in page table cache
Jul 12 10:42:41 server Buffer memory:   128776kB
Jul 12 10:42:41 server Cache memory:   130604kB
Jul 12 10:42:41 server CLEAN: 12454 buffers, 49813 kbyte, 52 used
(last=12452), 0 locked, 0 dirty
Jul 12 10:42:41 server LOCKED: 27 buffers, 96 kbyte, 25 used (last=27), 0
locked, 0 dirty
Jul 12 10:42:41 server DIRTY: 12 buffers, 48 kbyte, 12 used (last=12), 0
locked, 8 dirty

Show Regs
Jul 12 10:42:51 server SysRq : Show Regs
Jul 12 10:42:51 server
Jul 12 10:42:51 server Pid: 3216, comm:           setiathome
Jul 12 10:42:51 server EIP: 0023:[<0806330d>] CPU: 1 ESP: 002b:bffff1ec
EFLAGS: 00000206    Tainted: P
Jul 12 10:42:51 server EAX: 40ff2040 EBX: 00022138 ECX: 00022158 EDX:
00022168
Jul 12 10:42:51 server ESI: 00022148 EDI: 00022128 EBP: bffff298 DS: 002b
ES: 002b
Jul 12 10:42:51 server CR0: 80050033 CR2: 41072000 CR3: 36d36000 CR4:
000002d0

Show State
Jul 12 10:42:54 server SysRq : Show State
Jul 12 10:42:54 server
Jul 12 10:42:54 server free                        sibling
Jul 12 10:42:54 server task             PC    stack   pid father child
younger older
Jul 12 10:42:54 server init          S C0270798  3072     1      0  5856
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c858>] [<c01601cc>] [<c011c7e0>]
[<c0160437>] [<c016089d>]
Jul 12 10:42:54 server [<c0159cc6>] [<c0109a3f>]
Jul 12 10:42:54 server keventd       S C1C1DF54  5880     2      1
3       (L-TLB)
Jul 12 10:42:54 server Call Trace:    [<c01b690d>] [<c012c203>] [<c0131924>]
[<c01317a0>] [<c010788e>]
Jul 12 10:42:54 server [<c01317a0>]
Jul 12 10:42:54 server ksoftirqd_CPU S C1C1BFAC  6044     3      1
4     2 (L-TLB)
Jul 12 10:42:54 server Call Trace:    [<c01eb557>] [<c0127a2c>] [<c010788e>]
[<c0127940>]
Jul 12 10:42:54 server ksoftirqd_CPU S F6D34000  6208     4      1
5     3 (L-TLB)
Jul 12 10:42:54 server Call Trace:    [<c0127a2c>] [<c010788e>] [<c0127940>]
Jul 12 10:42:54 server kswapd        S F7F5A000  6300     5      1
6     4 (L-TLB)
Jul 12 10:42:54 server Call Trace:    [<c0124e00>] [<c0141b59>] [<c0141aa0>]
[<c010788e>] [<c0141aa0>]
Jul 12 10:42:54 server bdflush       S FFFFFFFF  6276     6      1
7     5 (L-TLB)
Jul 12 10:42:54 server Call Trace:    [<c011d330>] [<c015245f>] [<c010788e>]
[<c0152310>]
Jul 12 10:42:54 server kupdated      S 001F5ECD  5372     7      1
19     6 (L-TLB)
Jul 12 10:42:54 server Call Trace:    [<c0185c6e>] [<c011c858>] [<c011c7e0>]
[<c0152575>] [<c0152480>]
Jul 12 10:42:54 server [<c010788e>] [<c0152480>]
Jul 12 10:42:54 server ahc_dv_0      S F7B67CC4  5556    17      1
22    18 (L-TLB)
Jul 12 10:42:54 server Call Trace:    [<c010827e>] [<fa80b373>] [<c0108412>]
[<fa82d5ef>] [<fa827ee0>]
Jul 12 10:42:54 server [<c010788e>] [<fa827ee0>]
Jul 12 10:42:54 server ahc_dv_1      S FFFFFFFF  5984    18      1
17    20 (L-TLB)
Jul 12 10:42:54 server Call Trace:    [<c010827e>] [<c011e306>] [<c0108412>]
[<fa82d5ef>] [<fa827ee0>]
Jul 12 10:42:54 server [<c010788e>] [<fa827ee0>]
Jul 12 10:42:54 server scsi_eh_1     S FFFFFFFF  6168    19      1
20     7 (L-TLB)
Jul 12 10:42:54 server Call Trace:    [<c010827e>] [<c0108412>] [<fa80f100>]
[<fa808daf>] [<fa80f186>]
Jul 12 10:42:54 server [<c01099f2>] [<c010788e>] [<fa8088d0>]
Jul 12 10:42:54 server scsi_eh_2     S FFFFFFFF  6168    20      1
18    19 (L-TLB)
Jul 12 10:42:54 server Call Trace:    [<c010827e>] [<c0108412>] [<fa80f100>]
[<fa808daf>] [<fa80f186>]
Jul 12 10:42:54 server [<c01099f2>] [<c010788e>] [<fa8088d0>]
Jul 12 10:42:54 server khubd         S C02B0000  2384    22      1
32    17 (L-TLB)
Jul 12 10:42:54 server Call Trace:    [<c0124e00>] [<fa85ba36>] [<c010ef5a>]
[<fa866838>] [<fa866838>]
Jul 12 10:42:54 server [<c010788e>] [<fa85b8e0>]
 Jul 12 10:42:54 server kjournald     S F6D34000  4484    32      1
51    22 (L-TLB)
Jul 12 10:42:54 server Call Trace:    [<c01193cc>] [<c011d330>] [<c018cdc9>]
[<c01099f2>] [<c018cbd0>]
Jul 12 10:42:54 server [<c010788e>] [<c018cbf0>]
Jul 12 10:42:54 server devfsd        S F7332000  5144    51      1  5030
74    32 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0109a3f>]
Jul 12 10:42:54 server kjournald     S F7538000  5568    74      1
75    51 (L-TLB)
Jul 12 10:42:54 server Call Trace:    [<c01219dd>] [<c011d330>] [<c0121805>]
[<c018cdc9>] [<c01099f2>]
Jul 12 10:42:54 server [<c018cbd0>] [<c010788e>] [<c018cbf0>]
Jul 12 10:42:54 server kjournald     S C1C34000  4592    75      1
76    74 (L-TLB)
Jul 12 10:42:54 server Call Trace:    [<c011d330>] [<c018cdc9>] [<c01099f2>]
[<c018cbd0>] [<c010788e>]
Jul 12 10:42:54 server [<c018cbf0>]
Jul 12 10:42:54 server kjournald     S F7404000  4296    76      1
227    75 (L-TLB)
Jul 12 10:42:54 server Call Trace:    [<c011d330>] [<c018cdc9>] [<c01099f2>]
[<c018cbd0>] [<c010788e>]
Jul 12 10:42:54 server [<c018cbf0>]
Jul 12 10:42:54 server gpm           S 00000282  1360   227      1
245    76 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c858>] [<c0234f9e>] [<c011c7e0>]
[<c01e299c>] [<c0160437>]
Jul 12 10:42:54 server [<c016089d>] [<c014b628>] [<c0109a3f>]
Jul 12 10:42:54 server syslog-ng     R F6D34000     0   245      1
297   227 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011cc0b>] [<c0142c37>] [<c01a9ecd>]
[<c01e299c>] [<c0160144>]
Jul 12 10:42:54 server [<c0160dde>] [<c014c1c7>] [<c01269da>] [<c0109a3f>]
Jul 12 10:42:54 server dhcpd         S 00000000  4576   297      1
1933   245 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0142acc>] [<c0142c37>] [<c011c858>]
[<c01e928e>] [<c011c7e0>]
Jul 12 10:42:54 server [<c01e299c>] [<c0160437>] [<c016089d>] [<c0109a3f>]
Jul 12 10:42:54 server zorbcount.pl  S F7427560  1360  1933      1  5024
1940   297 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011bab0>] [<c0158ab8>] [<c0158bbb>]
[<c014c10d>] [<c0109a3f>]
Jul 12 10:42:54 server safe_mysqld   S F7880000  1360  1940      1  1960
1961  1933 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c012e35d>] [<c0125c94>] [<c012d630>]
[<c0109a3f>]
Jul 12 10:42:54 server mysqld        S F7881ECC  2384  1960   1940  1970
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c8a5>] [<c0234f9e>] [<c01e299c>]
[<c0160437>] [<c016089d>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server clamd         S F7B261D4  5132  1961      1  1962
2029  1940 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c01872ba>] [<c0187b0e>] [<c011c8a5>]
[<c020a158>] [<c01807ee>]
Jul 12 10:42:54 server [<c020a295>] [<c0166a04>] [<c0228520>] [<c01e2269>]
[<c01e333a>] [<c011cc0b>]
Jul 12 10:42:54 server [<c012e33c>] [<c01e3f12>] [<c0107d1d>] [<c0109a3f>]
Jul 12 10:42:54 server clamd         Z F7A49F3C  4616  1962   1961
(L-TLB)
Jul 12 10:42:54 server Call Trace:    [<c0125383>] [<c011ef3f>] [<c0125a40>]
[<c0125b65>] [<c0109a3f>]
Jul 12 10:42:54 server clamd         S F6D34000  4448  1964      1
5856 22759 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c012b556>] [<c011c858>] [<c01193cc>]
[<c011c7e0>] [<c012d630>]
Jul 12 10:42:54 server [<c012b9bb>] [<c0109a3f>]
Jul 12 10:42:54 server mysqld        S F6D22000  5060  1970   1960 30425
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c01601cc>] [<c011c858>] [<c011c7e0>]
[<c0160b7e>] [<c0160d3a>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server mysqld        S 00000000  2388  1971   1970
1972       (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c010878b>] [<c0109a3f>]
Jul 12 10:42:54 server mysqld        S 00000000  2384  1972   1970
1973  1971 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c010878b>] [<c0109a3f>]
Jul 12 10:42:54 server mysqld        S C0138B40  5428  1973   1970
1974  1972 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0138b40>] [<c010878b>] [<c0109a3f>]
Jul 12 10:42:54 server mysqld        S 00000000  2388  1974   1970
1975  1973 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c010878b>] [<c0109a3f>]
Jul 12 10:42:54 server mysqld        S 00000000  5836  1975   1970
1976  1974 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0160812>] [<c010878b>] [<c0109a3f>]
Jul 12 10:42:54 server mysqld        S F6D34000  4632  1976   1970
1977  1975 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c01fd050>] [<c01fce6c>] [<c011c858>]
[<c011c7e0>] [<c0160437>]
Jul 12 10:42:54 server [<c016089d>] [<c012b556>] [<c0109a3f>]
Jul 12 10:42:54 server mysqld        S 00000001  4952  1977   1970
1978  1976 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c010878b>] [<c0109a3f>]
Jul 12 10:42:54 server mysqld        S 00000286  2384  1978   1970
1979  1977 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c012629b>] [<c01264b2>] [<c010878b>]
[<c0109a3f>]
Jul 12 10:42:54 server mysqld        S F6D22000  4980  1979   1970
3089  1978 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c8a5>] [<c023470a>] [<c0234c5b>]
[<c01e249f>] [<c01e25c6>]
Jul 12 10:42:54 server [<c014c10d>] [<c0109a3f>]
Jul 12 10:42:54 server spamd         S 00000000  4880  2029      1
2107  1961 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c8a5>] [<c012c6d2>] [<c01e299c>]
[<c0160437>] [<c016089d>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server courierfilter S 00000000  1360  2107      1
2112  2029 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c010878b>] [<c0109a3f>]
Jul 12 10:42:54 server courierlogger S F7245EFC  4880  2112      1
2124  2107 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0134d24>] [<c0158ab8>] [<c0158bbb>]
[<c014c10d>] [<c0109a3f>]
Jul 12 10:42:54 server authdaemond.m S C0270798  1360  2124      1  2132
2150  2112 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c858>] [<c01601cc>] [<c011c7e0>]
[<c0160437>] [<c016089d>]
Jul 12 10:42:54 server [<c011cc0b>] [<c0109a3f>]
Jul 12 10:42:54 server authdaemond.m S F7269EEC  2384  2125   2124
2126       (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c858>] [<c0234f9e>] [<c011c7e0>]
[<c01e299c>] [<c0160437>]
 Jul 12 10:42:54 server [<c016089d>] [<c0109a3f>]
Jul 12 10:42:54 server authdaemond.m S C0270798  4880  2126   2124
2127  2125 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c858>] [<c0234f9e>] [<c011c7e0>]
[<c01e299c>] [<c0160437>]
Jul 12 10:42:54 server [<c016089d>] [<c0109a3f>]
Jul 12 10:42:54 server authdaemond.m S C0270798  4996  2127   2124
2131  2126 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c858>] [<c0234f9e>] [<c011c7e0>]
[<c01e299c>] [<c0160437>]
Jul 12 10:42:54 server [<c016089d>] [<c0109a3f>]
Jul 12 10:42:54 server authdaemond.m S C0270798  4788  2131   2124
2132  2127 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c858>] [<c0234f9e>] [<c011c7e0>]
[<c01e299c>] [<c0160437>]
Jul 12 10:42:54 server [<c016089d>] [<c0109a3f>]
Jul 12 10:42:54 server authdaemond.m S C0270798  4956  2132   2124
2131 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c858>] [<c0234f9e>] [<c011c7e0>]
[<c01e299c>] [<c0160437>]
Jul 12 10:42:54 server [<c016089d>] [<c0109a3f>]
Jul 12 10:42:54 server courierd      S F7232000  4248  2150      1  2588
2170  2124 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S C012DF55  4840  2170      1  5725
2179  2150 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c012df55>] [<c012e35d>] [<c0125c94>]
[<c012d630>] [<c0109a3f>]
Jul 12 10:42:54 server courierlogger S F719E000  1360  2179      1
2194  2170 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011bab0>] [<c0158ab8>] [<c0158bbb>]
[<c014c10d>] [<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S F71A3EB4  4960  2194      1
2205  2179 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c8a5>] [<c01e299c>] [<c0160437>]
[<c016089d>] [<c0109a3f>]
Jul 12 10:42:54 server courierlogger S F7165EFC  4824  2205      1
2221  2194 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0134d24>] [<c0158ab8>] [<c0158bbb>]
[<c014c10d>] [<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S F7135EB4  5132  2221      1
2231  2205 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c8a5>] [<c01e299c>] [<c0160437>]
[<c016089d>] [<c0109a3f>]
Jul 12 10:42:54 server courierlogger S F7145EFC  4880  2231      1
2243  2221 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0134d24>] [<c0158ab8>] [<c0158bbb>]
[<c014c10d>] [<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S F7179EB4  2344  2243      1
2252  2231 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c8a5>] [<c01e299c>] [<c0160437>]
[<c016089d>] [<c0109a3f>]
Jul 12 10:42:54 server courierlogger S F7193EFC  4880  2252      1
2269  2243 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0134d24>] [<c0158ab8>] [<c0158bbb>]
[<c014c10d>] [<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S F712A668  2388  2269      1
2279  2252 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c8a5>] [<c011bab0>] [<c01e299c>]
[<c0160437>] [<c016089d>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server courierlogger S F7332000  4880  2279      1
2295  2269 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011cc64>] [<c0158ab8>] [<c0158bbb>]
[<c014c10d>] [<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S F70EC668  4196  2295      1  5054
2305  2279 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c8a5>] [<c011bab0>] [<c01e299c>]
[<c0160437>] [<c016089d>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server courierlogger S F6D22000  1360  2305      1
2318  2295 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0158ab8>] [<c0158bbb>] [<c014c10d>]
[<c0109a3f>]
Jul 12 10:42:54 server fcron         S F6D22000  1360  2318      1  5178
2324  2305 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c858>] [<c011c7e0>] [<c012d514>]
[<c012b9bb>] [<c0109a3f>]
Jul 12 10:42:54 server cupsd         S F709E005  1360  2324      1  2918
2927  2318 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server foomatic-rip  S F7427268  4248  2917   2324  2959
2918       (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011bab0>] [<c0158ab8>] [<c0158bbb>]
[<c014c10d>] [<c0109a3f>]
Jul 12 10:42:54 server parallel      D 00000001  4880  2918   2324
2917 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0197e36>] [<c0197d0c>] [<c0199f10>]
[<c0159e6f>] [<c0159d0b>]
Jul 12 10:42:54 server [<c015a806>] [<fa91888e>] [<fa918bd0>] [<fa918de1>]
[<c0109a3f>]
Jul 12 10:42:54 server portmap       S F703E768  2384  2927      1
2946  2324 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c01e928e>] [<c011c8a5>] [<c01e299c>]
[<c0160a9b>] [<c0160b7e>]
Jul 12 10:42:54 server [<c0160d3a>] [<c0109a3f>]
Jul 12 10:42:54 server chronyd       S F7ABE400  4248  2946      1
2968  2927 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<c0164910>] [<c014d837>]
[<fa9185e1>] [<c014b628>]
Jul 12 10:42:54 server [<fa91906f>] [<c0109a3f>]
Jul 12 10:42:54 server foomatic-rip  S C012DF55  5544  2959   2917  2961
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c012df55>] [<c012e35d>] [<c0125c94>]
[<c0109a3f>]
Jul 12 10:42:54 server foomatic-rip  S 00000000  5912  2960   2959
2961       (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c012be2c>] [<c0158ab8>] [<c0158f7b>]
[<c014c2ed>] [<c0109a3f>]
Jul 12 10:42:54 server sh            S F6FE8000  4880  2961   2959  2964
2960 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c012e35d>] [<c0125c94>] [<c012d630>]
[<c0109a3f>]
Jul 12 10:42:54 server sh            S F6FCA000  4636  2963   2961  2972
2964       (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c012e35d>] [<c0125c94>] [<c012d630>]
[<c0109a3f>]
Jul 12 10:42:54 server pnm2ppa       S F6FF6000  4248  2964   2961
2963 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0158ab8>] [<c0158ed2>] [<c014c2ed>]
[<c0109a3f>]
Jul 12 10:42:54 server nmbd          S C0270798  4336  2968      1  2970
2997  2946 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c858>] [<c011c7e0>] [<c0160437>]
[<c016089d>] [<c0109a3f>]
Jul 12 10:42:54 server nmbd          S F7427D18  4824  2970   2968
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011bab0>] [<c0158ab8>] [<c0158bbb>]
[<c014c10d>] [<c0109a3f>]
Jul 12 10:42:54 server gs            S F6F0A000  4248  2972   2963  3029
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c012be2c>] [<c0158ab8>] [<c0158f7b>]
[<c014c2ed>] [<c01193cc>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server smbd          S F7A6BA34  4428  2997      1  5730
3111  2968 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c8a5>] [<c0160437>] [<c016089d>]
[<fa91a238>] [<c0109a3f>]
Jul 12 10:42:54 server sh            S F6F0A000  4608  3029   2972  3033
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c012d630>] [<c0109a3f>]
Jul 12 10:42:54 server cat           S 00000000  4880  3033   3029
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0108317>] [<c0158ab8>] [<c0158f7b>]
[<c014c2ed>] [<c01193cc>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server mysqld        S F7220000  5412  3089   1970
3631  1979 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c8a5>] [<c023470a>] [<c0234c5b>]
[<c01e249f>] [<c01e25c6>]
Jul 12 10:42:54 server [<c014c10d>] [<c0109a3f>]
Jul 12 10:42:54 server httpd         S F6D22000  4824  3111      1  5848
3178  2997 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c858>] [<c011c7e0>] [<c0160437>]
[<c016089d>] [<c0125cb3>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server httpd         S F709E005  3968  3137   3111
3138       (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0135b21>] [<c0135f12>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server httpd         S 00000004  4412  3138   3111
3141  3137 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0201480>] [<c020009c>] [<c011c8a5>]
[<fa897f07>] [<c020a158>]
Jul 12 10:42:54 server [<c01eb557>] [<c020a295>] [<c0166a04>] [<c0228520>]
[<c01e2269>] [<c01e333a>]
Jul 12 10:42:54 server [<c0164910>] [<c014d837>] [<c01688ba>] [<c0158b2b>]
[<c01e3f12>] [<c0109a3f>]
Jul 12 10:42:54 server httpd         S 00000004  4360  3141   3111
3142  3138 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0201480>] [<c020009c>] [<c011c8a5>]
[<c020a158>] [<c01e66a3>]
Jul 12 10:42:54 server [<c020a295>] [<c0166a04>] [<c0228520>] [<c01e2269>]
[<c01e333a>] [<c0164910>]
Jul 12 10:42:54 server [<c014d837>] [<c01688ba>] [<c0158b2b>] [<c01e3f12>]
[<c0109a3f>]
Jul 12 10:42:54 server httpd         S F709E005  4488  3142   3111
3143  3141 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server httpd         S F709E005  4032  3143   3111
8526  3142 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server miniserv.pl   S F6D22000  4616  3178      1
3198  3111 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c858>] [<c01e928e>] [<c011c7e0>]
[<c01e299c>] [<c0160437>]
Jul 12 10:42:54 server [<c016089d>] [<c0109a3f>]
Jul 12 10:42:54 server miniserv.pl   S F6D34000  4960  3198      1
3216  3178 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c858>] [<c01e928e>] [<c011c7e0>]
[<c01e299c>] [<c0160437>]
Jul 12 10:42:54 server [<c016089d>] [<c0109a3f>]
Jul 12 10:42:54 server setiathome    R current   4240  3215      1
3223  3216 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c010b79c>] [<c010e628>]
Jul 12 10:42:54 server setiathome    R F7AD8000  1360  3216      1
3215  3198 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c01193cc>] [<c0109aed>]
Jul 12 10:42:54 server xinetd        S C0270798  4996  3223      1
3248  3215 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c8a5>] [<c01601cc>] [<c01e299c>]
[<c0160437>] [<c016089d>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server sshd          S 00000000     4  3248      1 11222
3269  3223 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c8a5>] [<c011bab0>] [<c01e299c>]
[<c0160437>] [<c016089d>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server proftpd       S F6D22000     0  3269      1
3270  3248 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c858>] [<c011c7e0>] [<c01e299c>]
[<c0160437>] [<c016089d>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server agetty        S F6FD2005  4616  3270      1
3271  3269 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c012ffe9>] [<c0109a3f>]
Jul 12 10:42:54 server agetty        S 00000008  4636  3271      1
3272  3270 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c01b7094>] [<c011c8a5>] [<c01a9d16>]
[<c01a9a57>] [<c01a494e>]
Jul 12 10:42:54 server [<c014c10d>] [<c012ffe9>] [<c0109a3f>]
Jul 12 10:42:54 server agetty        S 00000008    16  3272      1
3273  3271 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c01b7094>] [<c011c8a5>] [<c01a9d16>]
[<c01a9a57>] [<c01a494e>]
Jul 12 10:42:54 server [<c014c10d>] [<c012ffe9>] [<c0109a3f>]
Jul 12 10:42:54 server agetty        S 00000008     0  3273      1
3274  3272 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c01b7094>] [<c011c8a5>] [<c01a9d16>]
[<c01a9a57>] [<c01a494e>]
Jul 12 10:42:54 server [<c014c10d>] [<c012ffe9>] [<c0109a3f>]
Jul 12 10:42:54 server agetty        S 00000008     0  3274      1
3275  3273 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c01b7094>] [<c011c8a5>] [<c01a9d16>]
[<c01a9a57>] [<c01a494e>]
Jul 12 10:42:54 server [<c014c10d>] [<c012ffe9>] [<c0109a3f>]
Jul 12 10:42:54 server agetty        S 00000008     4  3275      1
3276  3274 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c01b7094>] [<c011c8a5>] [<c01a9d16>]
[<c01a9a57>] [<c01a494e>]
Jul 12 10:42:54 server [<c014c10d>] [<c012ffe9>] [<c0109a3f>]
Jul 12 10:42:54 server mgetty        S F5835EC0  1536  3276      1
3277  3275 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0142acc>] [<c0142c37>] [<c011c858>]
[<c01a9ecd>] [<c011c7e0>]
Jul 12 10:42:54 server [<c01a5c86>] [<c0160437>] [<c016089d>] [<c0109a3f>]
Jul 12 10:42:54 server mgetty        S EA507FDC     0  3277      1
22759  3276 (L-TLB)
Jul 12 10:42:54 server Call Trace:    [<c01872ba>] [<c011c8a5>] [<c01872ba>]
[<c01aad4f>] [<c01bbcaf>]
Jul 12 10:42:54 server [<c01a56d4>] [<c0140de3>] [<c017e59e>] [<c01a5bb8>]
[<c014d865>] [<c014b54f>]
Jul 12 10:42:54 server [<c0124d04>] [<c0125824>] [<c014c3a7>] [<c0125b65>]
[<c0109a3f>]
Jul 12 10:42:54 server mysqld        S F6D34000     0  3631   1970
4326  3089 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c8a5>] [<c023470a>] [<c0234c5b>]
[<c01e249f>] [<c01e25c6>]
Jul 12 10:42:54 server [<c014c10d>] [<c0109a3f>]
Jul 12 10:42:54 server mysqld        S F7234000     0  4326   1970
22814  3631 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c8a5>] [<c023470a>] [<c0234c5b>]
[<c01e249f>] [<c01e25c6>]
Jul 12 10:42:54 server [<c014c10d>] [<c0109a3f>]
Jul 12 10:42:54 server sshd          S F4AD0000     0 11222   3248 11320
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c8a5>] [<c01a9ecd>] [<c0160437>]
[<c016089d>] [<c0109a3f>]
Jul 12 10:42:54 server bash          S 00000010  2100 11320  11222
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c8a5>] [<c01a9d16>] [<c01a9a57>]
[<c01a494e>] [<c014c10d>]
Jul 12 10:42:54 server [<c01269da>] [<c0109a3f>]
Jul 12 10:42:54 server named         S 00000000     0 22759      1
1964  3277 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0142acc>] [<c011c858>] [<c01e928e>]
[<c011c7e0>] [<c01e299c>]
Jul 12 10:42:54 server [<c0160437>] [<c016089d>] [<c0109a3f>]
Jul 12 10:42:54 server mysqld        S F7268000     0 22814   1970
30425  4326 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c8a5>] [<c023470a>] [<c0234c5b>]
[<c01e249f>] [<c01e25c6>]
Jul 12 10:42:54 server [<c014c10d>] [<c0109a3f>]
Jul 12 10:42:54 server mysqld        S F7238000     0 30425   1970
22814 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c8a5>] [<c023470a>] [<c0234c5b>]
[<c01e249f>] [<c01e25c6>]
Jul 12 10:42:54 server [<c014c10d>] [<c0109a3f>]
Jul 12 10:42:54 server httpd         S F709E005  2100  8526   3111
16297  3143 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0135b21>] [<c0135f12>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server httpd         S 00000004     0 16297   3111
16325  8526 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0201480>] [<c020009c>] [<c011c8a5>]
[<c0201688>] [<c020a158>]
Jul 12 10:42:54 server [<c020a295>] [<c0166a04>] [<c0228520>] [<c01e2269>]
[<c01e333a>] [<c0164910>]
Jul 12 10:42:54 server [<c014d837>] [<c014b54f>] [<c01e3f12>] [<c0109a3f>]
Jul 12 10:42:54 server httpd         S F709E005     0 16325   3111
5309 16297 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0135b21>] [<c0135f12>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server courierd      S C0270798  4608  2588   2150  2593
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c8a5>] [<c01601cc>] [<c0160437>]
[<c016089d>] [<c0109a3f>]
Jul 12 10:42:54 server courieruucp   S E7E5BEFC     0  2589   2588
2590       (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0134d24>] [<c0158ab8>] [<c0158bbb>]
[<c014c10d>] [<c0109a3f>]
Jul 12 10:42:54 server courierlocal  S 0000001C     8  2590   2588
2591  2589 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0158ab8>] [<c0158bbb>] [<c014c10d>]
[<c0109a3f>]
Jul 12 10:42:54 server courierfax    S E9DAFEFC     0  2591   2588
2592  2590 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0134d24>] [<c0158ab8>] [<c0158bbb>]
[<c014c10d>] [<c0109a3f>]
Jul 12 10:42:54 server courieresmtp  S C0270798     0  2592   2588  5034
2593  2591 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c011c8a5>] [<c01601cc>] [<c0160437>]
[<c016089d>] [<c0109a3f>]
Jul 12 10:42:54 server courierdsn    S E5D6FEFC  4224  2593   2588
2592 (NOTLB)
 Jul 12 10:42:54 server Call Trace:    [<c0134d24>] [<c0158ab8>]
[<c0158bbb>] [<c014c10d>] [<c0109a3f>]
Jul 12 10:42:54 server sh            S E71E8000     0  5024   1933  5027
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c012e35d>] [<c0125c94>] [<c012d630>]
[<c0109a3f>]
Jul 12 10:42:54 server ping          S F7332000  2388  5025   5024
5026       (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa91a178>] [<fa918444>] [<fa91a190>]
[<fa91a190>] [<fa9185e1>]
Jul 12 10:42:54 server [<c014b628>] [<fa91906f>] [<c0109a3f>]
Jul 12 10:42:54 server grep          S E71E8000    28  5026   5024
5027  5025 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa91a170>] [<fa9185e1>]
[<fa918e0a>] [<c0109a3f>]
Jul 12 10:42:54 server awk           S F6D34000  2384  5027   5024
5026 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S E9AF4000     0  5028   2170  5029
5031       (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F793A005     0  5029   5028
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005  2388  5030     51
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c01193cc>] [<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S E81B6000     0  5031   2170  5032
5039  5028 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     0  5032   5031
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server fcron         S F6FD2005     0  5033   2318
5035       (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c013b161>] [<c0109a3f>]
Jul 12 10:42:54 server courieresmtp  S F709E005     0  5034   2592
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server fcron         S F6FD2005     8  5035   2318
5036  5033 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0107cad>] [<c0109a3f>]
Jul 12 10:42:54 server fcron         S F6FD2005  2384  5036   2318
5038  5035 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0107cad>] [<c0109a3f>]
Jul 12 10:42:54 server fcron         S F6FD2005  2384  5038   2318
5042  5036 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0107cad>] [<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S DFF4C000  2384  5039   2170  5040
5046  5031 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
 Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     4  5040   5039
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertls    S F6FD2005  2384  5041   2295
5048       (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server fcron         S F6FD2005  2384  5042   2318
5168  5038 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0107cad>] [<c0109a3f>]
Jul 12 10:42:54 server smbd          S F6FD2013  2384  5043   2997
5044       (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0135b21>] [<c0135f12>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server smbd          S F6FD2013     4  5044   2997
5045  5043 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0135b21>] [<c0135f12>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server smbd          S F6FD2013     0  5045   2997
5179  5044 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0135b21>] [<c0135f12>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S E4C04000     8  5046   2170  5047
5049  5039 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     0  5047   5046
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertls    S F6FD2005  1716  5048   2295
5051  5041 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S E691A000     0  5049   2170  5050
5052  5046 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005   328  5050   5049
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertls    S F709E005   424  5051   2295
5054  5048 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S E6C02000     0  5052   2170  5053
5170  5049 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     0  5053   5052
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertls    S F6FD2005     0  5054   2295
5051 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server fcron         S F6FD2005     0  5168   2318
5169  5042 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0107cad>] [<c0109a3f>]
Jul 12 10:42:54 server fcron         S F6FD2005     0  5169   2318
5172  5168 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0107cad>] [<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S DF478000     0  5170   2170  5171
5174  5052 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     0  5171   5170
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server fcron         S F6FD2005     0  5172   2318
5173  5169 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0179815>] [<c0125e89>]
Jul 12 10:42:54 server [<c0107cad>] [<c0109a3f>]
Jul 12 10:42:54 server fcron         S F6FD2005     0  5173   2318
5176  5172 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0107cad>] [<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S DF376000     0  5174   2170  5175
5182  5170 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     0  5175   5174
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server fcron         S F709E005     0  5176   2318
5177  5173 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0107cad>] [<c0109a3f>]
Jul 12 10:42:54 server fcron         S F709E005     0  5177   2318
5178  5176 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0107cad>] [<c0109a3f>]
Jul 12 10:42:54 server fcron         S F709E005  2384  5178   2318
5177 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0107cad>] [<c0109a3f>]
Jul 12 10:42:54 server smbd          S F6FD2013  2384  5179   2997
5180  5045 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0135b21>] [<c0135f12>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server smbd          S F6FD2013     0  5180   2997
5181  5179 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0135b21>] [<c0135f12>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server smbd          S F6FD2013     0  5181   2997
5322  5180 (NOTLB)
 Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>]
[<fa918e0a>] [<c0135b21>] [<c0135f12>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S E0608000  2384  5182   2170  5183
5184  5174 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c01277c4>]
[<c01e3059>] [<c01e3ea4>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     0  5183   5182
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S E87B2000  2384  5184   2170  5185
5187  5182 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     0  5185   5184
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S E0320000  2384  5187   2170  5188
5189  5184 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     0  5188   5187
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S DFE8E000     4  5189   2170  5190
5310  5187 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     0  5190   5189
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c012b3d6>] [<c0109a3f>]
Jul 12 10:42:54 server httpd         S F709E005     0  5309   3111
5848 16325 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0136067>] [<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S E00E2000     0  5310   2170  5311
5312  5189 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005  2100  5311   5310
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c01193cc>] [<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S E55DE000     0  5312   2170  5313
5314  5310 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     0  5313   5312
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S E77D2000     0  5314   2170  5315
5316  5312 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     0  5315   5314
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S E085C000     0  5316   2170  5317
5318  5314 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     0  5317   5316
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S E8440000     0  5318   2170  5319
5320  5316 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     0  5319   5318
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S E7B5E000  2384  5320   2170  5321
5325  5318 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     0  5321   5320
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server smbd          S F6FD2013     0  5322   2997
5323  5181 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0135b21>] [<c0135f12>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server smbd          S F6FD2013     0  5323   2997
5324  5322 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0135b21>] [<c0135f12>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server smbd          S F709E013     0  5324   2997
5453  5323 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0135b21>] [<c0135f12>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S DF04C000     0  5325   2170  5326
5328  5320 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     0  5326   5325
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S EB504000  2384  5328   2170  5329
5446  5325 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     0  5329   5328
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S E414C000     0  5446   2170  5447
5448  5328 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     0  5447   5446
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S E0FEE000     4  5448   2170  5449
5450  5446 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005   144  5449   5448
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S DFD58000     0  5450   2170  5451
5456  5448 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     0  5451   5450
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server smbd          S F709E013     0  5453   2997
5454  5324 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0135b21>] [<c0135f12>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server smbd          S F709E013     0  5454   2997
5455  5453 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0135b21>] [<c0135f12>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server smbd          S F709E013     0  5455   2997
5591  5454 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0135b21>] [<c0135f12>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S E09EC000     0  5456   2170  5457
5458  5450 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     0  5457   5456
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S E54CC000   952  5458   2170  5459
5460  5456 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005   456  5459   5458
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S E5364000     0  5460   2170  5461
5462  5458 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c011b680>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     0  5461   5460
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S DE93C000     0  5462   2170  5463
5464  5460 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     0  5463   5462
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S E4066000     0  5464   2170  5465
5466  5462 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     0  5465   5464
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S E8E4E000  2384  5466   2170  5467
5584  5464 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     0  5467   5466
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S E0A58000     0  5584   2170  5585
5587  5466 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     0  5585   5584
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S E1336000     0  5587   2170  5588
5589  5584 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F6FD2005     0  5588   5587
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c012b3d6>] [<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S DEB2A000     0  5589   2170  5590
5711  5587 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01277c4>]
Jul 12 10:42:54 server [<c01e3059>] [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F6FD2005     0  5590   5589
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server smbd          S F709E013     0  5591   2997
5592  5455 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0135b21>] [<c0135f12>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server smbd          S F709E013     0  5592   2997
5593  5591 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0135b21>] [<c0135f12>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server smbd          S F709E013     0  5593   2997
5728  5592 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0135b21>] [<c0135f12>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S E5410000     0  5711   2170  5712
5713  5589 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01277c4>]
Jul 12 10:42:54 server [<c01e3059>] [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F6FD2005     0  5712   5711
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S DF7FE000     0  5713   2170  5714
5715  5711 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F6FD2005     0  5714   5713
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S DFE1A000     4  5715   2170  5716
5717  5713 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     4  5716   5715
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S E40E8000  2384  5717   2170  5718
5719  5715 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F6FD2005     0  5718   5717
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S DFC1A000     0  5719   2170  5720
5721  5717 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01277c4>]
Jul 12 10:42:54 server [<c01e3059>] [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F709E005     0  5720   5719
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S DF664000     0  5721   2170  5722
5723  5719 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F6FD2005     0  5722   5721
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S E13BA000     0  5723   2170  5724
5725  5721 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c01277c4>]
[<c01e3059>] [<c01e3ea4>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F6FD2005     0  5724   5723
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server couriertcpd   S C02CF800     0  5725   2170  5726
5723 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<c0125c94>] [<c0107d1d>] [<c0125fa7>]
[<c0109a3f>] [<c0130f5f>]
Jul 12 10:42:54 server [<c0130d80>] [<c023ac0f>] [<c01e2fd8>] [<c0130030>]
[<c0138b40>] [<c01e3059>]
Jul 12 10:42:54 server [<c01e3ea4>] [<c0109a3f>]
Jul 12 10:42:54 server modprobe      S F6FD2005     4  5726   5725
(NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0109a3f>]
Jul 12 10:42:54 server smbd          S F709E013  2384  5728   2997
5729  5593 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0135b21>] [<c0135f12>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server smbd          S F709E013     0  5729   2997
5730  5728 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0135b21>] [<c0135f12>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server smbd          S F709E013     0  5730   2997
5729 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c0135b21>] [<c0135f12>]
Jul 12 10:42:54 server [<c0109a3f>]
Jul 12 10:42:54 server httpd         S F6FD2005     0  5848   3111
5309 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa9185e1>] [<fa918e0a>]
[<c012b3d6>] [<c0109a3f>]
Jul 12 10:42:54 server shutdown      S F709E005     0  5856      1
1964 (NOTLB)
Jul 12 10:42:54 server Call Trace:    [<fa9182a9>] [<fa91a170>] [<fa9185e1>]
[<fa918e0a>] [<c0109a3f>]

Startup
Jul 12 01:06:33 server syslog-ng[246]: syslog-ng version 1.6.0rc3 going down
Jul 12 01:07:12 server syslog-ng[245]: syslog-ng version 1.6.0rc3 starting

Sign of the problem
Jul 12 07:12:51 server fcron[4063]: Job /etc/zorbiptraffic/zorbiptraffic.pl
> /dev/null started for user root (pid 4064) (This one worked)
Jul 12 07:32:51 server fcron[2318]:     process already running: root's
/etc/zorbiptraffic/zorbiptraffic.pl > /dev/null
Jul 12 08:02:51 server fcron[2318]:     process already running: root's
/etc/zorbiptraffic/zorbiptraffic.pl > /dev/null
Jul 12 08:30:00 server fcron[2318]:     process already running: jim's
/usr/bin/fetchmail
Jul 12 08:32:00 server fcron[2318]:     process already running: annie's
/usr/bin/fetchmail

Restart
Jul 12 10:43:38 server syslog-ng[245]: syslog-ng version 1.6.0rc3 starting
Jul 12 10:43:38 server syslog-ng[245]: Changing permissions on special file
/dev/tty12

Everything working
Jul 12 10:45:10 server fcron[2462]: Job /usr/bin/fetchmail started for user
annie (pid 2463)
Jul 12 10:45:40 server fcron[2462]: Job /usr/bin/fetchmail terminated (exit
status: 1)
Jul 12 10:45:41 server fcron[2515]: Job /usr/bin/fetchmail started for user
annie (pid 2516)
Jul 12 10:47:28 server fcron[3606]: Job /etc/zorbiptraffic/zorbiptraffic.pl
> /dev/null started for user root (pid 3607)
Jul 12 10:49:14 server fcron[3653]: Job /etc/zorbiptraffic/zorbiptraffic.pl
> /dev/null started for user root (pid 3654)
Jul 12 11:00:02 server fcron[4270]: Job /etc/zorbiptraffic/zorbiptraffic.pl
> /dev/null started for user root (pid 4272)
Jul 12 11:00:02 server fcron[4271]: Job /usr/bin/fetchmail started for user
jim (pid 4273)
Jul 12 11:00:13 server fcron[4271]: Job /usr/bin/fetchmail terminated (exit
status: 1)

ver_linux
Linux server 2.4.22-pre5 #1 SMP Fri Jul 11 23:38:00 PDT 2003 i686 unknown
unknown GNU/Linux

Gnu C                  3.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.25
e2fsprogs              1.33
PPP                    2.4.1
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.4
Procps                 3.1.9
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         dazuko ipt_TCPMSS ipt_TOS ipt_string ipt_psd
ipt_pkttype ipt_unclean ipt_state ipt_REJECT ipt_LOG ipt_limit
iptable_mangle iptable_nat iptable_filter ip_tables ip_conntrack_h323
ip_conntrack_mms ip_conntrack_irc ip_conntrack_ftp ip_conntrack tulip rtc
usb-ohci usbcore aic7xxx megaraid sd_mod scsi_mod

My config is attached.


----- Original Message ----- 
From: "Marcelo Tosatti" <marcelo@conectiva.com.br>
To: "Jim Gifford" <maillist@jg555.com>
Cc: "lkml" <linux-kernel@vger.kernel.org>
Sent: Friday, July 11, 2003 1:49 PM
Subject: Re: Linux 2.4.22-pre3


>
>
> On Fri, 11 Jul 2003, Jim Gifford wrote:
>
> > Ok,
> >     Here is what I got from my check. Snort is the culprit. When it
starts,
> > it runs at 40mb. Each hour it adds 20 mb. So by the time the system is
up
> > for hours, it starts cosuming memory. Today after I restartd my system,
I
> > noticed every hour it was adding a mb of RAM.
> >
> > It started at 40mb and after 4 hours is up to 45mb.
> >
> > Thanx all for your help and assistance.
>
> Ok, thanks for your report.
>
> Try -pre5 8)
>

------=_NextPart_000_0015_01C34865.EF067360
Content-Type: application/octet-stream;
	name="config"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="config"

#=0A=
# Automatically generated by make menuconfig: don't edit=0A=
#=0A=
CONFIG_X86=3Dy=0A=
# CONFIG_SBUS is not set=0A=
CONFIG_UID16=3Dy=0A=
=0A=
#=0A=
# Code maturity level options=0A=
#=0A=
CONFIG_EXPERIMENTAL=3Dy=0A=
=0A=
#=0A=
# Loadable module support=0A=
#=0A=
CONFIG_MODULES=3Dy=0A=
CONFIG_MODVERSIONS=3Dy=0A=
CONFIG_KMOD=3Dy=0A=
=0A=
#=0A=
# Processor type and features=0A=
#=0A=
# CONFIG_M386 is not set=0A=
# CONFIG_M486 is not set=0A=
# CONFIG_M586 is not set=0A=
# CONFIG_M586TSC is not set=0A=
# CONFIG_M586MMX is not set=0A=
CONFIG_M686=3Dy=0A=
# CONFIG_MPENTIUMIII is not set=0A=
# CONFIG_MPENTIUM4 is not set=0A=
# CONFIG_MK6 is not set=0A=
# CONFIG_MK7 is not set=0A=
# CONFIG_MK8 is not set=0A=
# CONFIG_MELAN is not set=0A=
# CONFIG_MCRUSOE is not set=0A=
# CONFIG_MWINCHIPC6 is not set=0A=
# CONFIG_MWINCHIP2 is not set=0A=
# CONFIG_MWINCHIP3D is not set=0A=
# CONFIG_MCYRIXIII is not set=0A=
# CONFIG_MVIAC3_2 is not set=0A=
CONFIG_X86_WP_WORKS_OK=3Dy=0A=
CONFIG_X86_INVLPG=3Dy=0A=
CONFIG_X86_CMPXCHG=3Dy=0A=
CONFIG_X86_XADD=3Dy=0A=
CONFIG_X86_BSWAP=3Dy=0A=
CONFIG_X86_POPAD_OK=3Dy=0A=
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set=0A=
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy=0A=
CONFIG_X86_L1_CACHE_SHIFT=3D5=0A=
CONFIG_X86_HAS_TSC=3Dy=0A=
CONFIG_X86_GOOD_APIC=3Dy=0A=
CONFIG_X86_PGE=3Dy=0A=
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy=0A=
CONFIG_X86_PPRO_FENCE=3Dy=0A=
CONFIG_X86_F00F_WORKS_OK=3Dy=0A=
CONFIG_X86_MCE=3Dy=0A=
# CONFIG_TOSHIBA is not set=0A=
# CONFIG_I8K is not set=0A=
CONFIG_MICROCODE=3Dy=0A=
CONFIG_X86_MSR=3Dy=0A=
CONFIG_X86_CPUID=3Dy=0A=
# CONFIG_NOHIGHMEM is not set=0A=
CONFIG_HIGHMEM4G=3Dy=0A=
# CONFIG_HIGHMEM64G is not set=0A=
CONFIG_HIGHMEM=3Dy=0A=
CONFIG_HIGHIO=3Dy=0A=
# CONFIG_MATH_EMULATION is not set=0A=
CONFIG_MTRR=3Dy=0A=
CONFIG_SMP=3Dy=0A=
# CONFIG_X86_NUMA is not set=0A=
# CONFIG_X86_TSC_DISABLE is not set=0A=
CONFIG_X86_TSC=3Dy=0A=
CONFIG_HAVE_DEC_LOCK=3Dy=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
CONFIG_NET=3Dy=0A=
CONFIG_X86_IO_APIC=3Dy=0A=
CONFIG_X86_LOCAL_APIC=3Dy=0A=
CONFIG_PCI=3Dy=0A=
# CONFIG_PCI_GOBIOS is not set=0A=
# CONFIG_PCI_GODIRECT is not set=0A=
CONFIG_PCI_GOANY=3Dy=0A=
CONFIG_PCI_BIOS=3Dy=0A=
CONFIG_PCI_DIRECT=3Dy=0A=
CONFIG_ISA=3Dy=0A=
CONFIG_PCI_NAMES=3Dy=0A=
CONFIG_EISA=3Dy=0A=
# CONFIG_MCA is not set=0A=
CONFIG_HOTPLUG=3Dy=0A=
=0A=
#=0A=
# PCMCIA/CardBus support=0A=
#=0A=
# CONFIG_PCMCIA is not set=0A=
=0A=
#=0A=
# PCI Hotplug Support=0A=
#=0A=
# CONFIG_HOTPLUG_PCI is not set=0A=
# CONFIG_HOTPLUG_PCI_COMPAQ is not set=0A=
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set=0A=
# CONFIG_HOTPLUG_PCI_IBM is not set=0A=
# CONFIG_HOTPLUG_PCI_ACPI is not set=0A=
CONFIG_SYSVIPC=3Dy=0A=
# CONFIG_BSD_PROCESS_ACCT is not set=0A=
CONFIG_SYSCTL=3Dy=0A=
CONFIG_KCORE_ELF=3Dy=0A=
# CONFIG_KCORE_AOUT is not set=0A=
CONFIG_BINFMT_AOUT=3Dm=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
CONFIG_BINFMT_MISC=3Dm=0A=
# CONFIG_PM is not set=0A=
# CONFIG_APM is not set=0A=
=0A=
#=0A=
# ACPI Support=0A=
#=0A=
# CONFIG_ACPI is not set=0A=
=0A=
#=0A=
# Memory Technology Devices (MTD)=0A=
#=0A=
# CONFIG_MTD is not set=0A=
=0A=
#=0A=
# Parallel port support=0A=
#=0A=
CONFIG_PARPORT=3Dm=0A=
CONFIG_PARPORT_PC=3Dm=0A=
CONFIG_PARPORT_PC_CML1=3Dm=0A=
# CONFIG_PARPORT_SERIAL is not set=0A=
CONFIG_PARPORT_PC_FIFO=3Dy=0A=
CONFIG_PARPORT_PC_SUPERIO=3Dy=0A=
# CONFIG_PARPORT_AMIGA is not set=0A=
# CONFIG_PARPORT_MFC3 is not set=0A=
# CONFIG_PARPORT_ATARI is not set=0A=
# CONFIG_PARPORT_GSC is not set=0A=
# CONFIG_PARPORT_SUNBPP is not set=0A=
# CONFIG_PARPORT_OTHER is not set=0A=
CONFIG_PARPORT_1284=3Dy=0A=
=0A=
#=0A=
# Plug and Play configuration=0A=
#=0A=
CONFIG_PNP=3Dy=0A=
CONFIG_ISAPNP=3Dy=0A=
=0A=
#=0A=
# Block devices=0A=
#=0A=
CONFIG_BLK_DEV_FD=3Dm=0A=
# CONFIG_BLK_DEV_XD is not set=0A=
# CONFIG_PARIDE is not set=0A=
# CONFIG_BLK_CPQ_DA is not set=0A=
# CONFIG_BLK_CPQ_CISS_DA is not set=0A=
# CONFIG_CISS_SCSI_TAPE is not set=0A=
# CONFIG_BLK_DEV_DAC960 is not set=0A=
# CONFIG_BLK_DEV_UMEM is not set=0A=
CONFIG_BLK_DEV_LOOP=3Dm=0A=
# CONFIG_BLK_DEV_NBD is not set=0A=
CONFIG_BLK_DEV_RAM=3Dy=0A=
CONFIG_BLK_DEV_RAM_SIZE=3D4096=0A=
CONFIG_BLK_DEV_INITRD=3Dy=0A=
CONFIG_BLK_STATS=3Dy=0A=
=0A=
#=0A=
# Multi-device support (RAID and LVM)=0A=
#=0A=
# CONFIG_MD is not set=0A=
# CONFIG_BLK_DEV_MD is not set=0A=
# CONFIG_MD_LINEAR is not set=0A=
# CONFIG_MD_RAID0 is not set=0A=
# CONFIG_MD_RAID1 is not set=0A=
# CONFIG_MD_RAID5 is not set=0A=
# CONFIG_MD_MULTIPATH is not set=0A=
# CONFIG_BLK_DEV_LVM is not set=0A=
=0A=
#=0A=
# Networking options=0A=
#=0A=
CONFIG_PACKET=3Dy=0A=
CONFIG_PACKET_MMAP=3Dy=0A=
# CONFIG_NETLINK_DEV is not set=0A=
CONFIG_NETFILTER=3Dy=0A=
# CONFIG_NETFILTER_DEBUG is not set=0A=
CONFIG_FILTER=3Dy=0A=
CONFIG_UNIX=3Dy=0A=
CONFIG_INET=3Dy=0A=
CONFIG_IP_MULTICAST=3Dy=0A=
# CONFIG_IP_ADVANCED_ROUTER is not set=0A=
# CONFIG_IP_PNP is not set=0A=
# CONFIG_NET_IPIP is not set=0A=
# CONFIG_NET_IPGRE is not set=0A=
# CONFIG_IP_MROUTE is not set=0A=
# CONFIG_ARPD is not set=0A=
CONFIG_INET_ECN=3Dy=0A=
CONFIG_SYN_COOKIES=3Dy=0A=
=0A=
#=0A=
#   IP: Netfilter Configuration=0A=
#=0A=
CONFIG_IP_NF_CONNTRACK=3Dm=0A=
CONFIG_IP_NF_FTP=3Dm=0A=
CONFIG_IP_NF_TALK=3Dm=0A=
CONFIG_IP_NF_H323=3Dm=0A=
CONFIG_IP_NF_EGG=3Dm=0A=
CONFIG_IP_NF_AMANDA=3Dm=0A=
CONFIG_IP_NF_TFTP=3Dm=0A=
CONFIG_IP_NF_IRC=3Dm=0A=
CONFIG_IP_NF_QUAKE3=3Dm=0A=
CONFIG_IP_NF_CT_PROTO_GRE=3Dm=0A=
CONFIG_IP_NF_PPTP=3Dm=0A=
CONFIG_IP_NF_MMS=3Dm=0A=
CONFIG_IP_NF_CUSEEME=3Dm=0A=
CONFIG_IP_NF_QUEUE=3Dm=0A=
CONFIG_IP_NF_IPTABLES=3Dm=0A=
CONFIG_IP_NF_MATCH_LIMIT=3Dm=0A=
CONFIG_IP_NF_MATCH_QUOTA=3Dm=0A=
CONFIG_IP_NF_MATCH_IPRANGE=3Dm=0A=
CONFIG_IP_NF_MATCH_MAC=3Dm=0A=
CONFIG_IP_NF_MATCH_PKTTYPE=3Dm=0A=
CONFIG_IP_NF_MATCH_MARK=3Dm=0A=
CONFIG_IP_NF_MATCH_MULTIPORT=3Dm=0A=
CONFIG_IP_NF_MATCH_MPORT=3Dm=0A=
CONFIG_IP_NF_MATCH_TOS=3Dm=0A=
CONFIG_IP_NF_MATCH_CONDITION=3Dm=0A=
CONFIG_IP_NF_MATCH_RANDOM=3Dm=0A=
CONFIG_IP_NF_MATCH_PSD=3Dm=0A=
CONFIG_IP_NF_MATCH_NTH=3Dm=0A=
CONFIG_IP_NF_MATCH_FUZZY=3Dm=0A=
CONFIG_IP_NF_MATCH_RECENT=3Dm=0A=
CONFIG_IP_NF_MATCH_ECN=3Dm=0A=
CONFIG_IP_NF_MATCH_DSCP=3Dm=0A=
CONFIG_IP_NF_MATCH_AH_ESP=3Dm=0A=
CONFIG_IP_NF_MATCH_LENGTH=3Dm=0A=
CONFIG_IP_NF_MATCH_TTL=3Dm=0A=
CONFIG_IP_NF_MATCH_TCPMSS=3Dm=0A=
CONFIG_IP_NF_MATCH_HELPER=3Dm=0A=
CONFIG_IP_NF_MATCH_STATE=3Dm=0A=
CONFIG_IP_NF_MATCH_CONNLIMIT=3Dm=0A=
CONFIG_IP_NF_MATCH_CONNTRACK=3Dm=0A=
CONFIG_IP_NF_MATCH_UNCLEAN=3Dm=0A=
CONFIG_IP_NF_MATCH_STRING=3Dm=0A=
CONFIG_IP_NF_MATCH_OWNER=3Dm=0A=
CONFIG_IP_NF_FILTER=3Dm=0A=
CONFIG_IP_NF_TARGET_REJECT=3Dm=0A=
CONFIG_IP_NF_TARGET_NETLINK=3Dm=0A=
CONFIG_IP_NF_TARGET_MIRROR=3Dm=0A=
CONFIG_IP_NF_NAT=3Dm=0A=
CONFIG_IP_NF_NAT_NEEDED=3Dy=0A=
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm=0A=
CONFIG_IP_NF_TARGET_REDIRECT=3Dm=0A=
CONFIG_IP_NF_NAT_TALK=3Dm=0A=
CONFIG_IP_NF_NAT_H323=3Dm=0A=
CONFIG_IP_NF_NAT_PPTP=3Dm=0A=
CONFIG_IP_NF_NAT_PROTO_GRE=3Dm=0A=
CONFIG_IP_NF_NAT_AMANDA=3Dm=0A=
# CONFIG_IP_NF_NAT_LOCAL is not set=0A=
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set=0A=
CONFIG_IP_NF_NAT_IRC=3Dm=0A=
CONFIG_IP_NF_NAT_QUAKE3=3Dm=0A=
CONFIG_IP_NF_NAT_MMS=3Dm=0A=
CONFIG_IP_NF_NAT_CUSEEME=3Dm=0A=
CONFIG_IP_NF_NAT_FTP=3Dm=0A=
CONFIG_IP_NF_NAT_TFTP=3Dm=0A=
CONFIG_IP_NF_MANGLE=3Dm=0A=
CONFIG_IP_NF_TARGET_TOS=3Dm=0A=
CONFIG_IP_NF_TARGET_ECN=3Dm=0A=
CONFIG_IP_NF_TARGET_DSCP=3Dm=0A=
CONFIG_IP_NF_TARGET_MARK=3Dm=0A=
CONFIG_IP_NF_TARGET_LOG=3Dm=0A=
CONFIG_IP_NF_TARGET_TTL=3Dm=0A=
CONFIG_IP_NF_TARGET_ULOG=3Dm=0A=
CONFIG_IP_NF_TARGET_TCPMSS=3Dm=0A=
CONFIG_IP_NF_ARPTABLES=3Dm=0A=
CONFIG_IP_NF_ARPFILTER=3Dm=0A=
CONFIG_IP_NF_ARP_MANGLE=3Dm=0A=
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set=0A=
# CONFIG_IP_NF_COMPAT_IPFWADM is not set=0A=
# CONFIG_IPV6 is not set=0A=
# CONFIG_KHTTPD is not set=0A=
# CONFIG_ATM is not set=0A=
# CONFIG_VLAN_8021Q is not set=0A=
# CONFIG_IPX is not set=0A=
# CONFIG_ATALK is not set=0A=
=0A=
#=0A=
# Appletalk devices=0A=
#=0A=
# CONFIG_DEV_APPLETALK is not set=0A=
# CONFIG_DECNET is not set=0A=
# CONFIG_BRIDGE is not set=0A=
# CONFIG_X25 is not set=0A=
# CONFIG_LAPB is not set=0A=
# CONFIG_LLC is not set=0A=
# CONFIG_NET_DIVERT is not set=0A=
# CONFIG_ECONET is not set=0A=
# CONFIG_WAN_ROUTER is not set=0A=
# CONFIG_NET_FASTROUTE is not set=0A=
# CONFIG_NET_HW_FLOWCONTROL is not set=0A=
=0A=
#=0A=
# QoS and/or fair queueing=0A=
#=0A=
# CONFIG_NET_SCHED is not set=0A=
=0A=
#=0A=
# Network testing=0A=
#=0A=
# CONFIG_NET_PKTGEN is not set=0A=
=0A=
#=0A=
# Telephony Support=0A=
#=0A=
# CONFIG_PHONE is not set=0A=
# CONFIG_PHONE_IXJ is not set=0A=
# CONFIG_PHONE_IXJ_PCMCIA is not set=0A=
=0A=
#=0A=
# ATA/IDE/MFM/RLL support=0A=
#=0A=
# CONFIG_IDE is not set=0A=
# CONFIG_BLK_DEV_IDE_MODES is not set=0A=
# CONFIG_BLK_DEV_HD is not set=0A=
=0A=
#=0A=
# SCSI support=0A=
#=0A=
CONFIG_SCSI=3Dm=0A=
CONFIG_BLK_DEV_SD=3Dm=0A=
CONFIG_SD_EXTRA_DEVS=3D40=0A=
CONFIG_CHR_DEV_ST=3Dm=0A=
# CONFIG_CHR_DEV_OSST is not set=0A=
CONFIG_BLK_DEV_SR=3Dm=0A=
CONFIG_BLK_DEV_SR_VENDOR=3Dy=0A=
CONFIG_SR_EXTRA_DEVS=3D2=0A=
CONFIG_CHR_DEV_SG=3Dm=0A=
CONFIG_SCSI_DEBUG_QUEUES=3Dy=0A=
CONFIG_SCSI_MULTI_LUN=3Dy=0A=
# CONFIG_SCSI_CONSTANTS is not set=0A=
# CONFIG_SCSI_LOGGING is not set=0A=
=0A=
#=0A=
# SCSI low-level drivers=0A=
#=0A=
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set=0A=
# CONFIG_SCSI_7000FASST is not set=0A=
# CONFIG_SCSI_ACARD is not set=0A=
# CONFIG_SCSI_AHA152X is not set=0A=
# CONFIG_SCSI_AHA1542 is not set=0A=
# CONFIG_SCSI_AHA1740 is not set=0A=
# CONFIG_SCSI_AACRAID is not set=0A=
CONFIG_SCSI_AIC7XXX=3Dm=0A=
CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D253=0A=
CONFIG_AIC7XXX_RESET_DELAY_MS=3D15000=0A=
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set=0A=
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set=0A=
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set=0A=
CONFIG_AIC7XXX_DEBUG_MASK=3D0=0A=
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set=0A=
# CONFIG_SCSI_AIC79XX is not set=0A=
# CONFIG_SCSI_AIC7XXX_OLD is not set=0A=
# CONFIG_SCSI_DPT_I2O is not set=0A=
# CONFIG_SCSI_ADVANSYS is not set=0A=
# CONFIG_SCSI_IN2000 is not set=0A=
# CONFIG_SCSI_AM53C974 is not set=0A=
CONFIG_SCSI_MEGARAID=3Dm=0A=
# CONFIG_SCSI_BUSLOGIC is not set=0A=
# CONFIG_SCSI_CPQFCTS is not set=0A=
# CONFIG_SCSI_DMX3191D is not set=0A=
# CONFIG_SCSI_DTC3280 is not set=0A=
# CONFIG_SCSI_EATA is not set=0A=
# CONFIG_SCSI_EATA_DMA is not set=0A=
# CONFIG_SCSI_EATA_PIO is not set=0A=
# CONFIG_SCSI_FUTURE_DOMAIN is not set=0A=
# CONFIG_SCSI_GDTH is not set=0A=
# CONFIG_SCSI_GENERIC_NCR5380 is not set=0A=
# CONFIG_SCSI_IPS is not set=0A=
# CONFIG_SCSI_INITIO is not set=0A=
# CONFIG_SCSI_INIA100 is not set=0A=
# CONFIG_SCSI_PPA is not set=0A=
# CONFIG_SCSI_IMM is not set=0A=
# CONFIG_SCSI_NCR53C406A is not set=0A=
# CONFIG_SCSI_NCR53C7xx is not set=0A=
# CONFIG_SCSI_SYM53C8XX_2 is not set=0A=
# CONFIG_SCSI_NCR53C8XX is not set=0A=
# CONFIG_SCSI_SYM53C8XX is not set=0A=
# CONFIG_SCSI_PAS16 is not set=0A=
# CONFIG_SCSI_PCI2000 is not set=0A=
# CONFIG_SCSI_PCI2220I is not set=0A=
# CONFIG_SCSI_PSI240I is not set=0A=
# CONFIG_SCSI_QLOGIC_FAS is not set=0A=
# CONFIG_SCSI_QLOGIC_ISP is not set=0A=
# CONFIG_SCSI_QLOGIC_FC is not set=0A=
# CONFIG_SCSI_QLOGIC_1280 is not set=0A=
# CONFIG_SCSI_SEAGATE is not set=0A=
# CONFIG_SCSI_SIM710 is not set=0A=
# CONFIG_SCSI_SYM53C416 is not set=0A=
# CONFIG_SCSI_DC390T is not set=0A=
# CONFIG_SCSI_T128 is not set=0A=
# CONFIG_SCSI_U14_34F is not set=0A=
# CONFIG_SCSI_ULTRASTOR is not set=0A=
# CONFIG_SCSI_NSP32 is not set=0A=
# CONFIG_SCSI_DEBUG is not set=0A=
=0A=
#=0A=
# Fusion MPT device support=0A=
#=0A=
# CONFIG_FUSION is not set=0A=
# CONFIG_FUSION_BOOT is not set=0A=
# CONFIG_FUSION_ISENSE is not set=0A=
# CONFIG_FUSION_CTL is not set=0A=
# CONFIG_FUSION_LAN is not set=0A=
=0A=
#=0A=
# IEEE 1394 (FireWire) support (EXPERIMENTAL)=0A=
#=0A=
# CONFIG_IEEE1394 is not set=0A=
=0A=
#=0A=
# I2O device support=0A=
#=0A=
# CONFIG_I2O is not set=0A=
# CONFIG_I2O_PCI is not set=0A=
# CONFIG_I2O_BLOCK is not set=0A=
# CONFIG_I2O_LAN is not set=0A=
# CONFIG_I2O_SCSI is not set=0A=
# CONFIG_I2O_PROC is not set=0A=
=0A=
#=0A=
# Network device support=0A=
#=0A=
CONFIG_NETDEVICES=3Dy=0A=
=0A=
#=0A=
# ARCnet devices=0A=
#=0A=
# CONFIG_ARCNET is not set=0A=
CONFIG_DUMMY=3Dm=0A=
# CONFIG_BONDING is not set=0A=
# CONFIG_EQUALIZER is not set=0A=
# CONFIG_TUN is not set=0A=
# CONFIG_ETHERTAP is not set=0A=
# CONFIG_NET_SB1000 is not set=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
CONFIG_NET_ETHERNET=3Dy=0A=
# CONFIG_SUNLANCE is not set=0A=
# CONFIG_HAPPYMEAL is not set=0A=
# CONFIG_SUNBMAC is not set=0A=
# CONFIG_SUNQE is not set=0A=
# CONFIG_SUNGEM is not set=0A=
# CONFIG_NET_VENDOR_3COM is not set=0A=
# CONFIG_LANCE is not set=0A=
# CONFIG_NET_VENDOR_SMC is not set=0A=
# CONFIG_NET_VENDOR_RACAL is not set=0A=
# CONFIG_AT1700 is not set=0A=
# CONFIG_DEPCA is not set=0A=
# CONFIG_HP100 is not set=0A=
# CONFIG_NET_ISA is not set=0A=
CONFIG_NET_PCI=3Dy=0A=
# CONFIG_PCNET32 is not set=0A=
# CONFIG_AMD8111_ETH is not set=0A=
# CONFIG_ADAPTEC_STARFIRE is not set=0A=
# CONFIG_AC3200 is not set=0A=
# CONFIG_APRICOT is not set=0A=
# CONFIG_CS89x0 is not set=0A=
CONFIG_TULIP=3Dm=0A=
CONFIG_TULIP_MWI=3Dy=0A=
CONFIG_TULIP_MMIO=3Dy=0A=
# CONFIG_DE4X5 is not set=0A=
# CONFIG_DGRS is not set=0A=
# CONFIG_DM9102 is not set=0A=
# CONFIG_EEPRO100 is not set=0A=
# CONFIG_EEPRO100_PIO is not set=0A=
# CONFIG_E100 is not set=0A=
# CONFIG_LNE390 is not set=0A=
# CONFIG_FEALNX is not set=0A=
# CONFIG_NATSEMI is not set=0A=
# CONFIG_NE2K_PCI is not set=0A=
# CONFIG_NE3210 is not set=0A=
# CONFIG_ES3210 is not set=0A=
# CONFIG_8139CP is not set=0A=
# CONFIG_8139TOO is not set=0A=
# CONFIG_8139TOO_PIO is not set=0A=
# CONFIG_8139TOO_TUNE_TWISTER is not set=0A=
# CONFIG_8139TOO_8129 is not set=0A=
# CONFIG_8139_OLD_RX_RESET is not set=0A=
# CONFIG_SIS900 is not set=0A=
# CONFIG_EPIC100 is not set=0A=
# CONFIG_SUNDANCE is not set=0A=
# CONFIG_SUNDANCE_MMIO is not set=0A=
# CONFIG_TLAN is not set=0A=
# CONFIG_TC35815 is not set=0A=
# CONFIG_VIA_RHINE is not set=0A=
# CONFIG_VIA_RHINE_MMIO is not set=0A=
# CONFIG_WINBOND_840 is not set=0A=
# CONFIG_NET_POCKET is not set=0A=
=0A=
#=0A=
# Ethernet (1000 Mbit)=0A=
#=0A=
# CONFIG_ACENIC is not set=0A=
# CONFIG_DL2K is not set=0A=
# CONFIG_E1000 is not set=0A=
# CONFIG_MYRI_SBUS is not set=0A=
# CONFIG_NS83820 is not set=0A=
# CONFIG_HAMACHI is not set=0A=
# CONFIG_YELLOWFIN is not set=0A=
# CONFIG_R8169 is not set=0A=
# CONFIG_SK98LIN is not set=0A=
# CONFIG_TIGON3 is not set=0A=
# CONFIG_FDDI is not set=0A=
# CONFIG_HIPPI is not set=0A=
# CONFIG_PLIP is not set=0A=
CONFIG_PPP=3Dm=0A=
# CONFIG_PPP_MULTILINK is not set=0A=
CONFIG_PPP_FILTER=3Dy=0A=
CONFIG_PPP_ASYNC=3Dm=0A=
# CONFIG_PPP_SYNC_TTY is not set=0A=
CONFIG_PPP_DEFLATE=3Dm=0A=
CONFIG_PPP_BSDCOMP=3Dm=0A=
# CONFIG_PPPOE is not set=0A=
# CONFIG_SLIP is not set=0A=
=0A=
#=0A=
# Wireless LAN (non-hamradio)=0A=
#=0A=
# CONFIG_NET_RADIO is not set=0A=
=0A=
#=0A=
# Token Ring devices=0A=
#=0A=
# CONFIG_TR is not set=0A=
# CONFIG_NET_FC is not set=0A=
# CONFIG_RCPCI is not set=0A=
# CONFIG_SHAPER is not set=0A=
=0A=
#=0A=
# Wan interfaces=0A=
#=0A=
# CONFIG_WAN is not set=0A=
=0A=
#=0A=
# Amateur Radio support=0A=
#=0A=
# CONFIG_HAMRADIO is not set=0A=
=0A=
#=0A=
# IrDA (infrared) support=0A=
#=0A=
# CONFIG_IRDA is not set=0A=
=0A=
#=0A=
# ISDN subsystem=0A=
#=0A=
# CONFIG_ISDN is not set=0A=
=0A=
#=0A=
# Old CD-ROM drivers (not SCSI, not IDE)=0A=
#=0A=
# CONFIG_CD_NO_IDESCSI is not set=0A=
=0A=
#=0A=
# Input core support=0A=
#=0A=
CONFIG_INPUT=3Dm=0A=
CONFIG_INPUT_KEYBDEV=3Dm=0A=
CONFIG_INPUT_MOUSEDEV=3Dm=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768=0A=
CONFIG_INPUT_JOYDEV=3Dm=0A=
CONFIG_INPUT_EVDEV=3Dm=0A=
=0A=
#=0A=
# Character devices=0A=
#=0A=
CONFIG_VT=3Dy=0A=
CONFIG_VT_CONSOLE=3Dy=0A=
CONFIG_SERIAL=3Dy=0A=
# CONFIG_SERIAL_CONSOLE is not set=0A=
# CONFIG_SERIAL_EXTENDED is not set=0A=
# CONFIG_SERIAL_NONSTANDARD is not set=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
CONFIG_UNIX98_PTY_COUNT=3D256=0A=
# CONFIG_PRINTER is not set=0A=
# CONFIG_PPDEV is not set=0A=
# CONFIG_TIPAR is not set=0A=
=0A=
#=0A=
# I2C support=0A=
#=0A=
# CONFIG_I2C is not set=0A=
=0A=
#=0A=
# Mice=0A=
#=0A=
# CONFIG_BUSMOUSE is not set=0A=
CONFIG_MOUSE=3Dm=0A=
CONFIG_PSMOUSE=3Dy=0A=
# CONFIG_82C710_MOUSE is not set=0A=
# CONFIG_PC110_PAD is not set=0A=
# CONFIG_MK712_MOUSE is not set=0A=
=0A=
#=0A=
# Joysticks=0A=
#=0A=
CONFIG_INPUT_GAMEPORT=3Dm=0A=
CONFIG_INPUT_NS558=3Dm=0A=
# CONFIG_INPUT_LIGHTNING is not set=0A=
# CONFIG_INPUT_PCIGAME is not set=0A=
# CONFIG_INPUT_CS461X is not set=0A=
# CONFIG_INPUT_EMU10K1 is not set=0A=
# CONFIG_INPUT_SERIO is not set=0A=
# CONFIG_INPUT_SERPORT is not set=0A=
CONFIG_INPUT_ANALOG=3Dm=0A=
# CONFIG_INPUT_A3D is not set=0A=
# CONFIG_INPUT_ADI is not set=0A=
# CONFIG_INPUT_COBRA is not set=0A=
# CONFIG_INPUT_GF2K is not set=0A=
# CONFIG_INPUT_GRIP is not set=0A=
# CONFIG_INPUT_INTERACT is not set=0A=
# CONFIG_INPUT_TMDC is not set=0A=
# CONFIG_INPUT_SIDEWINDER is not set=0A=
# CONFIG_INPUT_IFORCE_USB is not set=0A=
# CONFIG_INPUT_IFORCE_232 is not set=0A=
# CONFIG_INPUT_WARRIOR is not set=0A=
# CONFIG_INPUT_MAGELLAN is not set=0A=
# CONFIG_INPUT_SPACEORB is not set=0A=
# CONFIG_INPUT_SPACEBALL is not set=0A=
# CONFIG_INPUT_STINGER is not set=0A=
# CONFIG_INPUT_DB9 is not set=0A=
# CONFIG_INPUT_GAMECON is not set=0A=
# CONFIG_INPUT_TURBOGRAFX is not set=0A=
# CONFIG_QIC02_TAPE is not set=0A=
# CONFIG_IPMI_HANDLER is not set=0A=
# CONFIG_IPMI_PANIC_EVENT is not set=0A=
# CONFIG_IPMI_DEVICE_INTERFACE is not set=0A=
# CONFIG_IPMI_KCS is not set=0A=
# CONFIG_IPMI_WATCHDOG is not set=0A=
=0A=
#=0A=
# Watchdog Cards=0A=
#=0A=
CONFIG_WATCHDOG=3Dy=0A=
# CONFIG_WATCHDOG_NOWAYOUT is not set=0A=
# CONFIG_ACQUIRE_WDT is not set=0A=
# CONFIG_ADVANTECH_WDT is not set=0A=
# CONFIG_ALIM1535_WDT is not set=0A=
# CONFIG_ALIM7101_WDT is not set=0A=
# CONFIG_SC520_WDT is not set=0A=
# CONFIG_PCWATCHDOG is not set=0A=
# CONFIG_EUROTECH_WDT is not set=0A=
# CONFIG_IB700_WDT is not set=0A=
# CONFIG_WAFER_WDT is not set=0A=
# CONFIG_I810_TCO is not set=0A=
# CONFIG_MIXCOMWD is not set=0A=
# CONFIG_60XX_WDT is not set=0A=
# CONFIG_SC1200_WDT is not set=0A=
# CONFIG_SCx200_WDT is not set=0A=
CONFIG_SOFT_WATCHDOG=3Dm=0A=
# CONFIG_W83877F_WDT is not set=0A=
# CONFIG_WDT is not set=0A=
# CONFIG_WDTPCI is not set=0A=
# CONFIG_MACHZ_WDT is not set=0A=
# CONFIG_AMD7XX_TCO is not set=0A=
# CONFIG_SCx200_GPIO is not set=0A=
# CONFIG_AMD_RNG is not set=0A=
# CONFIG_INTEL_RNG is not set=0A=
# CONFIG_AMD_PM768 is not set=0A=
CONFIG_NVRAM=3Dm=0A=
CONFIG_RTC=3Dm=0A=
# CONFIG_DTLK is not set=0A=
# CONFIG_R3964 is not set=0A=
# CONFIG_APPLICOM is not set=0A=
# CONFIG_SONYPI is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
# CONFIG_FTAPE is not set=0A=
# CONFIG_AGP is not set=0A=
# CONFIG_DRM is not set=0A=
# CONFIG_MWAVE is not set=0A=
=0A=
#=0A=
# Multimedia devices=0A=
#=0A=
CONFIG_VIDEO_DEV=3Dm=0A=
=0A=
#=0A=
# Video For Linux=0A=
#=0A=
CONFIG_VIDEO_PROC_FS=3Dy=0A=
# CONFIG_I2C_PARPORT is not set=0A=
# CONFIG_VIDEO_BT848 is not set=0A=
# CONFIG_VIDEO_PMS is not set=0A=
# CONFIG_VIDEO_BWQCAM is not set=0A=
# CONFIG_VIDEO_CQCAM is not set=0A=
# CONFIG_VIDEO_W9966 is not set=0A=
# CONFIG_VIDEO_CPIA is not set=0A=
# CONFIG_VIDEO_SAA5249 is not set=0A=
# CONFIG_TUNER_3036 is not set=0A=
# CONFIG_VIDEO_STRADIS is not set=0A=
# CONFIG_VIDEO_ZORAN is not set=0A=
# CONFIG_VIDEO_ZORAN_BUZ is not set=0A=
# CONFIG_VIDEO_ZORAN_DC10 is not set=0A=
# CONFIG_VIDEO_ZORAN_LML33 is not set=0A=
# CONFIG_VIDEO_ZR36120 is not set=0A=
# CONFIG_VIDEO_MEYE is not set=0A=
=0A=
#=0A=
# Radio Adapters=0A=
#=0A=
# CONFIG_RADIO_CADET is not set=0A=
# CONFIG_RADIO_RTRACK is not set=0A=
# CONFIG_RADIO_RTRACK2 is not set=0A=
# CONFIG_RADIO_AZTECH is not set=0A=
# CONFIG_RADIO_GEMTEK is not set=0A=
# CONFIG_RADIO_GEMTEK_PCI is not set=0A=
# CONFIG_RADIO_MAXIRADIO is not set=0A=
# CONFIG_RADIO_MAESTRO is not set=0A=
# CONFIG_RADIO_MIROPCM20 is not set=0A=
# CONFIG_RADIO_MIROPCM20_RDS is not set=0A=
# CONFIG_RADIO_SF16FMI is not set=0A=
# CONFIG_RADIO_SF16FMR2 is not set=0A=
# CONFIG_RADIO_TERRATEC is not set=0A=
# CONFIG_RADIO_TRUST is not set=0A=
# CONFIG_RADIO_TYPHOON is not set=0A=
# CONFIG_RADIO_ZOLTRIX is not set=0A=
=0A=
#=0A=
# File systems=0A=
#=0A=
# CONFIG_QUOTA is not set=0A=
# CONFIG_AUTOFS_FS is not set=0A=
# CONFIG_AUTOFS4_FS is not set=0A=
# CONFIG_REISERFS_FS is not set=0A=
# CONFIG_REISERFS_CHECK is not set=0A=
# CONFIG_REISERFS_PROC_INFO is not set=0A=
# CONFIG_ADFS_FS is not set=0A=
# CONFIG_ADFS_FS_RW is not set=0A=
# CONFIG_AFFS_FS is not set=0A=
CONFIG_HFS_FS=3Dm=0A=
# CONFIG_BEFS_FS is not set=0A=
# CONFIG_BEFS_DEBUG is not set=0A=
# CONFIG_HFSPLUS_FS is not set=0A=
# CONFIG_BFS_FS is not set=0A=
CONFIG_EXT3_FS=3Dy=0A=
CONFIG_JBD=3Dy=0A=
# CONFIG_JBD_DEBUG is not set=0A=
CONFIG_FAT_FS=3Dm=0A=
CONFIG_MSDOS_FS=3Dm=0A=
CONFIG_UMSDOS_FS=3Dm=0A=
CONFIG_VFAT_FS=3Dm=0A=
# CONFIG_EFS_FS is not set=0A=
# CONFIG_JFFS_FS is not set=0A=
# CONFIG_JFFS2_FS is not set=0A=
# CONFIG_CRAMFS is not set=0A=
CONFIG_TMPFS=3Dy=0A=
CONFIG_RAMFS=3Dy=0A=
CONFIG_ISO9660_FS=3Dm=0A=
CONFIG_JOLIET=3Dy=0A=
CONFIG_ZISOFS=3Dy=0A=
# CONFIG_JFS_FS is not set=0A=
# CONFIG_JFS_DEBUG is not set=0A=
# CONFIG_JFS_STATISTICS is not set=0A=
# CONFIG_MINIX_FS is not set=0A=
# CONFIG_VXFS_FS is not set=0A=
CONFIG_NTFS_FS=3Dm=0A=
# CONFIG_NTFS_RW is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
CONFIG_PROC_FS=3Dy=0A=
CONFIG_DEVFS_FS=3Dy=0A=
CONFIG_DEVFS_MOUNT=3Dy=0A=
# CONFIG_DEVFS_DEBUG is not set=0A=
CONFIG_DEVPTS_FS=3Dy=0A=
# CONFIG_QNX4FS_FS is not set=0A=
# CONFIG_QNX4FS_RW is not set=0A=
# CONFIG_ROMFS_FS is not set=0A=
CONFIG_EXT2_FS=3Dy=0A=
# CONFIG_SYSV_FS is not set=0A=
# CONFIG_UDF_FS is not set=0A=
# CONFIG_UDF_RW is not set=0A=
# CONFIG_UFS_FS is not set=0A=
# CONFIG_UFS_FS_WRITE is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
# CONFIG_CODA_FS is not set=0A=
# CONFIG_INTERMEZZO_FS is not set=0A=
CONFIG_NFS_FS=3Dm=0A=
# CONFIG_NFS_V3 is not set=0A=
# CONFIG_ROOT_NFS is not set=0A=
CONFIG_NFSD=3Dm=0A=
# CONFIG_NFSD_V3 is not set=0A=
# CONFIG_NFSD_TCP is not set=0A=
CONFIG_SUNRPC=3Dm=0A=
CONFIG_LOCKD=3Dm=0A=
CONFIG_SMB_FS=3Dm=0A=
CONFIG_SMB_NLS_DEFAULT=3Dy=0A=
CONFIG_SMB_NLS_REMOTE=3D"cp437"=0A=
# CONFIG_NCP_FS is not set=0A=
# CONFIG_NCPFS_PACKET_SIGNING is not set=0A=
# CONFIG_NCPFS_IOCTL_LOCKING is not set=0A=
# CONFIG_NCPFS_STRONG is not set=0A=
# CONFIG_NCPFS_NFS_NS is not set=0A=
# CONFIG_NCPFS_OS2_NS is not set=0A=
# CONFIG_NCPFS_SMALLDOS is not set=0A=
# CONFIG_NCPFS_NLS is not set=0A=
# CONFIG_NCPFS_EXTRAS is not set=0A=
CONFIG_ZISOFS_FS=3Dm=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
CONFIG_PARTITION_ADVANCED=3Dy=0A=
# CONFIG_ACORN_PARTITION is not set=0A=
# CONFIG_OSF_PARTITION is not set=0A=
# CONFIG_AMIGA_PARTITION is not set=0A=
# CONFIG_ATARI_PARTITION is not set=0A=
# CONFIG_MAC_PARTITION is not set=0A=
CONFIG_MSDOS_PARTITION=3Dy=0A=
# CONFIG_BSD_DISKLABEL is not set=0A=
# CONFIG_MINIX_SUBPARTITION is not set=0A=
# CONFIG_SOLARIS_X86_PARTITION is not set=0A=
# CONFIG_UNIXWARE_DISKLABEL is not set=0A=
# CONFIG_LDM_PARTITION is not set=0A=
# CONFIG_SGI_PARTITION is not set=0A=
# CONFIG_ULTRIX_PARTITION is not set=0A=
# CONFIG_SUN_PARTITION is not set=0A=
# CONFIG_EFI_PARTITION is not set=0A=
CONFIG_SMB_NLS=3Dy=0A=
CONFIG_NLS=3Dy=0A=
=0A=
#=0A=
# Native Language Support=0A=
#=0A=
CONFIG_NLS_DEFAULT=3D"iso8859-1"=0A=
CONFIG_NLS_CODEPAGE_437=3Dy=0A=
# CONFIG_NLS_CODEPAGE_737 is not set=0A=
# CONFIG_NLS_CODEPAGE_775 is not set=0A=
# CONFIG_NLS_CODEPAGE_850 is not set=0A=
# CONFIG_NLS_CODEPAGE_852 is not set=0A=
# CONFIG_NLS_CODEPAGE_855 is not set=0A=
# CONFIG_NLS_CODEPAGE_857 is not set=0A=
# CONFIG_NLS_CODEPAGE_860 is not set=0A=
# CONFIG_NLS_CODEPAGE_861 is not set=0A=
# CONFIG_NLS_CODEPAGE_862 is not set=0A=
# CONFIG_NLS_CODEPAGE_863 is not set=0A=
# CONFIG_NLS_CODEPAGE_864 is not set=0A=
# CONFIG_NLS_CODEPAGE_865 is not set=0A=
# CONFIG_NLS_CODEPAGE_866 is not set=0A=
# CONFIG_NLS_CODEPAGE_869 is not set=0A=
# CONFIG_NLS_CODEPAGE_936 is not set=0A=
# CONFIG_NLS_CODEPAGE_950 is not set=0A=
# CONFIG_NLS_CODEPAGE_932 is not set=0A=
# CONFIG_NLS_CODEPAGE_949 is not set=0A=
# CONFIG_NLS_CODEPAGE_874 is not set=0A=
# CONFIG_NLS_ISO8859_8 is not set=0A=
# CONFIG_NLS_CODEPAGE_1250 is not set=0A=
# CONFIG_NLS_CODEPAGE_1251 is not set=0A=
CONFIG_NLS_ISO8859_1=3Dy=0A=
# CONFIG_NLS_ISO8859_2 is not set=0A=
# CONFIG_NLS_ISO8859_3 is not set=0A=
# CONFIG_NLS_ISO8859_4 is not set=0A=
# CONFIG_NLS_ISO8859_5 is not set=0A=
# CONFIG_NLS_ISO8859_6 is not set=0A=
# CONFIG_NLS_ISO8859_7 is not set=0A=
# CONFIG_NLS_ISO8859_9 is not set=0A=
# CONFIG_NLS_ISO8859_13 is not set=0A=
# CONFIG_NLS_ISO8859_14 is not set=0A=
# CONFIG_NLS_ISO8859_15 is not set=0A=
# CONFIG_NLS_KOI8_R is not set=0A=
# CONFIG_NLS_KOI8_U is not set=0A=
CONFIG_NLS_UTF8=3Dy=0A=
=0A=
#=0A=
# Console drivers=0A=
#=0A=
CONFIG_VGA_CONSOLE=3Dy=0A=
CONFIG_VIDEO_SELECT=3Dy=0A=
# CONFIG_MDA_CONSOLE is not set=0A=
=0A=
#=0A=
# Frame-buffer support=0A=
#=0A=
CONFIG_FB=3Dy=0A=
CONFIG_DUMMY_CONSOLE=3Dy=0A=
CONFIG_FB_RIVA=3Dy=0A=
# CONFIG_FB_CLGEN is not set=0A=
# CONFIG_FB_PM2 is not set=0A=
# CONFIG_FB_PM3 is not set=0A=
# CONFIG_FB_CYBER2000 is not set=0A=
# CONFIG_FB_VESA is not set=0A=
# CONFIG_FB_VGA16 is not set=0A=
# CONFIG_FB_HGA is not set=0A=
CONFIG_VIDEO_SELECT=3Dy=0A=
# CONFIG_FB_MATROX is not set=0A=
# CONFIG_FB_ATY is not set=0A=
# CONFIG_FB_RADEON is not set=0A=
# CONFIG_FB_ATY128 is not set=0A=
# CONFIG_FB_INTEL is not set=0A=
# CONFIG_FB_SIS is not set=0A=
# CONFIG_FB_NEOMAGIC is not set=0A=
# CONFIG_FB_3DFX is not set=0A=
# CONFIG_FB_VOODOO1 is not set=0A=
# CONFIG_FB_TRIDENT is not set=0A=
# CONFIG_FB_VIRTUAL is not set=0A=
# CONFIG_FBCON_ADVANCED is not set=0A=
CONFIG_FBCON_CFB8=3Dy=0A=
CONFIG_FBCON_CFB16=3Dy=0A=
CONFIG_FBCON_CFB32=3Dy=0A=
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set=0A=
# CONFIG_FBCON_FONTS is not set=0A=
CONFIG_FONT_8x8=3Dy=0A=
CONFIG_FONT_8x16=3Dy=0A=
=0A=
#=0A=
# Sound=0A=
#=0A=
CONFIG_SOUND=3Dy=0A=
# CONFIG_SOUND_ALI5455 is not set=0A=
# CONFIG_SOUND_BT878 is not set=0A=
# CONFIG_SOUND_CMPCI is not set=0A=
# CONFIG_SOUND_EMU10K1 is not set=0A=
# CONFIG_MIDI_EMU10K1 is not set=0A=
# CONFIG_SOUND_FUSION is not set=0A=
# CONFIG_SOUND_CS4281 is not set=0A=
# CONFIG_SOUND_ES1370 is not set=0A=
CONFIG_SOUND_ES1371=3Dm=0A=
# CONFIG_SOUND_ESSSOLO1 is not set=0A=
# CONFIG_SOUND_MAESTRO is not set=0A=
# CONFIG_SOUND_MAESTRO3 is not set=0A=
# CONFIG_SOUND_FORTE is not set=0A=
# CONFIG_SOUND_ICH is not set=0A=
# CONFIG_SOUND_RME96XX is not set=0A=
# CONFIG_SOUND_SONICVIBES is not set=0A=
# CONFIG_SOUND_TRIDENT is not set=0A=
# CONFIG_SOUND_MSNDCLAS is not set=0A=
# CONFIG_SOUND_MSNDPIN is not set=0A=
# CONFIG_SOUND_VIA82CXXX is not set=0A=
# CONFIG_MIDI_VIA82CXXX is not set=0A=
CONFIG_SOUND_OSS=3Dm=0A=
# CONFIG_SOUND_TRACEINIT is not set=0A=
# CONFIG_SOUND_DMAP is not set=0A=
# CONFIG_SOUND_AD1816 is not set=0A=
# CONFIG_SOUND_AD1889 is not set=0A=
# CONFIG_SOUND_SGALAXY is not set=0A=
# CONFIG_SOUND_ADLIB is not set=0A=
# CONFIG_SOUND_ACI_MIXER is not set=0A=
# CONFIG_SOUND_CS4232 is not set=0A=
# CONFIG_SOUND_SSCAPE is not set=0A=
# CONFIG_SOUND_GUS is not set=0A=
# CONFIG_SOUND_VMIDI is not set=0A=
# CONFIG_SOUND_TRIX is not set=0A=
# CONFIG_SOUND_MSS is not set=0A=
# CONFIG_SOUND_MPU401 is not set=0A=
# CONFIG_SOUND_NM256 is not set=0A=
# CONFIG_SOUND_MAD16 is not set=0A=
# CONFIG_SOUND_PAS is not set=0A=
# CONFIG_PAS_JOYSTICK is not set=0A=
# CONFIG_SOUND_PSS is not set=0A=
# CONFIG_SOUND_SB is not set=0A=
# CONFIG_SOUND_AWE32_SYNTH is not set=0A=
# CONFIG_SOUND_KAHLUA is not set=0A=
# CONFIG_SOUND_WAVEFRONT is not set=0A=
# CONFIG_SOUND_MAUI is not set=0A=
# CONFIG_SOUND_YM3812 is not set=0A=
# CONFIG_SOUND_OPL3SA1 is not set=0A=
# CONFIG_SOUND_OPL3SA2 is not set=0A=
# CONFIG_SOUND_YMFPCI is not set=0A=
# CONFIG_SOUND_YMFPCI_LEGACY is not set=0A=
# CONFIG_SOUND_UART6850 is not set=0A=
# CONFIG_SOUND_AEDSP16 is not set=0A=
# CONFIG_SOUND_TVMIXER is not set=0A=
=0A=
#=0A=
# USB support=0A=
#=0A=
CONFIG_USB=3Dm=0A=
# CONFIG_USB_DEBUG is not set=0A=
CONFIG_USB_DEVICEFS=3Dy=0A=
# CONFIG_USB_BANDWIDTH is not set=0A=
# CONFIG_USB_EHCI_HCD is not set=0A=
# CONFIG_USB_UHCI is not set=0A=
# CONFIG_USB_UHCI_ALT is not set=0A=
CONFIG_USB_OHCI=3Dm=0A=
# CONFIG_USB_AUDIO is not set=0A=
# CONFIG_USB_EMI26 is not set=0A=
# CONFIG_USB_BLUETOOTH is not set=0A=
# CONFIG_USB_MIDI is not set=0A=
# CONFIG_USB_STORAGE is not set=0A=
# CONFIG_USB_STORAGE_DEBUG is not set=0A=
# CONFIG_USB_STORAGE_DATAFAB is not set=0A=
# CONFIG_USB_STORAGE_FREECOM is not set=0A=
# CONFIG_USB_STORAGE_ISD200 is not set=0A=
# CONFIG_USB_STORAGE_DPCM is not set=0A=
# CONFIG_USB_STORAGE_HP8200e is not set=0A=
# CONFIG_USB_STORAGE_SDDR09 is not set=0A=
# CONFIG_USB_STORAGE_SDDR55 is not set=0A=
# CONFIG_USB_STORAGE_JUMPSHOT is not set=0A=
# CONFIG_USB_ACM is not set=0A=
# CONFIG_USB_PRINTER is not set=0A=
# CONFIG_USB_HID is not set=0A=
# CONFIG_USB_HIDINPUT is not set=0A=
# CONFIG_USB_HIDDEV is not set=0A=
# CONFIG_USB_KBD is not set=0A=
# CONFIG_USB_MOUSE is not set=0A=
# CONFIG_USB_AIPTEK is not set=0A=
# CONFIG_USB_WACOM is not set=0A=
# CONFIG_USB_KBTAB is not set=0A=
# CONFIG_USB_POWERMATE is not set=0A=
# CONFIG_USB_DC2XX is not set=0A=
# CONFIG_USB_MDC800 is not set=0A=
# CONFIG_USB_SCANNER is not set=0A=
# CONFIG_USB_MICROTEK is not set=0A=
# CONFIG_USB_HPUSBSCSI is not set=0A=
# CONFIG_USB_IBMCAM is not set=0A=
# CONFIG_USB_KONICAWC is not set=0A=
CONFIG_USB_OV511=3Dm=0A=
# CONFIG_USB_PWC is not set=0A=
# CONFIG_USB_SE401 is not set=0A=
# CONFIG_USB_STV680 is not set=0A=
# CONFIG_USB_VICAM is not set=0A=
# CONFIG_USB_DSBR is not set=0A=
# CONFIG_USB_DABUSB is not set=0A=
# CONFIG_USB_PEGASUS is not set=0A=
# CONFIG_USB_RTL8150 is not set=0A=
# CONFIG_USB_KAWETH is not set=0A=
# CONFIG_USB_CATC is not set=0A=
# CONFIG_USB_AX8817X is not set=0A=
# CONFIG_USB_CDCETHER is not set=0A=
# CONFIG_USB_USBNET is not set=0A=
# CONFIG_USB_USS720 is not set=0A=
=0A=
#=0A=
# USB Serial Converter support=0A=
#=0A=
# CONFIG_USB_SERIAL is not set=0A=
# CONFIG_USB_RIO500 is not set=0A=
# CONFIG_USB_AUERSWALD is not set=0A=
# CONFIG_USB_TIGL is not set=0A=
# CONFIG_USB_BRLVGER is not set=0A=
# CONFIG_USB_LCD is not set=0A=
# CONFIG_USB_SPEEDTOUCH is not set=0A=
=0A=
#=0A=
# Bluetooth support=0A=
#=0A=
# CONFIG_BLUEZ is not set=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
CONFIG_DEBUG_KERNEL=3Dy=0A=
CONFIG_DEBUG_STACKOVERFLOW=3Dy=0A=
CONFIG_DEBUG_HIGHMEM=3Dy=0A=
CONFIG_DEBUG_SLAB=3Dy=0A=
CONFIG_DEBUG_IOVIRT=3Dy=0A=
CONFIG_MAGIC_SYSRQ=3Dy=0A=
CONFIG_DEBUG_SPINLOCK=3Dy=0A=
CONFIG_FRAME_POINTER=3Dy=0A=
=0A=
#=0A=
# Cryptographic options=0A=
#=0A=
# CONFIG_CRYPTO is not set=0A=
=0A=
#=0A=
# Library routines=0A=
#=0A=
CONFIG_CRC32=3Dy=0A=
CONFIG_ZLIB_INFLATE=3Dm=0A=
CONFIG_ZLIB_DEFLATE=3Dm=0A=

------=_NextPart_000_0015_01C34865.EF067360--

