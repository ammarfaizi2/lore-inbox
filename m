Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWHRGXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWHRGXA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 02:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWHRGXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 02:23:00 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:32099 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750736AbWHRGW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 02:22:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EWs/Vcvyj5Hyf+G5r9axpjiDN4dxWJbaorubHw5YksAg4G/IerE7VdSwYcqNIJBcPXlESOfMZherFMMQFmzcpv+UTys13Q4s01XzhFUn7AQaTxYu9DPqoznUWZHAQ80wti84ez0RwZ9emAONKObquj00dB7eSsZJMKYtvbaxxos=
Message-ID: <8032e0b00608172322y6e77b9d9v3f8cd73e8a7b454d@mail.gmail.com>
Date: Fri, 18 Aug 2006 11:52:58 +0530
From: "Ashok Shankar Das" <ashok.s.das@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM Please Help
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
Network Transmission happens if mouse is moved continuously

[2.] Full description of the problem/report:
This is a weired problem I faced while trying the Linux-2.6.17-7
/8
You start pinging to a perticular IP then there will be no activity.
If The MOUSE is moved or if scroll wheel is scrolled then The ping
shows some activity.
I used MTR(MyTraceRoute) and ping Both gave the same result.


[3.] Keywords (i.e., modules, networking, kernel):
Networking, Mouse

[4.] Kernel version (from /proc/version):
Linux version 2.6.17.7 (root@thinlab) (gcc version 3.3.6) #2 Wed Jul
26 16:39:17 IST 2006

Linux version 2.6.17.8 (root@thinlab) (gcc version 3.3.6) #2 Thu Aug
17 18:30:15 IST 2006

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-
tracing.txt)
NONE
[6.] A small shell script or example program which triggers the
     problem (if possible)
NONE
[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)
[7.2
.] Processor information (from /proc/cpuinfo):
root@localhost:~# cat /proc/cpuinfo
processor       : 0
vendor_id       : CentaurHauls
cpu family      : 6
model           : 9
model name      : VIA Nehemiah

stepping        : 8
cpu MHz         : 796.167
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes

cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr cx8 mtrr pge cmov pat mmx
fxsr sse up rng rng_en ace ace_en
bogomips        : 1594.38

[7.3.] Module information (from /proc/modules):

NO MODULES
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
root@localhost:~# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard

0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
4000-407f : 0000:00:
11.0
  4000-407f : motherboard
    4000-4003 : PM1a_EVT_BLK
    4008-400b : PM_TMR
    4020-4023 : GPE0_BLK
40f0-40f1 : PM1a_CNT_BLK
5000-500f : 0000:00:11.0
  5000-500f : motherboard
    5000-500f : pnp 00:02

e000-e0ff : 0000:00:11.5
  e000-e0ff : VIA8233
e400-e4ff : 0000:00:12.0
  e400-e4ff : via-rhine
e900-e90f : 0000:00:11.1
  e900-e907 : ide0
ea00-ea1f : 0000:00:10.0
  ea00-ea1f : uhci_hcd
eb00-eb1f : 0000:00:
10.1
  eb00-eb1f : uhci_hcd
===============================
root@localhost:~# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7dff : Video ROM

000d0000-000d9fff : Adapter ROM
000f0000-000fffff : System ROM
00100000-06feffff : System RAM
  00100000-004ddc78 : Kernel code
  004ddc79-006ce6fb : Kernel data
06ff0000-06ff2fff : ACPI Non-volatile Storage

06ff3000-06ffffff : ACPI Tables
e4000000-e7ffffff : 0000:00:00.0
e8000000-ebffffff : PCI Bus #01
  e8000000-ebffffff : 0000:01:00.0
    e8000000-e8ffffff : vesafb
ec000000-edffffff : PCI Bus #01
  ec000000-ecffffff : 0000:01:
00.0
  ed000000-ed00ffff : 0000:01:00.0
ee000000-ee0000ff : 0000:00:10.3
  ee000000-ee0000ff : ehci_hcd
ee001000-ee0010ff : 0000:00:12.0
  ee001000-ee0010ff : via-rhine
ffff0000-ffffffff : reserved



[7.5.] PCI information ('lspci -vvv' as root)
Note* as it is an small system i dont have lspci on it. the bellow is
a "cat /proc/bus/pci/devices" out put
0000	11063123	0	e4000008	00000000	00000000	00000000	00000000	00000000	00000000	04000000	00000000	00000000	00000000	00000000	00000000	00000000	agpgart-via

0008	1106b091	0	00000000	00000000	00000000	00000000	00000000	00000000	00000000	00000000	00000000	00000000	00000000	00000000	00000000	00000000
0080	11063038	b	00000000	00000000	00000000	00000000	0000ea01	00000000	00000000	00000000	00000000	00000000	00000000	00000020	00000000	00000000	uhci_hcd

0081	11063038	c	00000000	00000000	00000000	00000000	0000eb01	00000000	00000000	00000000	00000000	00000000	00000000	00000020	00000000	00000000	uhci_hcd
0083	11063104	a	ee000000	00000000	00000000	00000000	00000000	00000000	00000000	00000100	00000000	00000000	00000000	00000000	00000000	00000000	ehci_hcd

0088	11063177	0	00000000	00000000	00000000	00000000	00000000	00000000	00000000	00000000	00000000	00000000	00000000	00000000	00000000	00000000
0089	11060571	b	00000000	00000000	00000000	00000000	0000e901	00000000	00000000	00000000	00000000	00000000	00000000	00000010	00000000	00000000	VIA_IDE

008d	11063059	b	0000e001	00000000	00000000	00000000	00000000	00000000	00000000	00000100	00000000	00000000	00000000	00000000	00000000	00000000	VIA
82xx Audio
0090	11063065	b	0000e401	ee001000	00000000	00000000	00000000	00000000	00000000	00000100	00000100	00000000	00000000	00000000	00000000	00000000	via-rhine

0100	11063122	f	e8000008	ec000000	00000000	00000000	00000000	00000000	ed000002	04000000	01000000	00000000	00000000	00000000	00000000	00010000
[7.6.] SCSI information (from /proc/scsi/scsi)

[7.7.] Other information that might be relevant to the problem

       (please look in /proc and include all information that you
       think to be relevant):
root@localhost:/proc/net# cat dev
Inter-|   Receive                                                |  Transmit

 face |bytes    packets errs drop fifo frame compressed
multicast|bytes    packets errs drop fifo colls carrier compressed
  eth0:   72101     721    0   92    0     0          0         0
61735     362    0    0    0     0       0          0

    lo:       0       0    0    0    0     0          0         0
  0       0    0    0    0     0       0          0
irlan0:       0       0    0    0    0     0          0         0
  0       0    0    0    0     0       0          0

========================
root@localhost:/proc/net# cat netlink
sk       Eth Pid    Groups   Rmem     Wmem     Dump     Locks
c6f9be00 0   0      00000000 0        0        00000000 2
c6ef0e00 4   0      00000000 0        0        00000000 2

c6e04400 10  0      00000000 0        0        00000000 2
c112da00 15  880    ffffffff 0        0        00000000 2
c6f9bc00 15  0      00000000 0        0        00000000 2
c6fc6200 16  0      00000000 0        0        00000000 2

==========================



[X.] Other notes, patches, fixes, workarounds:


This is a VIA Board for embeded systm.
The bios is PC compatible.
The 2.6.15 kernel works perfectly fine.
The config file for 2.6.15 and for 2.6.17 are same.
If needed i can give the kernel config file.

Please help me to overcome this problem.

-- 
Thanks
Ashok.
-------------
