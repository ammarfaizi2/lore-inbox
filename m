Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbRBYANA>; Sat, 24 Feb 2001 19:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129736AbRBYAMv>; Sat, 24 Feb 2001 19:12:51 -0500
Received: from c-c48a70d5.032-6-73746f3.cust.bredbandsbolaget.se ([213.112.138.196]:55681
	"EHLO jarek") by vger.kernel.org with ESMTP id <S129733AbRBYAMk>;
	Sat, 24 Feb 2001 19:12:40 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jarek Luberek <jarek@swipnet.se>
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.4.2 during pump on 3c509
Date: Sun, 25 Feb 2001 01:12:37 +0100
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01022501123700.02059@jarek.dns2go.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is not uniqe to 2.4.2 but it's the first time I scraped this of the 
console (so there may be errors in this report). I may not have 
managed to copy this correctly from the console.

Greetings,
Jarek

Warning (compare_maps): mismatch on symbol __module_author  , es1371 says 
d08c5080, /lib/modules/2.4.2/kernel/drivers/sound/es1371.o says d08be180.  
Ignoring /lib/modules/2.4.2/kernel/drivers/sound/es1371.o entry
Warning (compare_maps): mismatch on symbol __module_description  , es1371 
says d08c50e0, /lib/modules/2.4.2/kernel/drivers/sound/es1371.o says 
d08be1e0.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/es1371.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_joystick  , 
es1371 says d08c4f40, /lib/modules/2.4.2/kernel/drivers/sound/es1371.o says 
d08be040.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/es1371.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_nomix  , es1371 
says d08c5020, /lib/modules/2.4.2/kernel/drivers/sound/es1371.o says 
d08be120.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/es1371.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_spdif  , es1371 
says d08c4fc0, /lib/modules/2.4.2/kernel/drivers/sound/es1371.o says 
d08be0c0.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/es1371.o entry
Warning (compare_maps): mismatch on symbol __module_parm_joystick  , es1371 
says d08c4f27, /lib/modules/2.4.2/kernel/drivers/sound/es1371.o says 
d08be027.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/es1371.o entry
Warning (compare_maps): mismatch on symbol __module_parm_nomix  , es1371 says 
d08c4ffa, /lib/modules/2.4.2/kernel/drivers/sound/es1371.o says d08be0fa.  
Ignoring /lib/modules/2.4.2/kernel/drivers/sound/es1371.o entry
Warning (compare_maps): mismatch on symbol __module_parm_spdif  , es1371 says 
d08c4f9c, /lib/modules/2.4.2/kernel/drivers/sound/es1371.o says d08be09c.  
Ignoring /lib/modules/2.4.2/kernel/drivers/sound/es1371.o entry
Warning (compare_maps): mismatch on symbol __module_parm_debug  , 3c509 says 
d08b9a8b, /lib/modules/2.4.2/kernel/drivers/net/3c509.o says d08b9d07.  
Ignoring /lib/modules/2.4.2/kernel/drivers/net/3c509.o entry
Warning (compare_maps): mismatch on symbol __module_parm_irq  , 3c509 says 
d08b9a98, /lib/modules/2.4.2/kernel/drivers/net/3c509.o says d08b9d14.  
Ignoring /lib/modules/2.4.2/kernel/drivers/net/3c509.o entry
Warning (compare_maps): mismatch on symbol __module_parm_max_interrupt_work  
, 3c509 says d08b9ab5, /lib/modules/2.4.2/kernel/drivers/net/3c509.o says 
d08b9d31.  Ignoring /lib/modules/2.4.2/kernel/drivers/net/3c509.o entry
Warning (compare_maps): mismatch on symbol __module_parm_nopnp  , 3c509 says 
d08b9acf, /lib/modules/2.4.2/kernel/drivers/net/3c509.o says d08b9d4b.  
Ignoring /lib/modules/2.4.2/kernel/drivers/net/3c509.o entry
Warning (compare_maps): mismatch on symbol __module_parm_xcvr  , 3c509 says 
d08b9aa6, /lib/modules/2.4.2/kernel/drivers/net/3c509.o says d08b9d22.  
Ignoring /lib/modules/2.4.2/kernel/drivers/net/3c509.o entry
CPU: 0
EIP: 0010 :[<d08b935e>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000086
eax: 00000026 ebx: cf71b800 ecx: 00000296 edx: 00000001
esi: 00000200 edi: cf716940 ebp: cf664000 esf: cf665dc0
ds: 0018 es: 0018 ss: 0018
stack: [<c02d306c>] [<cf716800>] [<cfecfb0a>] [<c01dce0e>] [<cf71b800>] 
[<c01dd07d>]
Call Trace: [<c01dce0e>] [<c01dd03d>] [<c02041e6>] [<c0204266>] [<c0204266>]
            [<c0204344>] [<c020450f>] [<c020294b>] [<c012085a>] [<c01db3d3>]
            [<c01dc228>] [<c0202444>] [<c020d3f7>] [<c02041fb>] [<c01d742b>]
            [<c01d67ef>] [<c0143a36>] [<c01d678c>] [<c0108fdb>]
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; d08b935e <[3c509].text.end+2c/4e>   <=====
Trace; c01dce0e <__dev_mc_upload+1e/24>
Trace; c01dd03d <dev_mc_add+e5/174>
Trace; c02041e6 <ip_mc_filter_add+32/3c>
Trace; c0204266 <igmp_group_added+1a/20>
Trace; c0204266 <igmp_group_added+1a/20>
Trace; c0204344 <ip_mc_inc_group+d8/f0>
Trace; c020450f <ip_mc_up+47/6c>
Trace; c020294b <inet_select_addr+f3/134>
Trace; c012085a <notifier_call_chain+1e/38>
Trace; c01db3d3 <dev_open+97/a0>
Trace; c01dc228 <dev_change_flags+54/f8>
Trace; c0202444 <devinet_ioctl+26c/580>
Trace; c020d3f7 <vsprintf+39f/3dc>
Trace; c02041fb <ip_mc_filter_del+b/3c>
Trace; c01d742b <sys_setsockopt+3f/70>
Trace; c01d67ef <sock_ioctl+63/8c>
Trace; c0143a36 <sys_ioctl+1ea/244>
Trace; c01d678c <sock_ioctl+0/8c>
Trace; c0108fdb <system_call+33/38>


15 warnings issued.  Results may not be reliable.

--------- my copy of the oops from the console -------------
CPU: 0
EIP: 0010 :[<d08b935e>]
EFLAGS: 00000086
eax: 00000026 ebx: cf71b800 ecx: 00000296 edx: 00000001
esi: 00000200 edi: cf716940 ebp: cf664000 esf: cf665dc0
ds: 0018 es: 0018 ss: 0018
process pump  (pid: 212, stack page = cf665000)
stack: [<c02d306c>] [<cf716800>] [<cfecfb0a>] [<c01dce0e>] [<cf71b800>]
       [<c01dd07d>] [<cf71b800>] [<cf716800>] [<cf665e18>] [<010000e0>]
       [<00000093>] [<ef626ed8>] [<00000086>] [<00000008>] [<cfecfb00>]
       [<c02041e6>] [<cf716800>] [<cf665e18>] [<00000006>] [<00000000>]
       [<cff15360>] [<c14f51e0>] [<005e0001>] [<cfff0100>]
Call Trace: [<c01dce0e>] [<c01dd03d>] [<c02041e6>] [<c0204266>] [<c0204266>]
            [<c0204344>] [<c020450f>] [<c020294b>] [<c012085a>] [<c01db3d3>]
            [<c01dc228>] [<c0202444>] [<c020d3f7>] [<c02041fb>] [<c01d742b>]
            [<c01d67ef>] [<c0143a36>] [<c01d678c>] [<c0108fdb>]
Code f3 30 7e f8 e9 10 fe ff ff 00 00 00 00 00 00 00 00 00 00 00

