Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbTIEFEB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 01:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbTIEFEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 01:04:00 -0400
Received: from [211.157.248.46] ([211.157.248.46]:35263 "EHLO
	mail.cosix.com.cn") by vger.kernel.org with ESMTP id S262265AbTIEFDn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 01:03:43 -0400
From: "=?GB2312?Q?=D3=DA=B2=A8?=" <aiyubo@cosix.com.cn>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: CF GPRS-MODEM card on Intel HCCCBCTA1/Cotulla Platform,problem with serial port
X-mailer: Foxmail 4.2 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Content-Transfer-Encoding: 8BIT
Date: Fri, 5 Sep 2003 13:2:1 -0800
Message-Id: <S262265AbTIEFDn/20030905050343Z+4322@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Linux version 2.4.19-rmk7-pxa2;
gcc version 2.95.3 20010315 (release)
CPU: XScale-PXA250 revision 1
Machine: Intel DBPXA250 Development Platform
GPRS-MODEM card:AUDIOVOX RTM-8000(work properly in windows)

All information as follows:

Uncompressing Linux............................................... done, booting the kernel.
Linux version 2.4.19-rmk7-pxa2 (root@bobo) (gcc version 2.95.3 20010315 (release)) #22 .Ä 9.. 4 14:18:47 GMT-5 2003
CPU: XScale-PXA250 revision 1
Machine: Intel DBPXA250 Development Platform
Ignoring unrecognised tag 0x00000000
Memory clock: 99.53MHz (*27)
Run Mode clock: 99.53MHz (*1)
Turbo Mode clock: 199.07MHz (*2.0, active)
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs ip=192.9.200.186 nfsroot=192.9.200.56://opt/pxa/pxa-nfs console=ttyS0,115200 mem=64M rw
Console: colour dummy device 80x30
Calibrating delay loop... 198.65 BogoMIPS
Memory: 64MB = 64MB total
Memory: 63228KB available (1198K code, 290K data, 76K init)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
SA1111 Microprocessor Companion Chip: silicon revision 1, metal revision 1
Disabling CPU frequency change support.
CPU clock: 0.000 MHz (0.000-0.000 MHz)
Starting kswapd
Console: switching to colour frame buffer device 80x30
initialize_kbd: Keyboard reset failed, no ACK
pty: 256 Unix98 ptys configured
Keyboard timed out[1]
keyboard: Timeout - AT keyboard not present?
Keyboard timed out[1]
keyboard: Timeout - AT keyboard not present?
Serial driver version 5.05c (2001-07-08) with no serial options enabled
ttyS00 at 0x0000 (irq = 15) is a PXA UART
ttyS01 at 0x0000 (irq = 14) is a PXA UART
ttyS02 at 0x0000 (irq = 13) is a PXA UART
SA1100 Real Time Clock driver v1.00
ac97_codec: AC97 Audio codec, id: 0x5053:0x4304 (Philips UCB1400)
enable_irq(163) unbalanced from c00b3ce8
smc91x.c: v1.0, mar 07 2003 by Nicolas Pitre <nico@cam.org>
eth0: SMC91C94 (rev 9) at 0xf1000c00 IRQ 162 [nowait]
eth0: Ethernet addr: 00:02:b3:92:a6:c8
PPP generic driver version 2.4.2
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
      device=eth0, addr=192.9.200.186, mask=255.255.255.0, gw=255.255.255.255,
     host=192.9.200.186, domain=, nis-domain=(none),
     bootserver=255.255.255.255, rootserver=192.9.200.56, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NetWinder Floating Point Emulator V0.95 (c) 1998-1999 Rebel.com
Looking up port of RPC 100003/2 on 192.9.200.56
Looking up port of RPC 100005/1 on 192.9.200.56
VFS: Mounted root (nfs filesystem).
Freeing init memory: 76K
init started:  BusyBox v0.60.5 (2002.11.19-06:58+0000) multi-call binary
Please press Enter to activate this console.

# insmod pcmcia_core.o
enter cs.c--init_pcmcia_cs()
Linux Kernel Card Services 3.1.22
  options:  [pm]
# insmod pxa/pxa_cs.o
Intel PXA250/210 PCMCIA (CS release 3.1.22)
# insmod ds.o

# insmod pcmcia/serial_cs.o
enter serila_cs.c--init_serial_cs()

# cardmgr
cardmgr[37]: could not open './config.opts': No such file or directory
cardmgr[37]: watching 2 sockets
# cardmgr[38]: starting, version is 3.2.4

enter cistpl.c--pcmcia_validate_cis()<4>enter cistpl.c--read_tuple()<4>exit cistpl.c--read_tuple(),ret=0<4>cistpl.c--pcmcia_val1cardmgr[35]: socket 1: Serial or Modem
cardmgr[35]: socket beep ok 519
<1> serial_cs.c:serial_attach()
serial_cs.c--serial_attach():before CardServices()
enter cistpl.c--read_tuple()<1> serial_cs.c:serial_event(0x000004)
serila_cs.c--serial_event():CS_EVENT_CARD_INSERTION
enter serila_cs.c--serial_config()
enter serila_cs.c--get_tuple()
serila_cs.c--get_tuple():i = CS_SUCCESS,parsetuple,i=0
enter serila_cs.c--get_tuple()
serila_cs.c--get_tuple():i != CS_SUCCESS,getfirsttuple,i=31
enter serila_cs.c--get_tuple()
serila_cs.c--get_tuple():i = CS_SUCCESS,parsetuple,i=0
enter serila_cs.c--get_tuple()
serila_cs.c--get_tuple():i = CS_SUCCESS,parsetuple,i=0
enter serila_cs.c--get_tuple()
serila_cs.c--get_tuple():i = CS_SUCCESS,parsetuple,i=0
serial_cs.c:ntering serial_cs.c--multi_config()
enter serila_cs.c--get_tuple()
serila_cs.c--get_tuple():i = CS_SUCCESS,parsetuple,i=0
enter cs.c--pcmcia_request_io()
cs.c--pcmcia_request_io():SUCESS
enter cs.c--pcmcia_request_irq()
cs.c--pcmcia_request_irq():SUCESS
cs.c--CardServices(),RequestConfiguration
enter cs.c--pcmcia_request_configuratio()
bobo_vcc:33 50
bobo_vpp:0 0
EXIT cs.c--pcmcia_request_configuratio()
cs.c--setup_serial():irq=154 port=f70003f8
serial.c:entering register_serial()
ttyS03 at port 0xf70003f8 (irq = 154) is a 16C950/954
serial.c:exit register_serial()
cs.c--setup_serial():SUCESS
cs.c--setup_serial():irq=154 port=f7000400
serial.c:entering register_serial()
ttyS04 at port 0xf7000400 (irq = 154) is a 16C950/954
serial.c:exit register_serial()
cs.c--setup_serial():SUCESS
exit serial_cs.c--multi_config()
exit serila_cs.c--serial_config()
cardmgr[35]: executing: './serial start ttyS3'
cardmgr[35]: + expr: No such file or directory
cardmgr[35]: executing: './serial start ttyS4'
cardmgr[35]: + expr: No such file or directory

# cardctl ident
Socket 0:
  no product info available
Socket 1:
  product info: "GPRS Modem", "", "", ""
  manfid: 0x0279, 0x950b
  function: 2 (serial)

# cardctl config
Socket 0:
  not configured
Socket 1:
  Vcc 5.0V  Vpp1 0.0V  Vpp2 0.0V
  interface type is "memory and I/O"
  irq 154 [exclusive] [level]
  speaker output is enabled
  function 0:
    config base 0x00f8
      option 0x41 status 0x08 pin 0x00 copy 0x00
    io 0xf70003f8-0xf7000407 [8bit]

# cardctl status
Socket 0:
  no card
Socket 1:
  3.3V 16-bit PC Card
  function 0: [ready], [bat dead], [bat low]

# cat /var/run/stab
Socket 0: empty
Socket 1: Serial or Modem
1       serial  serial_cs       0       ttyS3   4       67
1       serial  serial_cs       1       ttyS4   4       68

# cat /proc/devices
Character devices:
  1 mem
  2 pty
  3 ttyp
  4 ttyS
  5 cua
  7 vcs
 10 misc
 14 sound
 29 fb
108 ppp
128 ptm
136 pts
162 raw
254 pcmcia

Block devices:
# cat /proc/interrupts
  1:       4004   Lubbock FPGA
  3:          0   GPIO 2-80
  7:         64   AC97
 10:          0   LCD
 15:        224   serial
 18:          0   DMA
 19:       9905   timer
 20:          0   rtc timer
 23:          0   rtc 1Hz
 24:          0   rtc Alrm
126:          0   keyboard
155:          0   Lubbock PCMCIA (0) CD
156:          2   Lubbock CF (1) CD
157:          0   Lubbock PCMCIA (0) BVD1
158:          2   Lubbock CF (1) BVD1
160:          4   SA1111
162:       3999   eth0
163:          1   UCB1x00
Err:          0
# cat /proc/ioports
f1000c00-f1000c3f : eth0
f70003f8-f70003ff : serial(auto)
f7000400-f7000407 : serial(auto)
# cat /proc/iomem
a0000000-a3ffffff : System RAM
  a001b000-a0146adf : Kernel code
  a0146ae0-a018f3cf : Kernel data
f4000000-f4002000 : SA1111
  f4000a00-f4000bff : keyboard
  f4001600-f40017ff : irqs

# cat /dev/ttyS3
Division by zero in kernel.
Function entered at [<c0022b88>] from [<c012d500>]
Function entered at [<c00a920c>] from [<c00a8e50>]
Function entered at [<c00a87a8>] from [<c00ab87c>]
Function entered at [<c00ab760>] from [<c00960f8>]
 r8 = C3D6EF60  r7 = C02462E0  r6 = C03A4720  r5 = 00000000
 r4 = 00000000
Function entered at [<c0095ea8>] from [<c004c850>]
Function entered at [<c004c7fc>] from [<c004b4ec>]
 r6 = 00000000  r5 = C3D6B860  r4 = C03A4720
Function entered at [<c004b3e4>] from [<c004b3e0>]
 r8 = C001D624  r7 = C02E4000  r6 = 000001B6  r5 = 00000000
 r4 = 00000000
Function entered at [<c004b394>] from [<c004b734>]
 r4 = 00000003
Function entered at [<c004b6f0>] from [<c001d480>]
 r7 = 00000005  r6 = 000001B6  r5 = 0004DE10  r4 = 00000008
Division by zero in kernel.
Function entered at [<c0022b88>] from [<c012d500>]
Function entered at [<c00a920c>] from [<c00a8e50>]
Function entered at [<c00a87a8>] from [<c00ab87c>]
Function entered at [<c00ab760>] from [<c00960f8>]
 r8 = C3D6EF60  r7 = C02462E0  r6 = C03A4720  r5 = 00000000
 r4 = 00000000
Function entered at [<c0095ea8>] from [<c004c850>]
Function entered at [<c004c7fc>] from [<c004b4ec>]
 r6 = 00000000  r5 = C3D6B860  r4 = C03A4720
Function entered at [<c004b3e4>] from [<c004b3e0>]
 r8 = C001D624  r7 = C02E4000  r6 = 000001B6  r5 = 00000000
 r4 = 00000000
Function entered at [<c004b394>] from [<c004b734>]
 r4 = 00000003
Function entered at [<c004b6f0>] from [<c001d480>]
 r7 = 00000005  r6 = 000001B6  r5 = 0004DE10  r4 = 00000008
 
 I want to use this CF-modem card,what's wrong with the driver and ttyS3?what can I do to fix this?


